class Yamet < Formula
  desc "Yamet: Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/releases/download/v1.0.0-dev/yamet-Darwin-arm64-v1.0.0-dev.tar.gz"
  sha256 "a003571b12404142955f9a21542c636fecb3bd27ea6bac2793ac71a5c166f584"
  license "GPL-3.0-only"

  depends_on "boost"
  depends_on "zlib"

  def install
    bin.install "bin/yamet"
    include.install Dir["include/*"]
  end

  test do
    # Verify installation
    assert_match "Usage:", shell_output("#{bin}/yamet --help")
  end
end