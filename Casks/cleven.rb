cask "cleven" do
  version "0.8.238"
  sha256 arm:          "5d6c6f032dc80088a6076018db99b57c522b92d930ee8917695066367f2df50c"
  url "https://github.com/ardvis/homebrew-tap/releases/download/cleven-v#{version}/cleven-macos-arm64.tar.gz"

  depends_on macos: :golden_gate
  depends_on arch: :arm64
  depends_on cask: "font-fira-code"

  app "Cleven.app"

  postflight_steps do
    # Run the self-contained, signed CLI helper directly. Homebrew postflight
    # is sandboxed and has no interactive AppKit session; launching the SwiftUI
    # app would abort while NSApplication initializes.
    run "{{staged_path}}/Cleven.app/Contents/Helpers/cleven.app/Contents/MacOS/cleven",
        args:           ["setup", "--managed-only"],
        writable_paths: [".agents", ".claude", ".claude.json", ".codex", ".gemini"],
        writable_base:  :home
    # Cleven Node registers its own login item through SMAppService, from the
    # installed app, so Login Items lists it as Cleven Node. A sandboxed
    # process can't reach the service that records login items, so the step
    # runs in the unsandboxed parent Homebrew reserves for sudo: "if_needed".
    # A running Cleven Node replaces its program with this one in the same
    # process, so its terminals carry on. A refusal fails the step, and
    # Homebrew puts the previous version back.
    run "Cleven.app/Contents/Helpers/ClevenNode.app/Contents/MacOS/cleven-node",
        base: :appdir,
        args: ["--install"],
        sudo: "if_needed"
  end

  uninstall_preflight_steps do
    # Runs before the app stanza removes the app, because the bundle
    # unregisters its own login item. An upgrade runs it too, so a running
    # Cleven Node keeps its login item for the postflight to update in place.
    # An app the user already deleted must not stop the uninstall.
    run "Cleven.app/Contents/Helpers/ClevenNode.app/Contents/MacOS/cleven-node",
        base:         :appdir,
        args:         ["--uninstall"],
        sudo:         "if_needed",
        must_succeed: false
  end

  # Homebrew sends this on an uninstall only, never on an upgrade or a
  # reinstall: the running Cleven Node removes its own login item and quits,
  # ending its terminals.
  uninstall signal: [["USR2", "com.ardvis.cleven.app.node"]]

  name "Cleven"
  desc "Native workbench for coding agents, code, terminals and Screen Sharing"
  homepage "https://github.com/ardvis/homebrew-tap"

  binary "Cleven.app/Contents/Helpers/cleven.app/Contents/MacOS/cleven"
end
