class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.9/magi_agent-0.1.9.tar.gz"
  sha256 "a8f7b525cd2620f5c08ecde38bee030393efde3fa3872e490f7a764ed464b217"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.9"
    sha256               arm64_tahoe:  "13221ec184116f190d47fc932e24fd886db52ffd92fd5b481eaef36c52b1c607"
    sha256 cellar: :any, x86_64_linux: "51a4417e106a25ebe2df220d14a4e30e1c11bc6e355b1dc301c175f8de3f2749"
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
