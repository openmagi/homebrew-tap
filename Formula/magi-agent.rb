class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.19/magi_agent-0.1.19.tar.gz"
  sha256 "807ec4d3744a68b0bac64a99eb2b8c22548bc10d6ed08bf21d2a22c435d65a2a"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.19"
    sha256               arm64_tahoe:  "048731e441d1f1b7e4957a0c867a8671a21dfbb5f6deffb6cc6d9fcc0e7bbf98"
    sha256 cellar: :any, x86_64_linux: "418956d98694499bdc0e8b3404f8f16384ee8e9f3ad6f594edce3794038b1b61"
  end

  depends_on "python@3.13"

  on_macos do
    depends_on "rust" => :build
  end

  def install
    if OS.mac?
      ENV["PIP_NO_BINARY"] = "jiter,tiktoken"
      ENV.append "RUSTFLAGS", "-C link-arg=-Wl,-headerpad_max_install_names"
    end

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
