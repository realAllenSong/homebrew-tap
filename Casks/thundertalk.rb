cask "thundertalk" do
  version "1.18.0"
  sha256 "f9b90b977d9c01020d6f49a3556ef6957377dd4e9ed7b4729f4568189b7f4bd4"

  url "https://github.com/realAllenSong/ThunderTalk/releases/download/v#{version}/ThunderTalk-v#{version}-macOS.zip"
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
