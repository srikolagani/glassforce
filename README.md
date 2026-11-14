<p align="center">
  <a href="https://srikolagani.github.io/glassforce/#gh-dark-mode-only">
    <img src="docs/brand/glassforce-hero.png" alt="Glassforce. Your org, one keystroke away." width="100%" />
  </a>
  <a href="https://srikolagani.github.io/glassforce/#gh-light-mode-only">
    <img src="docs/brand/glassforce-hero.png" alt="Glassforce. Your org, one keystroke away." width="100%" />
  </a>
</p>

<p align="center">
  <strong>Find the record. Keep your flow.</strong><br />
  A native macOS 26 command bar for Salesforce, built with Liquid Glass.<br />
  Press <kbd>⌥ Space</kbd> from any app, search your org, and open a record in Lightning.
</p>

<table align="center">
  <tr>
    <td align="center">
      <strong>Install with Homebrew</strong><br />
      <code>brew tap srikolagani/tap https://github.com/srikolagani/glassforce.git &amp;&amp; brew install --cask srikolagani/tap/glassforce</code>
    </td>
  </tr>
</table>

<p align="center">
  <a href="https://github.com/srikolagani/glassforce/releases/download/v0.1.0/Glassforce-0.1.0.dmg"><strong>Download for Mac (DMG) ↗</strong></a> &nbsp; · &nbsp;
  <a href="#install-status"><strong>Install with Homebrew</strong></a> &nbsp; · &nbsp;
  <a href="https://srikolagani.github.io/glassforce/">Visit the website</a> &nbsp; · &nbsp;
  <a href="ARCHITECTURE.md">Read the architecture</a>
</p>

<p align="center">
  <sub>macOS 26 Tahoe (Apple silicon &amp; Intel) · Swift 6.2 · Free and open source · OAuth 2.0 + PKCE</sub>
</p>

<p align="center">
  <a href="https://github.com/srikolagani/glassforce/releases/latest"><img src="https://img.shields.io/github/v/release/srikolagani/glassforce?style=flat-square&amp;labelColor=070B2E&amp;color=3D63F5&amp;label=release" alt="Latest release" /></a>
  <a href="https://github.com/srikolagani/glassforce"><img src="https://img.shields.io/github/stars/srikolagani/glassforce?style=flat-square&amp;labelColor=070B2E&amp;color=3D63F5&amp;logo=github" alt="GitHub stars" /></a>
  <img src="https://img.shields.io/badge/macOS-26-3D63F5?style=flat-square&amp;labelColor=070B2E" alt="Requires macOS 26" />
  <img src="https://img.shields.io/badge/Swift-6.2-3D63F5?style=flat-square&amp;labelColor=070B2E" alt="Swift 6.2" />
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-3D63F5?style=flat-square&amp;labelColor=070B2E" alt="MIT license" /></a>
  <a href="#install-status"><img src="https://img.shields.io/badge/homebrew-srikolagani%2Ftap-7B4DFF?style=flat-square&amp;labelColor=070B2E" alt="Homebrew: srikolagani/tap" /></a>
</p>

<br />

<a name="what-the-app-does"></a>
<h2 align="center">Your next record is a shortcut away.</h2>

<p align="center">
  Search by prefix, acronym, or a name you almost remember.<br />
  Move with the arrow keys. Press Return to open the result in Lightning.
</p>

<p align="center">
  <img src="docs/images/mock-search-eae6d2a.png" alt="Glassforce's command bar showing synthetic Acme search results and a selected opportunity with an inline preview. Scripted mock capture from eae6d2a, not a live Salesforce org." width="100%" />
</p>

<p align="center">
  <sub>Scripted mock capture from <code>eae6d2a</code>, using synthetic records.<br />
  The older capture says Sandbox and shows <code>127.0.0.1</code>. It is not a live-org test or a screenshot of the latest candidate.</sub>
</p>

<br />

