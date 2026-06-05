class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.10/magi_agent-0.1.10.tar.gz"
  sha256 "3541cd1772d640d352ea7f4b02b9ffd85251fcd279026a2c2de2dc3aece3649f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.10"
    sha256               arm64_tahoe:  "ea898a5f5b2c9fedb1151b7336d9a6791acfaeda317a766cf4ce538f927f0b5a"
    sha256 cellar: :any, x86_64_linux: "c5687d76b4adb1c8c2839ab6ea900e1789315617cc61df6c2573b05df00d6357"
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
