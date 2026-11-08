cask "thundertalk" do
  version "1.12.1"
  sha256 "6954120f8233d65c9208eae794f45880b62fa4c32a1e74560db77eec5fc58ceb"

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
