cask "cleaves" do
  version "0.8.214"
  sha256 arm:          "91bd493380b1a56851d693aa77a155bc23401b48a4b055c4f57ba0155e8d6db0"
  url "https://github.com/ardvis/homebrew-tap/releases/download/cleaves-v#{version}/cleaves-macos-arm64.tar.gz"

  depends_on macos: :golden_gate
  depends_on arch: :arm64
  depends_on cask: "font-fira-code"

  app "Cleaves.app"

  postflight_steps do
    # Run the self-contained, signed CLI helper directly. Homebrew postflight
    # is sandboxed and has no interactive AppKit session; launching the SwiftUI
    # app would abort while NSApplication initializes.
    run "{{staged_path}}/Cleaves.app/Contents/Helpers/cleaves.app/Contents/MacOS/cleaves",
        args:           ["setup", "--managed-only"],
        writable_paths: [".agents", ".claude", ".claude.json", ".codex", ".gemini"],
        writable_base:  :home
    # Cleaves Node registers its own login item through SMAppService, from the
    # installed app, so Login Items lists it as Cleaves Node. A sandboxed
    # process can't reach the service that records login items, so the step
    # runs in the unsandboxed parent Homebrew reserves for sudo: "if_needed".
    # A running Cleaves Node replaces its program with this one in the same
    # process, so its terminals carry on. A refusal fails the step, and
    # Homebrew puts the previous version back.
    run "Cleaves.app/Contents/Helpers/CleavesNode.app/Contents/MacOS/cleaves-node",
        base: :appdir,
        args: ["--install"],
        sudo: "if_needed"
  end

  uninstall_preflight_steps do
    # Runs before the app stanza removes the app, because the bundle
    # unregisters its own login item. An upgrade runs it too, so a running
    # Cleaves Node keeps its login item for the postflight to update in place.
    # An app the user already deleted must not stop the uninstall.
    run "Cleaves.app/Contents/Helpers/CleavesNode.app/Contents/MacOS/cleaves-node",
        base:         :appdir,
        args:         ["--uninstall"],
        sudo:         "if_needed",
        must_succeed: false
  end

  # Homebrew sends this on an uninstall only, never on an upgrade or a
  # reinstall: the running Cleaves Node removes its own login item and quits,
  # ending its terminals.
  uninstall signal: [["USR2", "com.ardvis.cleaves.node"]]

  name "Cleaves"
  desc "Native workbench for coding agents, code, terminals and Screen Sharing"
  homepage "https://github.com/ardvis/homebrew-tap"

  binary "Cleaves.app/Contents/Helpers/cleaves.app/Contents/MacOS/cleaves"
end
