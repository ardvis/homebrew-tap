cask "ardterm" do
  version "0.1.74"
  sha256 "51d2b7d0eaf0d264d25e1c203102ad02f95dd1693bc75245da36619e042f78b6"
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
