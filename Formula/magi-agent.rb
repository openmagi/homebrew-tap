class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "fd2cda350fccf7680d5aa1647107bb8a8ab0b9b7c00d0494fbb8fc16b10cb824"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.4"
    sha256               arm64_tahoe:  "41026ccf1a63c29444fdc7cade55f503514a60db046d6a60f1ed4f2240d52a0a"
    sha256 cellar: :any, x86_64_linux: "a9b1165dfe90639bc1833db38b05ee54ac93b16512122cda4a4afbdf5e3ea41c"
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
