class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "4037a5b3f0ceaaf45c3bbf2397c5ed7fbb22494c70a8d9309e0eb9c6e14a2baa"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.5"
    sha256               arm64_tahoe:  "7a197a67416cf7885b2ac4f74ab3400c22d12ec2d18f41e68770908ba7729fc3"
    sha256 cellar: :any, x86_64_linux: "f4913cd8665f7545406b4ee36938f20ba945f8fc542f63e1134cb8ce0243ead9"
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
