class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.7/magi_agent-0.1.7.tar.gz"
  sha256 "58c5a4e1b2f49531efcd43f96a2fb3dbde765233cec8c6feb23a050de851385a"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.7"
    sha256               arm64_tahoe:  "f3795cf47b29a5375d720346956406dab32cb157f3081132ef57b1ed6e698b25"
    sha256 cellar: :any, x86_64_linux: "53774cf2d6846f176dec3cc0a1b052c17b479c567a72a0b8a54779a250514263"
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
