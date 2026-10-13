class DavinciBolta < Formula
  desc "Interactive Bolta tax invoice CLI with multiple companies"
  homepage "https://github.com/DongeunPaeng/homebrew-tap"
  url "https://github.com/DongeunPaeng/homebrew-tap/releases/download/v3.7.0/davinci-bolta-3.7.0-macos-universal.tar.gz"
  version "3.7.0"
  sha256 "fbc3385b3a2a99a19233ed708da75325d0d300295f12c9df4e8591c70d0bddbd"
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
    assert_match "davinci-bolta 3.7.0", shell_output("#{bin}/davinci-bolta --version")
    assert_match "configure", shell_output("#{bin}/davinci-bolta --help")
    assert_match "davinci-configure [OPTIONS]", shell_output("#{bin}/davinci-configure --help")
  end
end
