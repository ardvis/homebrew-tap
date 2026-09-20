cask "ardterm" do
  version "0.1.47"
  sha256 "102d3959c0b71c4f42892a93976f4b188bdc948c7ddde6f3ab48fd1a9896157f"
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
