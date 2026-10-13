cask "hoverlens" do
  version "0.2.1"
  sha256 "70f5c7346c2e4bbf874187259e5e70ae9d303f8b505b5ad112b89b45ba6accf2"

  url "https://github.com/juntegral/hoverlens/releases/download/v#{version}/HoverLens-#{version}.zip"
  name "HoverLens"
  desc "Answers for the text under the pointer, shown in a panel beside it"
  homepage "https://github.com/juntegral/hoverlens"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
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
