class Yamet < Formula
  desc "Yamet: Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/releases/download/v1.0.0-dev/yamet-v1.0.0-dev.tar.gz"
  sha256 "8f0c2cb393876b576cfa5ce67e62fd8a4708dd267481317dfd9b3cccac73d6f9"
  license "GPL-3.0-only"

  depends_on "boost"
  depends_on "zlib"

  def install
    bin.install "bin/yamet"
    include.install Dir["include/*"]
    pkgshare.install "LICENSE"
  end

  test do
    # Verify installation
    assert_match "Usage:", shell_output("#{bin}/yamet --help")
  end
end