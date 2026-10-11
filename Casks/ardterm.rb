cask "ardterm" do
  version "0.1.106"
  sha256 "f2f28c80e819b0be1d1cec2a9fa9eeb3dbb8a95c1131a87fc4ecc78cd5b7c41c"
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
