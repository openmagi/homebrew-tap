class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "9433db51e1d34ee8f9bea500b0dae81e54c4b389c7836c77679192f800808050"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.6"
    sha256               arm64_tahoe:  "3e7d528e676f8bcd0644c86f261dc3ca0287fc0ca230b4525509410d7588f2b2"
    sha256 cellar: :any, x86_64_linux: "b5648b606127a4cbd2e8fcadb9041e90d43125f070ca9da8458598eacbcacbe9"
  end

  depends_on "python@3.13"

  def install
    virtualenv_create(libexec, "python3.13")
    system libexec/"bin/python", "-m", "pip", "install", "--disable-pip-version-check", "#{buildpath}[cli]"
    bin.install_symlink libexec/"bin/magi"
    bin.install_symlink libexec/"bin/magi-agent"
  end

  test do
    assert_match "usage: magi-agent", shell_output("#{bin}/magi-agent --help")
    assert_match "Magi CLI", shell_output("#{bin}/magi --help")
  end
end
