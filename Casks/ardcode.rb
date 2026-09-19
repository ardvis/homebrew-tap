cask "ardcode" do
  version "0.8.75"
  sha256 arm:          "831678d6b1dee35dd7458da29b561721d6079500ee923281ca1c5320ebbe5e49"
  url "https://github.com/ardvis/homebrew-tap/releases/download/ardcode-v#{version}/ardcode-macos-arm64.tar.gz"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  depends_on cask: "font-fira-code"
  depends_on cask: "ardnode"

  app "Ardcode.app"

  postflight_steps do
    # Run the self-contained, signed CLI helper directly. Homebrew postflight
    # is sandboxed and has no interactive AppKit session; launching the SwiftUI
    # app would abort while NSApplication initializes.
    run "{{staged_path}}/Ardcode.app/Contents/Helpers/ardcode.app/Contents/MacOS/ardcode",
        args:           ["setup", "--managed-only"],
        writable_paths: [".agents", ".claude", ".claude.json", ".codex", ".gemini"],
        writable_base:  :home
  end

  name "Ardcode"
  desc "Native code editor with indexed exploration and MCP integration"
  homepage "https://github.com/ardvis/homebrew-tap"

  binary "Ardcode.app/Contents/Helpers/ardcode.app/Contents/MacOS/ardcode"
end
