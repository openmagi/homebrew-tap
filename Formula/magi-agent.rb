class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Local-first agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "ef7d55caebfb62133dc30ce1ee0967aec6ca2cc34743ef12c2d5bbefc4aa188d"
  license "Apache-2.0"

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
