class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.15/magi_agent-0.1.15.tar.gz"
  sha256 "37e56fefeddb6e797a46704fa96efd9efbcb0ab2ced5111e23a1781722041c9f"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.15_1"
    rebuild 1
    sha256               arm64_tahoe:  "64202c895dc294de83329304ff1abf37b35cc85c079301ef977f8e2e886b603c"
    sha256 cellar: :any, x86_64_linux: "361e453707b38481170a5bed44f939de1df29b14788f7c70c63494a2f4277840"
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
