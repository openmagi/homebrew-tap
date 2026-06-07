class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.23/magi_agent-0.1.23.tar.gz"
  sha256 "082eae4eeaebc19c5ca3fef881427695b6ff50a3ed3e33e2e0358c0da3d95fba"
  license "Apache-2.0"

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
