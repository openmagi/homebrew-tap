class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.15/magi_agent-0.1.15.tar.gz"
  sha256 "37e56fefeddb6e797a46704fa96efd9efbcb0ab2ced5111e23a1781722041c9f"
  license "Apache-2.0"
  revision 1

  depends_on "python@3.13"

  on_macos do
    depends_on "rust" => :build
  end

  def install
    if OS.mac?
      ENV["PIP_NO_BINARY"] = "jiter"
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
