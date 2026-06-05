class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.13/magi_agent-0.1.13.tar.gz"
  sha256 "6d2df345be01e10a7b75fc77dc217727618d6a68b20fc0d8a3258652c6db11e9"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.12"
    sha256               arm64_tahoe:  "e06ddc314241b48c566fc6f50e1b82e1a63fe9bce5c9c539fd898d4c42558c91"
    sha256 cellar: :any, x86_64_linux: "f1d07d3efbe4a74ab2dbb2ca65a777b61d9750a790bf6f740f6d1f282b80defe"
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
