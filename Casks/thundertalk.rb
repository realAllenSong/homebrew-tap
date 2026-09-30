cask "thundertalk" do
  version "1.6.0"
  sha256 "1e004d372f92ba29817fc5fc9ca2b8a936718202c36c73c88c6c03c4bd6ef654"

  url "https://github.com/realAllenSong/ThunderTalk/releases/download/v#{version}/ThunderTalk-v#{version}-macOS.zip",
      verified: "github.com/realAllenSong/ThunderTalk/"
  name "ThunderTalk"
  desc "Local voice input, transcription and text-to-speech"
  homepage "https://realallensong.github.io/ThunderTalk/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "ThunderTalk.app"

  # The app is signed ad hoc, not notarised; without this macOS refuses to
  # open it the first time ("ThunderTalk can't be opened").
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ThunderTalk.app"],
                   sudo: false
  end

  zap trash: [
    "~/.thundertalk",
    "~/Library/Preferences/com.thundertalk.app.plist",
  ]

  caveats <<~EOS
    On first launch, allow Microphone and Accessibility access when asked.
    Speech models are downloaded inside the app (Models page) and stored in
    ~/.thundertalk and ~/.cache/huggingface.
  EOS
end
