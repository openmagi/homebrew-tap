class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.8/magi_agent-0.1.8.tar.gz"
  sha256 "e8fd1dd7365d32581efb7b34f6ff9073486c863d6666a057005480cca28201a2"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.8"
    sha256               arm64_tahoe:  "04245f9bad57fb6b0a04665c215bd61f5662c0161d1876b3d825cad15ebe1f4a"
    sha256 cellar: :any, x86_64_linux: "129c7587509f21d7e98419d6e59394c33ba5c39defaa2c2251b33e272f8a47cb"
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
