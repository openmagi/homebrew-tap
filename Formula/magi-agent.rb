class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.11/magi_agent-0.1.11.tar.gz"
  sha256 "5dd9a84699b2dbfc1590237204ddb7388f8b634e98e6ce5b0b2c225c7985c850"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.11_1"
    sha256               arm64_tahoe:  "3d3a9f1a086f96f4f481a22d07da4d5291191da87ad98ae3c096a4825a5bd45a"
    sha256 cellar: :any, x86_64_linux: "8bac37af79a6b90622c014ca19103051ed5fbdd6f76baa3e6784988114acef43"
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
