cask "ardnode" do
  version "0.1.0"
  sha256 "b24a4a5b99d2bfefb84ca74cd481293b92140b03e9d0a4e7e58a2843f6779722"
  url "https://github.com/ardvis/ardnode-dist/releases/download/v#{version}/Ardnode-macos-arm64.zip"
  name "Ardnode"
  desc "Ardvis mesh host helper and Screen Sharing proxy"
  homepage "https://github.com/ardvis/ardnode-dist"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  artifact "Ardnode.app", target: "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app"

  postflight_steps do
    plist_dir = "#{Dir.home}/Library/LaunchAgents"
    plist_path = "#{plist_dir}/com.ardvis.ardnode.helper.plist"
    helper_path = "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/MacOS/ardnode"
    log_dir = "#{Dir.home}/Library/Logs/Ardvis"

    FileUtils.mkdir_p(plist_dir)
    FileUtils.mkdir_p(log_dir)

    template_plist = "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app/Contents/Resources/com.ardvis.ardnode.helper.plist"
    if File.exist?(template_plist)
      content = File.read(template_plist)
      content = content.gsub("__HELPER_PATH__", helper_path).gsub("__LOG_DIR__", log_dir)
      File.write(plist_path, content)
    end

    run "/bin/launchctl",
        args: ["bootstrap", "gui/#{Process.uid}", plist_path]
  end

  uninstall launchctl: "com.ardvis.ardnode.helper",
            delete:    [
              "#{Dir.home}/Library/Application Support/Ardvis/Helpers/Ardnode.app",
              "#{Dir.home}/Library/LaunchAgents/com.ardvis.ardnode.helper.plist",
            ]
end
