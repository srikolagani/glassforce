# frozen_string_literal: true

# Personal tap cask for srikolagani/tap (hosted in srikolagani/glassforce-public).
# Not for homebrew/cask. The app is ad-hoc signed unless a
# Developer ID was supplied via GLASSFORCE_SIGN_IDENTITY.
# Do not install with --no-quarantine. An ad-hoc app is approved by the user
# in System Settings > Privacy & Security > Open Anyway.
cask "glassforce" do
  version "0.1.0"
  sha256 "ab242d4f0fa5618e2a8f7765bc7f9b6dfcc9f32f5ab394f2c2606b17da08e5f5"

  url "https://github.com/srikolagani/glassforce-public/releases/download/v0.1.0/Glassforce-0.1.0.dmg"
  name "Glassforce"
  desc "Native macOS command bar for Salesforce"
  homepage "https://srikolagani.github.io/glassforce-public/"

  depends_on macos: :tahoe

  app "Glassforce.app"

  zap trash: [
    "~/Library/Application Support/Glassforce",
    "~/Library/Logs/Glassforce",
    "~/Library/Preferences/com.srikolagani.glassforce.plist",
  ]
end
