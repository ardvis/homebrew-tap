cask "ardterm" do
  version "0.1.87"
  sha256 "ac060046ea40bf1956ccd5ebd52a884e39435b5d6c5379d411a673adedbc6c7a"
  url "https://github.com/ardvis/homebrew-tap/releases/download/ardterm-v#{version}/Ardterm-macos-arm64.zip"
  name "Ardterm"
  desc "Native macOS terminal with authenticated remote sessions"
  homepage "https://github.com/ardvis/homebrew-tap"
  depends_on cask: "font-fira-code"
  depends_on cask: "ardnode"
  depends_on macos: :golden_gate
  depends_on arch: :arm64
  app "Ardterm.app"
end
