cask "teleport-desktop" do
  arch arm: "arm64", intel: "x86_64"

  version "0.6.1"
  sha256 arm:   "150aa75ebd30ab36483e8bbfd67406ac6e4d82ff9cbb93ae24b8a13c30fba942",
         intel: "64b4a4e097cb78bc6424ffed1b13d83e3dc7e30f694bb97f9e8d011a84d63459"

  url "https://github.com/ejb1123/teleport/releases/download/v#{version}/Teleport-#{version}-#{arch}.dmg"
  name "Teleport"
  desc "Remote desktop client for Linux hosts over Media over QUIC"
  homepage "https://github.com/ejb1123/teleport"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Teleport.app"
  binary "#{appdir}/Teleport.app/Contents/MacOS/teleport", target: "teleport-desktop"

  zap trash: [
    "~/Library/Application Support/Teleport",
    "~/Library/Caches/Teleport",
    "~/Library/Preferences/dev.teleport.Teleport.plist",
    "~/Library/Saved Application State/dev.teleport.Teleport.savedState",
  ]

  caveats <<~EOS
    Unless this release was notarised, Teleport.app is only ad-hoc signed and
    macOS refuses to open it. Right-click Teleport in Applications and choose
    Open, or run:
      xattr -dr com.apple.quarantine #{appdir}/Teleport.app

    The command-line client is linked as `teleport-desktop`.
  EOS
end
