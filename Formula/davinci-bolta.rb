class DavinciBolta < Formula
  desc "Interactive Bolta tax invoice CLI with multiple companies"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.3.0/davinci-bolta-3.3.0-macos-universal.tar.gz"
  version "3.3.0"
  sha256 "6ffcf7791822189d301f3dc92265a5949333457d9d52e8114df654546e340ad0"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "bolta" => "davinci-bolta"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      New users enter live and test API keys; issuer details are shown first.
      Existing saved keys migrate automatically. Missing keys are requested only when needed.
      New customers can be filled from their business registration number.
      Configuration and invoice history stay in ~/.local/share/bolta-cli.
    EOS
  end

  test do
    assert_match "davinci-bolta 3.3.0", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
  end
end
