class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.1.0-rc.2.tar.gz"
  sha256 "b18f41a959e3d5199755534ea858bdc0b3b4940819c4654317f794aeee51ed64"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.1.0-rc.2"
    sha256 cellar: :any,                 arm64_sequoia: "e727394fedec450efae5cc00653e3f2f0df9e0cb69bf5649a14999386139cfd1"
    sha256 cellar: :any,                 arm64_sonoma:  "4d36456a4bbd1c7cd1656d6122ae8b929c1fc9eddd33fcd696c646a0d274eb3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54d2c32fff5e7c9f0177fe7b39dfafc150c58ce18de90ef9a6b15f2cb531c7f7"
  end

  depends_on "cmake" => :build
  depends_on "boost" => :build
  uses_from_macos "zlib"

  on_linux do
    depends_on "zlib"
  end

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
