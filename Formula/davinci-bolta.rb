class DavinciBolta < Formula
  desc "Interactive Bolta tax invoice CLI with multiple companies"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.3.1/davinci-bolta-3.3.1-macos-universal.tar.gz"
  version "3.3.1"
  sha256 "91bede82614d0e924fff9634ee2cd0e855fd5768528314a6ffc58e79d633232d"
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
      Select saved customers with arrow keys and Enter; customer numbers are automatic.
      New customers can be filled from their business registration number.
      Configuration and invoice history stay in ~/.local/share/bolta-cli.
    EOS
  end

  test do
    assert_match "davinci-bolta 3.3.1", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
  end
end
