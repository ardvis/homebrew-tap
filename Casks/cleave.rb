cask "cleave" do
  version "0.8.209"
  sha256 arm:          "7bd7f2a14bfc67b1dfcfc28549dbb220e52b4a5bdc4525c820d6a20f30d147c3"
  url "https://github.com/ardvis/homebrew-tap/releases/download/cleave-v#{version}/cleave-macos-arm64.tar.gz"

  depends_on macos: :golden_gate
  depends_on arch: :arm64
  depends_on cask: "font-fira-code"

  app "Cleave.app"

  postflight_steps do
    # Run the self-contained, signed CLI helper directly. Homebrew postflight
    # is sandboxed and has no interactive AppKit session; launching the SwiftUI
    # app would abort while NSApplication initializes.
    run "{{staged_path}}/Cleave.app/Contents/Helpers/cleave.app/Contents/MacOS/cleave",
        args:           ["setup", "--managed-only"],
        writable_paths: [".agents", ".claude", ".claude.json", ".codex", ".gemini"],
        writable_base:  :home
    # Cleave Node registers its own login item through SMAppService, from the
    # installed app, so Login Items lists it as Cleave Node. A sandboxed
    # process can't reach the service that records login items, so the step
    # runs in the unsandboxed parent Homebrew reserves for sudo: "if_needed".
    # A running Cleave Node replaces its program with this one in the same
    # process, so its terminals carry on. A refusal fails the step, and
    # Homebrew puts the previous version back.
    run "Cleave.app/Contents/Helpers/CleaveNode.app/Contents/MacOS/cleave-node",
        base: :appdir,
        args: ["--install"],
        sudo: "if_needed"
  end

  uninstall_preflight_steps do
    # Runs before the app stanza removes the app, because the bundle
    # unregisters its own login item. An upgrade runs it too, so a running
    # Cleave Node keeps its login item for the postflight to update in place.
    # An app the user already deleted must not stop the uninstall.
    run "Cleave.app/Contents/Helpers/CleaveNode.app/Contents/MacOS/cleave-node",
        base:         :appdir,
        args:         ["--uninstall"],
        sudo:         "if_needed",
        must_succeed: false
  end

  # Homebrew sends this on an uninstall only, never on an upgrade or a
  # reinstall: the running Cleave Node removes its own login item and quits,
  # ending its terminals.
  uninstall signal: [["USR2", "com.ardvis.cleave.node"]]

  name "Cleave"
  desc "Native workbench for coding agents, code, terminals and Screen Sharing"
  homepage "https://github.com/ardvis/homebrew-tap"

  binary "Cleave.app/Contents/Helpers/cleave.app/Contents/MacOS/cleave"
end
