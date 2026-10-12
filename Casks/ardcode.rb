cask "ardcode" do
  version "0.8.144"
  sha256 arm:          "4ac127b5f7f32a60ac7ba164b7be97ffb6a49c1a452ac3256e1b8b640ab865f9"
  url "https://github.com/ardvis/homebrew-tap/releases/download/ardcode-v#{version}/ardcode-macos-arm64.tar.gz"

  depends_on macos: :golden_gate
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
