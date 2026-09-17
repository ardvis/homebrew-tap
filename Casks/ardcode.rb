cask "ardcode" do
  version "0.8.56"
  sha256 arm:          "d2c8c7d9d63e41fecb0b96d99951e6e72dacc9192ce0b715f8afcf80a6651f83"

  on_macos do
    url "https://github.com/ardvis/ardcode-dist/releases/download/v#{version}/ardcode-macos-arm64.tar.gz"
    depends_on macos: :tahoe
    depends_on arch: :arm64
    depends_on cask: "font-fira-code"
    depends_on cask: "ardnode"
    app "Ardcode.app"
  end

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
  homepage "https://github.com/ardvis/ardcode-dist"

  binary "Ardcode.app/Contents/Helpers/ardcode.app/Contents/MacOS/ardcode"

end
