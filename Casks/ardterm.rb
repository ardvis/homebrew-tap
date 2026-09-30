cask "ardterm" do
  version "0.1.69"
  sha256 "ab9640f68f8805e69ffeceac06e99f41ee060e9360adbaff0d2d23678d8920b9"
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
