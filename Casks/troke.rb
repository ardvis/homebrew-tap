cask "troke" do
  version "0.1.1"
  sha256 "e4fd16b132990e06e27419c7dfcd453ee65a8543cfe22f9b572ee0347f853a27"

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
