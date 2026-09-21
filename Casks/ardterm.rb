cask "ardterm" do
  version "0.1.51"
  sha256 "56f4c83adee3360d7b6d94188f990900a3b0a44eb7c38babe75c02e405115ff2"
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
