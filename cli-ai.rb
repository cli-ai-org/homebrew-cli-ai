# Homebrew Formula for cli-ai
class CliAi < Formula
  desc "Discover and explore CLI tools on your system - optimized for AI agents"
  homepage "https://github.com/cli-ai-org/cli"
  url "https://github.com/cli-ai-org/cli/archive/refs/tags/v0.1.3-beta.tar.gz"
  sha256 "88cdebe8c6df6f696263f1ee5c1603673ee02ef2db937497fb30e8db02ce0586"
  license "MIT"
  version "0.1.3-beta"

  depends_on "go" => :build

  def install
    # Build from source (files are in root of archive)
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"cli-ai", "."

    # Install documentation
    doc.install "README.md"
    doc.install "COMMANDS.md"
    doc.install "USAGE_EXAMPLES.md"
    doc.install "PACKAGE_DETECTION.md"
    doc.install "docs/AI_AGENT_USAGE.md" if File.exist?("docs/AI_AGENT_USAGE.md")
  end

  test do
    # Test that the binary runs
    system "#{bin}/cli-ai", "help"

    # Test list command
    assert_match "Found", shell_output("#{bin}/cli-ai list 2>&1")
  end
end