<h2 align="center">Less hunting. More doing.</h2>

<p align="center">The record, its preview, and the next action in one panel.</p>

<table>
  <tr>
    <td width="50%" valign="top"><strong>Find it your way.</strong><br />Prefix, acronym, and typo matching over a local SQLite FTS cache.</td>
    <td width="50%" valign="top"><strong>Keep your hands on the keyboard.</strong><br />Open the selected record or copy its link from the <kbd>⌘ K</kbd> actions menu.</td>
  </tr>
  <tr>
    <td valign="top"><strong>See the change before it happens.</strong><br />A supported opportunity stage update shows the exact change. The app writes only after you click Confirm.</td>
    <td valign="top"><strong>Choose what you search.</strong><br />Settings lists eligible standard and custom objects from your org. Select which ones to sync and search.</td>
  </tr>
</table>

<p align="center">
  <sub>Stage updates re-read the confirmed field and use Salesforce’s time-based conditional update.<br />A conflict stops the update and requires a fresh confirmation. This is not an ETag-based version guarantee.</sub>
</p>

<details>
<summary><strong>The keys to know</strong></summary>
<br />

| Shortcut | Action |
| --- | --- |
| **⌥ Space** | Show the command bar from any app. |
| **↑ / ↓** | Move through search results. |
| **Return** | Open the selected record in Lightning. |
| **⌘ K** | Show Open and Copy Link actions. |
| **⌘ C** | Copy the selected record link when the search field has no text selection. |
| **⌘ ,** | Open Settings. |
| **Esc** | Dismiss the panel. |

To move a window, drag the search icon in the command bar or the top edge of the setup card. Text fields and action buttons keep their normal click behavior.

</details>

<br />

<a name="benchmarks"></a>
<h2 align="center">Measured, not promised.</h2>

<p align="center">We benchmark search latency across 10,000 synthetic Salesforce records and run 213 automated checks on every build.</p>

<table align="center">
  <tr>
    <td align="center" valign="top" width="25%"><h1>1.14 ms</h1><strong>median search (p50)</strong><br /><sub>10,000 synthetic records</sub></td>
    <td align="center" valign="top" width="25%"><h1>2.07 ms</h1><strong>95th percentile (p95)</strong><br /><sub>321 benchmark queries</sub></td>
    <td align="center" valign="top" width="25%"><h1>213</h1><strong>automated tests</strong><br /><sub>39 suites passing</sub></td>
    <td align="center" valign="top" width="25%"><h1>0</h1><strong>unconfirmed writes</strong><br /><sub>every write requires Confirm</sub></td>
  </tr>
</table>

<p align="center">
  <a href="docs/how-to-test.md">How we measured this</a> · <a href="#verification-and-packaging">Run the benchmarks yourself</a><br />
  <sub>Release build on Apple Silicon over 10,000 synthetic records. Local benchmark results, not a network guarantee.</sub>
</p>

<br />

<a name="under-the-hood"></a>
<h2 align="center">Under the hood.</h2>

<p align="center">One native macOS process, a local SQLite FTS5 index, and direct HTTPS connections to your Salesforce org.</p>

```mermaid
flowchart TB
  you(["You<br/>⌥ Space · keyboard · mouse"]):::blue
  app["Glassforce.app<br/>SwiftUI Liquid Glass · AppSession<br/>FuzzyMatcher · WriteCommand"]:::blue
  you --> app
  app --> fts[("SQLite FTS5<br/>local record cache")]
  app --> kc["macOS Keychain<br/>device-only refresh token"]
  app -- "OAuth 2.0 + PKCE<br/>validated org host" --> sf["Your Salesforce Org<br/>Lightning REST API"]
  classDef blue fill:#3D63F5,stroke:#070B2E,color:#FFFFFF
```

