# Source of truth for the Homebrew tap. Copy this file to Formula/grapho.rb in
# a repository named igor-couto/homebrew-grapho, then:
#
#   brew install igor-couto/grapho/grapho
#
# The version is read from the URLs, so a bump edits three URLs and three
# sha256 values. The hashes are the grapho lines from the tag's SHA256SUMS.txt;
# a placeholder makes brew refuse the install with a checksum mismatch, which
# is the intended loud failure.
class Grapho < Formula
  desc "Quiet, local-first document editor that runs in your browser"
  homepage "https://github.com/igor-couto/grapho"
  license "GPL-3.0-only"

  on_macos do
    # The release builds one universal binary with both slices.
    url "https://github.com/igor-couto/grapho/releases/download/v0.1.0/grapho-0.1.0-macos-universal.tar.gz"
    sha256 "f40f4983193407d443c1945faa2c752fee91c8369caedfaed8f28687b6cfb144"
  end

  on_linux do
    on_intel do
      url "https://github.com/igor-couto/grapho/releases/download/v0.1.0/grapho-0.1.0-linux-x86_64.tar.gz"
      sha256 "5ee43bddb59868801f23a80d04abd25cc8fde583a3f75558c88d8c7a80c31d60"
    end

    on_arm do
      url "https://github.com/igor-couto/grapho/releases/download/v0.1.0/grapho-0.1.0-linux-aarch64.tar.gz"
      sha256 "763131c7b88d578d39b9d60c52234b5e008c9bb841e2a9f20f499a8c493b727a"
    end
  end

  def install
    # The tarball has one top-level directory holding the binary, README, and
    # LICENSE; Homebrew descends into it.
    bin.install "grapho"
  end

  service do
    run [opt_bin/"grapho"]
    working_dir var
    keep_alive false
  end

  livecheck do
    url "https://github.com/igor-couto/grapho/releases/latest"
    strategy :github_latest
  end

  def caveats
    <<~EOS
      Run `grapho` in a terminal, or `brew services start grapho` to keep it
      running in the background. It serves http://127.0.0.1:25265.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grapho --version")
  end
end
