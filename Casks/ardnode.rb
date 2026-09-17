cask "ardnode" do
  version "0.1.0"
  sha256 "b24a4a5b99d2bfefb84ca74cd481293b92140b03e9d0a4e7e58a2843f6779722"

  url "https://github.com/ardvis/ardnode-dist/releases/download/v#{version}/Ardnode-macos-arm64.zip"
  name "Ardnode"
  desc "Ardvis mesh host helper and Screen Sharing proxy"
  homepage "https://github.com/ardvis/ardnode-dist"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  artifact "Ardnode.app", target: "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app"

  postflight_steps do
    # Homebrew runs install steps inside a sandbox, and sandbox-exec blocks
    # launchctl from reaching launchd. A step marked `sudo: "if_needed"` is
    # brokered to the unsandboxed parent process, which still runs it without
    # privilege escalation, so the helper can be bootstrapped there.
    mkdir_p "#{Dir.home}/Library/LaunchAgents"
    mkdir_p "#{Dir.home}/Library/Logs/Ardvis"
    copy "Ardnode.app/Contents/Resources/com.ardvis.ardnode.helper.plist",
         "#{Dir.home}/Library/LaunchAgents/com.ardvis.ardnode.helper.plist"
    inreplace "#{Dir.home}/Library/LaunchAgents/com.ardvis.ardnode.helper.plist",
              "__HELPER_PATH__",
              "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/MacOS/ardnode"
    inreplace "#{Dir.home}/Library/LaunchAgents/com.ardvis.ardnode.helper.plist",
              "__LOG_DIR__", "#{Dir.home}/Library/Logs/Ardvis"
    run "/bin/launchctl",
        args: [
          "bootstrap", "gui/#{Process.uid}",
          "#{Dir.home}/Library/LaunchAgents/com.ardvis.ardnode.helper.plist"
        ],
        sudo: "if_needed"
  end

  # `launchctl:` unloads the agent and removes its plist; the artifact stanza
  # removes the installed helper. A `delete:` list would remove both paths with
  # sudo, which prompts for a password for files the user owns.
  uninstall launchctl: "com.ardvis.ardnode.helper"
end
