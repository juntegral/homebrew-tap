cask "hoverlens" do
  version "0.1.0"
  sha256 "c334f24e1f739162340d86c00879fb0233b2a1a1f7cebc52e463e1b5f0e8d81f"

  url "https://github.com/juntegral/homebrew-tap/releases/download/v#{version}/HoverLens-#{version}.zip"
  name "HoverLens"
  desc "Answers for the text under the pointer, shown in a panel beside it"
  homepage "https://github.com/juntegral/homebrew-tap"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "HoverLens.app"

  # 공증을 받지 않은 빌드라 격리 표시가 남아 있으면 처음 열 때 macOS가 막는다.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/HoverLens.app"]
  end

  uninstall quit: "com.juntegral.HoverLens"

  zap trash: [
    "~/Library/Application Support/HoverLens",
    "~/Library/Preferences/com.juntegral.HoverLens.plist",
  ]

  caveats <<~EOS
    HoverLens is not notarized by Apple yet. The quarantine flag is removed
    on install so that the app opens; it is signed by its developer.

    On first launch, allow Accessibility in System Settings > Privacy & Security.
  EOS
end
