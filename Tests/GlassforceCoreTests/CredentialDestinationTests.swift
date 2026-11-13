import Foundation
import Testing
@testable import GlassforceCore

@Suite("Credential destination binding")
struct CredentialDestinationTests {
    @Test func rejectsOtherOrgAndUntrustedDestinationsWithoutSendingSecrets() async throws {
        for address in ["https://evil.example/services/data/v62.0/query", "https://other.my.salesforce.com/services/data/v62.0/query", "http://acme.my.salesforce.com/services/data/v62.0/query", "https://acme.my.salesforce.com@evil.example/services/data/v62.0/query", "https://acme.my.salesforce.com/id/OTHER/USER"] {
            let transport = StubTransport { _, _ in tokenJSON(access: "AT", refresh: "RT") }
            let tokens = TokenManager(transport: transport, store: try seededStore())
            await #expect(throws: (any Error).self) {
                _ = try await tokens.authorizedSend(orgKey, HTTPRequest(url: URL(string: address)!))
            }
            #expect(transport.requests.isEmpty)
        }
    }
    @Test func rejectsSwappedStoredIdentityBeforeRefresh() async throws {
        let store = try seededStore()
        try store.write(try #require(try store.read(account: orgKey)), account: "OTHER:USER")
        let transport = StubTransport { _, _ in tokenJSON(access: "AT", refresh: "RT") }
        let tokens = TokenManager(transport: transport, store: store)
        await #expect(throws: (any Error).self) { _ = try await tokens.refresh("OTHER:USER") }
        #expect(transport.requests.isEmpty)
    }
    @Test func rejectsChangedRefreshIdentityWithoutSaving() async throws {
        let store = try seededStore()
        let transport = StubTransport { _, _ in
            HTTPResponse(status: 200, body: Data(#"{"access_token":"AT","refresh_token":"CHANGED","instance_url":"https://acme.my.salesforce.com","id":"https://login.salesforce.com/id/OTHER/USER"}"#.utf8))
        }
        let tokens = TokenManager(transport: transport, store: store)
        await #expect(throws: (any Error).self) { _ = try await tokens.refresh(orgKey) }
        #expect(try await tokens.credentials(for: orgKey)?.refreshToken == "RT1")
    }
    @Test func pendingSignInAllowsOnlyBoundIdentityBeforeCommit() async throws {
        let transport = StubTransport { request, _ in request.url.path.hasSuffix("/token") ? tokenJSON(access: "AT", refresh: "RT") : HTTPResponse(status: 200) }
        let tokens = TokenManager(transport: transport, store: InMemorySecretStore())
        let request = AuthorizationRequest(loginURL: LoginEnvironment.production.loginURL, config: OAuthConfig(consumerKey: "KEY"))
        let signIn = try await tokens.exchangeSignIn(request, code: "CODE")
        _ = try await tokens.authorizedSend(orgKey, HTTPRequest(url: signIn.credentials.idURL))
        #expect(transport.requests.last?.headers["Authorization"] == "Bearer AT")
    }
    @Test func rejectsMaliciousTokenEndpointsBeforeIdentityCall() async throws {
        for address in ["https://evil.example", "http://acme.my.salesforce.com", "https://acme.my.salesforce.com.evil.example"] {
            let transport = StubTransport { _, _ in
                HTTPResponse(status: 200, body: try! JSONSerialization.data(withJSONObject: ["access_token": "AT", "refresh_token": "RT", "instance_url": address, "id": "https://login.salesforce.com/id/00DORG/005USER"]))
            }
            let store = InMemorySecretStore()
            let tokens = TokenManager(transport: transport, store: store)
            let request = AuthorizationRequest(loginURL: LoginEnvironment.production.loginURL, config: OAuthConfig(consumerKey: "KEY"))
            await #expect(throws: (any Error).self) { _ = try await tokens.exchangeSignIn(request, code: "CODE") }
            #expect(transport.requests.count == 1)
            #expect(store.accounts.isEmpty)
        }
    }
    @Test func loopbackRequiresExplicitIsolation() throws {
        let url = URL(string: "http://127.0.0.1:7777")!
        #expect(throws: (any Error).self) { try CredentialDestination.validateBase(url, allowsLoopback: false) }
        try CredentialDestination.validateBase(url, allowsLoopback: true)
        #expect(OrgIdentity(idURL: URL(string: "https://login.salesforce.com/id/ORG/USER/extra")!) == nil)
    }
}
