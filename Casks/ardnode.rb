cask "ardnode" do
  version "0.3.79"
  sha256 "4c2784e94f323f5d3c5ab0644899ff98a56594eaff1adf2d172dc8514de7d44c"

  url "https://github.com/ardvis/homebrew-tap/releases/download/ardnode-v#{version}/Ardnode-macos-arm64.zip"
  name "Ardnode"
  desc "Ardvis mesh host helper and Screen Sharing proxy"
  homepage "https://github.com/ardvis/homebrew-tap"

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  artifact "Ardnode.app", target: "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app"

  postflight_steps do
    # The app registers its own login item through SMAppService, so the system
    # lists it as "Ardnode" instead of the Developer ID team. A sandboxed
    # process cannot reach the service that records login items, so the step
    # runs in the unsandboxed parent Homebrew reserves for sudo: "if_needed".
    # A running Ardnode then replaces its program with this one in the same
    # process, so its terminals, and the agents working in them, carry on. A
    # refusal fails the step, and Homebrew puts the previous version back.
    run "Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/MacOS/ardnode",
        base: :home,
        args: ["--install"],
        sudo: "if_needed"
  end

  uninstall_preflight_steps do
    # Runs before the artifact stanza removes the app, because the bundle
    # unregisters its own login item. An upgrade runs it too, so a running
    # Ardnode keeps its login item for the postflight to update in place. An
    # app the user already deleted must not stop the uninstall.
    run "Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/MacOS/ardnode",
        base:         :home,
        args:         ["--uninstall"],
        sudo:         "if_needed",
        must_succeed: false
  end

  # Homebrew sends this on an uninstall only, never on an upgrade or a
  # reinstall: the running Ardnode, the login item or an instance an app
  # opened, removes its own login item and quits, ending its terminals.
  uninstall signal: [
    ["USR2", "com.ardvis.ardnode.helper"],
    ["USR2", "com.ardvis.ardnode.app.apple"],
  ]
end
