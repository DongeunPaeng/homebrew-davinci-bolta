class DavinciBolta < Formula
  desc "Interactive Bolta tax invoice CLI with multiple companies"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.4.0/davinci-bolta-3.4.0-macos-universal.tar.gz"
  version "3.4.0"
  sha256 "af0b6b87398e1dd049a6d1f139e15749c05ad7e8dda8fe43d3b834c710853e9b"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "bolta" => "davinci-bolta"
    bin.install_symlink bin/"davinci-bolta" => "davinci-configure"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Run davinci-configure to add a nickname or update its live/test API keys.
      Enter keeps saved keys; existing names and invoice history are preserved.
      Existing saved keys migrate automatically. Missing keys are requested only when needed.
      Select saved customers with arrow keys and Enter; customer numbers are automatic.
      New customers can be filled from their business registration number.
      Configuration and invoice history stay in ~/.local/share/bolta-cli.
    EOS
  end

  test do
    assert_match "davinci-bolta 3.4.0", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
    assert_match "davinci-configure [OPTIONS]", shell_output("#{bin}/davinci-configure --help")
  end
end
