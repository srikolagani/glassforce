import Foundation

/// Fail closed before attaching a credential. Loopback is an explicit isolated-QA option.
enum CredentialDestination {
    static func validateBase(_ url: URL, allowsLoopback: Bool) throws {
        guard url.user == nil, url.password == nil, url.fragment == nil,
              let host = url.host?.lowercased() else { throw rejected }
        if allowsLoopback && host == "127.0.0.1" && url.scheme == "http" { return }
        let suffixes = [".salesforce.com", ".force.com", ".salesforce.mil", ".cloudforce.com", ".salesforce-setup.com"]
        guard url.scheme == "https", url.port == nil || url.port == 443,
              suffixes.contains(where: host.hasSuffix) else { throw rejected }
    }

    static func validate(_ credentials: OrgCredentials, org: String, allowsLoopback: Bool) throws {
        for url in [credentials.loginURL, credentials.instanceURL, credentials.idURL] {
            try validateBase(url, allowsLoopback: allowsLoopback)
        }
        guard OrgIdentity(idURL: credentials.idURL)?.key == org else { throw rejected }
        let urls = [credentials.loginURL, credentials.instanceURL, credentials.idURL]
        if urls.contains(where: { $0.host == "127.0.0.1" }) {
            guard urls.allSatisfy({ origin($0) == origin(credentials.loginURL) }) else { throw rejected }
        } else {
            guard credentials.loginURL.query == nil, credentials.instanceURL.query == nil,
                  credentials.instanceURL.path.isEmpty || credentials.instanceURL.path == "/" else { throw rejected }
        }
    }

    static func authorize(_ url: URL, credentials: OrgCredentials, allowsLoopback: Bool) throws {
        try validateBase(url, allowsLoopback: allowsLoopback)
        // Identity access is limited to this exact user's identity endpoint, never another org's.
        if url == credentials.idURL { return }
        guard origin(url) == origin(credentials.instanceURL) else { throw rejected }
        let base = credentials.instanceURL.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let prefix = base.isEmpty ? "/services/data/" : "/" + base + "/services/data/"
        guard url.path.hasPrefix(prefix) || url.path == String(prefix.dropLast()) else { throw rejected }
    }

    private static func origin(_ url: URL) -> String {
        "\(url.scheme ?? "")://\(url.host?.lowercased() ?? ""):\(url.port ?? (url.scheme == "https" ? 443 : 80))"
    }
    private static var rejected: AuthError { .server("Credential destination does not match the selected Salesforce org") }
}
