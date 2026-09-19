cask "ardterm" do
  version "0.1.32"
  sha256 "bdd821a41cbea4aad32edf7b365906e0f3c51ab9dee1b87fdabc6a69a54d9554"
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
