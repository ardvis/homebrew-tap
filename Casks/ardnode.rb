cask "ardnode" do
  version "0.2.0"
  sha256 "c73f13f4c2c5ee42b9f7e8333d2b997b7082c6b19ab22367a51f529aa48bb998"

  url "https://github.com/ardvis/homebrew-tap/releases/download/ardnode-v#{version}/Ardnode-macos-arm64.zip"
  name "Ardnode"
  desc "Ardvis mesh host helper and Screen Sharing proxy"
  homepage "https://github.com/ardvis/homebrew-tap"

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
