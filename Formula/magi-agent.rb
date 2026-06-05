class MagiAgent < Formula
  include Language::Python::Virtualenv

  desc "Open Magi agent runtime and CLI"
  homepage "https://github.com/openmagi/magi-agent"
  url "https://github.com/openmagi/magi-agent/releases/download/v0.1.14/magi_agent-0.1.14.tar.gz"
  sha256 "b1e426d0763e195e2ed6eff2912e82e9e17af95a7ed5711d529479c35f19cb75"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/openmagi/homebrew-tap/releases/download/magi-agent-0.1.14"
    sha256               arm64_tahoe:  "0f90095258397a751632a50012a3b368150aba484f20e3bd49eee6910d754308"
    sha256 cellar: :any, x86_64_linux: "5bf9b8ef87b62cd41a517ac28770ca2e2e1c90584c6f484542c38db834898013"
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
