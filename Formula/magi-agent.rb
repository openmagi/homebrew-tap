class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.25/magi_agent-0.1.25.tar.gz"
  sha256 "c7f13fbbeb8a524046bb6bdee24dd9244ee10b1e0cf22f78f2863968a9fa72f5"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.24"
    sha256               arm64_tahoe:  "eba5481ee07364c7f33769121896fb73ef6adfbec44c692caff6d9e49dd33b40"
    sha256 cellar: :any, x86_64_linux: "ccb437fbe052b137758ce9a776bef42d4e6f600584c692df055ccaf1f759cd8b"
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
