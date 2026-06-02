class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Local-first agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "42ab7f9b659d6c0ae902f9108efc4be59ba3f62d2cf238effb6897ed3136d6db"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.1_1"
    sha256               arm64_tahoe:  "2875362a90758768c9b8dfc43f89925b3f49ff51ccf941259fb2626074f96644"
    sha256 cellar: :any, x86_64_linux: "771e862cc2912a648f8c74947f7750e351c0e33641064705b6dd8720b7935cfc"
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
