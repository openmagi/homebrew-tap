class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.30/magi_agent-0.1.30.tar.gz"
  sha256 "dd96ba28009703a5a478b4bc17bc83e44d3ca70a22d5120f26b749908b45854f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.30"
    sha256               arm64_tahoe:  "c89701888f00ebde9730ef9d2adf4e69352645e3ddfa9dbb494862e9987b635f"
    sha256 cellar: :any, x86_64_linux: "c67ac27ad8ff1ab30f7e17d9c6bf8f37784c36104d980198acb2e575bcb85377"
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
