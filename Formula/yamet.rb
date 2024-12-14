class Yamet < Formula
  desc "Yamet: Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/releases/download/v1.0.0-dev/yamet-v1.0.0-dev.tar.gz"
  sha256 "f91801f5151a32b5547a7070b76b93d6e9178422310f28e5584d9682b1471191"
  license "GPL"

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