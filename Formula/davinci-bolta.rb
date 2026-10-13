class DavinciBolta < Formula
  desc "Interactive Bolta tax invoice CLI with multiple companies"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.8.0/davinci-bolta-3.8.0-macos-universal.tar.gz"
  version "3.8.0"
  sha256 "d357dc78a8434f63d79e74f829f5aa69b138222567e950676e364956d8e2fa6d"
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
    assert_match "davinci-bolta 3.8.0", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
    assert_match "davinci-configure [OPTIONS]", shell_output("#{bin}/davinci-configure --help")
  end
end
