class Yamet < Formula
  desc "Yamet: Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/releases/download/v1.0.0-dev/yamet-v1.0.0-dev-Darwin-arm64.tar.gz"
  sha256 "5b1450324789d6b1ffec4748e531d5fb72db489ef3a9415c93cf46258d57e7fc"
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