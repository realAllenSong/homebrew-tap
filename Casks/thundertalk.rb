cask "thundertalk" do
  version "1.19.0"
  sha256 "894bbc180d9bc720029ef62bebfe6873404e75166c7a1b4b815c57bfe8a6d3e8"

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
