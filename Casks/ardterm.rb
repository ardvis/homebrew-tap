cask "ardterm" do
  version "0.1.61"
  sha256 "0469b46cb0da16577a61c4da23b9cd43735ed71b5e2da2e007e37c167facc3a5"
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