- **Destination-bound credentials.** Refresh tokens live in this device's macOS Keychain, not iCloud Keychain. Access tokens stay in memory and are restricted to the bound org's validated Salesforce host and identity endpoint.
- **Conditional stage updates.** Before sending a `PATCH`, Glassforce re-reads the live field and `LastModifiedDate` and attaches `If-Unmodified-Since`. Stale values or conflicts cancel the write and ask for a fresh confirmation.
- **Built with** Swift 6.2, SwiftUI with macOS 26 Liquid Glass, AppKit `NSPanel`, Carbon `RegisterEventHotKey`, SQLite FTS5, and `ASWebAuthenticationSession`.

<p align="center">
  <a href="ARCHITECTURE.md">Architecture</a> · <a href="SECURITY.md">Security model</a> · <a href="docs/how-to-test.md">Test guide</a>
</p>

<br />

<a name="privacy"></a>
<h2 align="center">Your Mac. Your org. A clear connection.</h2>

<p align="center">Sign in to Salesforce with OAuth and PKCE. Choose the org before the first sync.</p>

- **Credentials stay separate.** Refresh tokens live in this device's macOS Keychain, not iCloud Keychain. Access tokens stay in memory. Tokens are not stored with records.
- **Search runs on a local cache.** Synced record fields live in SQLite and JSON under `~/Library/Application Support/Glassforce`. This cache is **not application-encrypted** and may contain sensitive org data.
- **No telemetry.** The app has no analytics, crash reporting, or third-party SDKs.
- **Salesforce handles sign-in.** Glassforce does not collect your Salesforce password or MFA codes. Normal sign-in, sync, and update flows use Salesforce endpoints. Credential-bearing requests are restricted to the selected org’s validated Salesforce instance and exact identity endpoint; automatic HTTP redirects are refused.

<p align="center">
  <a href="ARCHITECTURE.md">How it works</a> · <a href="SECURITY.md">Security and reporting</a>
</p>

<br />

<a name="straight-answers"></a>
<h2 align="center">Straight answers.</h2>

<details>
<summary><strong>What does it cost?</strong></summary>
<br />

Glassforce is free and open source under the [MIT License](LICENSE). You connect it to your own Salesforce org.

</details>

<details>
<summary><strong>Where does my Salesforce data go?</strong></summary>
<br />

Synced record fields stay on your Mac under `~/Library/Application Support/Glassforce` in SQLite and JSON so search stays under a few milliseconds. Refresh tokens stay in your macOS login Keychain (`kSecAttrSynchronizable = false`). Glassforce has no backend server and sends no telemetry.

</details>

<details>
<summary><strong>Can it change records in my org without asking?</strong></summary>
<br />

No. Sync and search are read-only. The only supported write is an opportunity stage update, which previews the exact before-and-after values in the panel and sends the `PATCH` only after you click **Confirm**.

</details>

<details>
<summary><strong>Why does macOS ask to approve the app on first launch?</strong></summary>
<br />

Candidate builds are **ad-hoc signed** unless built with a Developer ID certificate and notarization profile. Leave Gatekeeper and quarantine enabled, and approve the app in **System Settings → Privacy & Security → Open Anyway** if prompted.

</details>

<br />

<a name="install-status"></a>
<h2 align="center">Get Glassforce.</h2>

<p align="center">
  Install via the personal Homebrew tap, or build directly from source on <strong>macOS 26</strong>.
</p>

```sh
brew tap srikolagani/tap https://github.com/srikolagani/glassforce.git
brew trust srikolagani/tap # if using Homebrew 7+
brew install --cask srikolagani/tap/glassforce
```

Candidate builds are **ad-hoc signed** unless a Developer ID signature and notarization profile are supplied at packaging time. macOS may require approval in **System Settings → Privacy & Security → Open Anyway**. Leave Gatekeeper and quarantine enabled.

<details>
<summary><strong>Build from source</strong></summary>
<br />

Build locally on **macOS 26** with **Xcode 26** or the **Swift 6.2 Command Line Tools**:

