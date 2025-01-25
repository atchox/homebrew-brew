class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.0.0-rc.1.tar.gz"
  sha256 "843fa24976d7cd39185aa3860d78fc989075d58a7a6d41a399f95a777486cacf"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.0.0-rc.1"
    sha256 cellar: :any,                 arm64_sequoia: "20db5b0a726705833c49190db95c73e8de813bffdca9fc04ec6e791846947b4c"
    sha256 cellar: :any,                 arm64_sonoma:  "b2071a23c669a702b5095e98f2d521311ac0a841c93810e096b3e3185b9b1fcd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4cf33bd01e7d257739ffb41385f143166d34f1865123b2d09cada19ba84ac8be"
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
