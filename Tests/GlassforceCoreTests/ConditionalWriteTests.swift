import Foundation
import Testing
@testable import GlassforceCore

@Suite("Server-conditional writes")
struct ConditionalWriteTests {
    private func run(stage: String = "Negotiation", timestamp: String? = "2026-11-10T12:00:00.000Z", patchStatus: Int = 204) async throws -> [HTTPRequest] {
        let transport = StubTransport { request, _ in
            if request.url.path.hasSuffix("/token") { return tokenJSON(access: "AT", refresh: nil) }
            if request.method == "PATCH" { return HTTPResponse(status: patchStatus) }
            var row = ["StageName": stage]
            row["LastModifiedDate"] = timestamp
            return HTTPResponse(status: 200, body: try! JSONSerialization.data(withJSONObject: row))
        }
        let client = SalesforceClient(tokens: TokenManager(transport: transport, store: try seededStore()))
        do {
            try await client.updateField(org: orgKey, instanceURL: URL(string: "https://acme.my.salesforce.com")!, object: "Opportunity", id: "006ACME", field: "StageName", value: "Closed Won", expectedBefore: "Negotiation")
            #expect(stage == "Negotiation" && timestamp != nil && patchStatus == 204)
        } catch let error as QueryError {
            if stage != "Negotiation" || patchStatus == 412 { #expect(error.status == 412) }
            else { #expect(error.status == 409) }
        }
        return transport.requests
    }

    @Test func unchangedVersionSendsConditionalPatch() async throws {
        let requests = try await run()
        let patch = try #require(requests.first { $0.method == "PATCH" })
        #expect(patch.headers["If-Unmodified-Since"] == "Tue, 10 Nov 2026 12:00:00 GMT")
        #expect(requests.filter { $0.method == "PATCH" }.count == 1)
    }

    @Test func changedBeforeValueNeverPatches() async throws {
        let requests = try await run(stage: "Closed Lost")
        #expect(!requests.contains { $0.method == "PATCH" })
    }

    @Test func missingOrMalformedVersionNeverPatches() async throws {
        for stamp in [nil, "not a date"] as [String?] {
            let requests = try await run(timestamp: stamp)
            #expect(!requests.contains { $0.method == "PATCH" })
        }
    }

    @Test func serverConflictDoesNotRetry() async throws {
        let requests = try await run(patchStatus: 412)
        #expect(requests.filter { $0.method == "PATCH" }.count == 1)
    }

    @Test func timestampNeverRoundsForward() {
        #expect(SalesforceClient.unmodifiedSinceHeader("2026-11-10T12:00:00.999Z") == "Tue, 10 Nov 2026 12:00:00 GMT")
        #expect(SalesforceClient.unmodifiedSinceHeader("invalid") == nil)
    }
}
