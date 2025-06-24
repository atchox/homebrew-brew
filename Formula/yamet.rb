class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.1.0-rc.5.tar.gz"
  sha256 "e5620827e1c48b35724d97f93a4259de415ccc7320130a0762a70727ec1c1aea"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.1.0-rc.5"
    sha256 cellar: :any,                 arm64_sequoia: "19e7b18e38d6ca59c4bf3d77ff27235cf5ad2432a14284286ccbb6acc221decb"
    sha256 cellar: :any,                 arm64_sonoma:  "71d7912b95485bbadaeec15a75801084c26e1959479048e7c6884e5908494e2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3dd197f1768fcbb77f93fff0a674e824ad52ad4a7f874efa57a0fd40f5a1d97f"
  end

  depends_on "cmake" => :build
  depends_on "boost"

  def install
    rm_r Dir["{README.md,CHANGELOG.md,AUTHORS,LICENSE}"]
    cd "method" do
      system "cmake", ".", *std_cmake_args, "-DVERSION=#{version}"
      system "cmake", "--build", "."
      system "cmake", "--install", "."
    end
  end

  test do
    # Verify installation
    assert_match "yamet version #{version}", shell_output("#{bin}/yamet --version")
  end
end
