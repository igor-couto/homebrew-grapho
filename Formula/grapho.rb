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
    url "https://github.com/igor-couto/grapho/releases/download/v0.1.1/grapho-0.1.1-macos-universal.tar.gz"
    sha256 "12303329eed306e9f70362e80023a75dda32d50dcaefeef1abc0c20af67fa1c5"
  end

  on_linux do
    on_intel do
      url "https://github.com/igor-couto/grapho/releases/download/v0.1.1/grapho-0.1.1-linux-x86_64.tar.gz"
      sha256 "ca66428cb30fc2f2e27285b1f2b1b489d5c3291159ff9591d40e21f385c24339"
    end

    on_arm do
      url "https://github.com/igor-couto/grapho/releases/download/v0.1.1/grapho-0.1.1-linux-aarch64.tar.gz"
      sha256 "322bb0df156e2c782257e23b39b4d4f7ed610ef87e4e815bdb952fa1737ccc62"
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
