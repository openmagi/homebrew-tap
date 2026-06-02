class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Local-first agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "816386f1ff2c168393494a03ba74c4d4749f355df0f104a8a2ec187528e0b66d"
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
