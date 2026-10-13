require_relative "../lib/private_git_download_strategy"

class DavinciBolta < Formula
  desc "Tax invoice CLI for Da Vinci Corp"
  homepage "https://github.com/DongeunPaeng/homebrew-davinci-bolta"
  url "https://github.com/DongeunPaeng/homebrew-davinci-bolta.git",
      tag:      "v3.1.0",
      revision: "94e3f305c638cd9a52353f8d141f97d42abb7fb3",
      using:    DavinciBoltaPrivateGitDownloadStrategy
  version "3.1.0"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "Release/bolta" => "davinci-bolta"
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
