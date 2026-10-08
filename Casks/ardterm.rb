cask "ardterm" do
  version "0.1.92"
  sha256 "c0931ce27a6e59c071c8e272357a346a6ee23ddeaff18a1205dc3c2d4e7e2026"
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
