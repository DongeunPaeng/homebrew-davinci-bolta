class DavinciBolta < Formula
  desc "Interactive Bolta tax invoice CLI with multiple companies"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.2.0/davinci-bolta-3.2.0-macos-universal.tar.gz"
  version "3.2.0"
  sha256 "a824ddbcc4c0169afe961997a9e2b4e030ef44be1ba28e006fb75ab94d092b35"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "bolta" => "davinci-bolta"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Run davinci-bolta and enter your Bolta API key.
      Company details are fetched; enter the issuer notification email once.
      Add more company keys with davinci-bolta configure.
      Configuration and invoice history stay in ~/.local/share/bolta-cli.
    EOS
  end

  test do
    assert_match "davinci-bolta 3.2.0", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
  end
end
