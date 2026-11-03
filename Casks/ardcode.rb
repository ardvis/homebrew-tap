cask "ardcode" do
  version "0.8.193"
  sha256 arm:          "0b339bd7ab0d68c65c65e125f798809427b7a4b6c6d843d19a6bc80ea86aa955"
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
