cask "ardnode" do
  version "0.1.1"
  sha256 "3af0b1764985936c6a1e86a6d2e6b126521e32aa800342425ef5b40333ee6f2e"

  url "https://github.com/ardvis/ardnode-dist/releases/download/v#{version}/Ardnode-macos-arm64.zip"
  name "Ardnode"
  desc "Ardvis mesh host helper and Screen Sharing proxy"
  homepage "https://github.com/ardvis/ardnode-dist"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  artifact "Ardnode.app", target: "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app"

  postflight_steps do
    # The app registers its own login item through SMAppService, so the system
    # lists it as "Ardnode" instead of the Developer ID team. A sandboxed
    # process cannot reach the service that records login items, so the step
    # runs in the unsandboxed parent Homebrew reserves for sudo: "if_needed".
    run "Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/MacOS/ardnode",
        base: :home,
        args: ["--register-agent"],
        sudo: "if_needed"
  end

  uninstall_preflight_steps do
    # Runs before the artifact stanza removes the app, because the bundle
    # unregisters its own login item. An app the user already deleted must not
    # stop the uninstall.
    run "Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/MacOS/ardnode",
        base:         :home,
        args:         ["--unregister-agent"],
        sudo:         "if_needed",
        must_succeed: false
  end
end
