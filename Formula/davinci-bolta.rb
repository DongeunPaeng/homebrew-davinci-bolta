class DavinciBolta < Formula
  desc "Tax invoice CLI for Da Vinci Corp"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.1.0/bolta-cli-davinci-macos-universal.tar.gz"
  version "3.1.0"
  sha256 "d475dffbcfbf1dc2c007ff8792ce420d67dfe9cb4b7bd51d4ad895137eecda87"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "bolta" => "davinci-bolta"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Run davinci-bolta and enter the separately shared API key once.
      Configuration and invoice history stay in ~/.local/share/bolta-cli.
    EOS
  end

  test do
    assert_match "davinci-bolta 3.1.0", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
  end
end
