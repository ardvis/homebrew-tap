cask "ardterm" do
  version "0.1.42"
  sha256 "c090931a27ce615afbf680b21f0e8f1d6f499992221e57e2be69e1e5cef08c8f"
  url "https://github.com/ardvis/homebrew-tap/releases/download/ardterm-v#{version}/Ardterm-macos-arm64.zip"
  name "Ardterm"
  desc "Native macOS terminal with authenticated remote sessions"
  homepage "https://github.com/ardvis/homebrew-tap"
  depends_on cask: "font-fira-code"
  depends_on cask: "ardnode"
  depends_on macos: :tahoe
  depends_on arch: :arm64
  app "Ardterm.app"
end
