cask "troke" do
  version "0.1.2"
  sha256 "5a818ea61d562f67e48edf1c993565a493a0e5e03c288676c965c23866227b62"

  url "https://github.com/ardvis/homebrew-tap/releases/download/troke-v#{version}/troke-macos-arm64.tar.gz"
  name "Troke"
  desc "Automated trading on Stockbit, managed from your iPhone"
  homepage "https://github.com/ardvis/homebrew-tap"

  depends_on macos: :golden_gate
  depends_on arch: :arm64

  app "Troke.app"

  # Homebrew quits Troke before it replaces or removes the app; trading
  # starts again when Troke is opened.
  uninstall quit: "com.ardvis.troke.app"

  zap trash: [
    "~/Library/Application Support/com.ardvis.troke.app",
    "~/Library/Caches/com.ardvis.troke.app",
    "~/Library/HTTPStorages/com.ardvis.troke.app",
    "~/Library/Preferences/com.ardvis.troke.app.plist",
    "~/Library/WebKit/com.ardvis.troke.app",
  ]
end
