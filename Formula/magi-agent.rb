class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Local-first agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "42ab7f9b659d6c0ae902f9108efc4be59ba3f62d2cf238effb6897ed3136d6db"
  license "Apache-2.0"

  depends_on "python@3.13"

  def install
    virtualenv = virtualenv_create(libexec, "python3.13")
    virtualenv.pip_install "#{buildpath}[cli]"
  end

  test do
    assert_match "usage: magi-agent", shell_output("#{bin}/magi-agent --help")
    assert_match "Magi CLI", shell_output("#{bin}/magi --help")
  end
end