```sh
git clone https://github.com/srikolagani/glassforce.git
cd glassforce
GLASSFORCE_SIGN_IDENTITY=- scripts/build-app.sh release
open build/Glassforce.app
```

The first build can take a few minutes. This command builds an **ad-hoc signed app** without creating a certificate, changing Keychain settings, or replacing an installed app. It does not imply a Developer ID signature or notarization.

If SwiftPM reports `reference to member 'v26'` or `undefined symbol Package.__allocating_init`, the Command Line Tools may have stale private interface files. Reinstall the tools, or use a cleaned copy without changing the installed toolchain:

```sh
PM="$HOME/Library/Caches/glassforce-swiftpm"
mkdir -p "$PM"
cp -R /Library/Developer/CommandLineTools/usr/lib/swift/pm/ManifestAPI /Library/Developer/CommandLineTools/usr/lib/swift/pm/PluginAPI "$PM"/
find "$PM" -name '*.private.swiftinterface' -delete
export SWIFTPM_CUSTOM_LIBS_DIR="$PM"
GLASSFORCE_SIGN_IDENTITY=- scripts/build-app.sh release
```

</details>

<br />

<a name="connect-your-org"></a>
<h2 align="center">Connect your org. Make it your own.</h2>

<p align="center">An admin installs the Glassforce package once per Salesforce org.<br />Each user signs in and confirms the org shown by the app.</p>

1. Press **⌥ Space** or choose **Search Salesforce** from the menu bar, then choose **Get Started**.
2. Choose **Production**, **Sandbox**, or your Salesforce **My Domain**. An admin installs the Glassforce package. If it is already installed, choose **Skip**.
3. Choose **Connect**, sign in to Salesforce, and click **Allow**.
4. Check the **org name, username, and instance host**. Choose **Use this org** to save the OAuth sign-in in Keychain and start syncing. Choose **Sign in to a different org** if the card is wrong.
5. When sync finishes, search with **⌥ Space**. Use the gear in the panel or **⌘ ,** to change searchable objects.

<br />

<a name="verification-and-packaging"></a>
<h2 align="center">Know what has been tested.</h2>

<p align="center">
  This repository contains a sanitized source snapshot and synthetic fixtures.<br />
  Native tests use mocks. They do not certify package installation or Salesforce writes in your org.
</p>

<details>
<summary><strong>Run the checks and package a candidate</strong></summary>
<br />

```sh
scripts/test.sh
scripts/bench.sh
scripts/release.sh
```

Release packaging requires a **clean Git checkout**. It produces an ad-hoc signed DMG, checksums, and generated casks in `build/release` without publishing or changing tracked source. The DMG has an Applications shortcut; drag Glassforce into Applications to install.

See the [release-candidate test guide](docs/how-to-test.md) for automated checks, an isolated panel smoke test, installer checks, and manual acceptance.

</details>

<p align="center">
  <a href="docs/how-to-test.md">Test guide</a> · <a href="ARCHITECTURE.md">Architecture</a> · <a href="CHANGELOG.md">Changelog</a>
</p>

<br />

<a name="build-with-us"></a>
<h2 align="center">Build with us.</h2>

<p align="center">
  Glassforce is open source under the MIT license.<br />
  Read <a href="CONTRIBUTING.md">CONTRIBUTING</a> to build, test, and send a change.
</p>

<p align="center">
  <a href="https://github.com/srikolagani/glassforce/issues/new/choose">Report a bug</a> ·
  <a href="SECURITY.md">Report a vulnerability</a> ·
  <a href="CODE_OF_CONDUCT.md">Code of conduct</a>
</p>

<br />

<a name="license"></a>
<p align="center">
  <sub>Copyright 2026 Sri Kolagani · <a href="LICENSE">MIT License</a><br />
  Glassforce is independent software and is not affiliated with, sponsored by, or endorsed by Salesforce, Inc.<br />
  Salesforce is a trademark of Salesforce, Inc.</sub>
</p>
