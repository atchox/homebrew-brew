class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.0.0-rc.1.tar.gz"
  sha256 "843fa24976d7cd39185aa3860d78fc989075d58a7a6d41a399f95a777486cacf"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.0.0-rc.1"
    sha256 cellar: :any,                 arm64_sequoia: "d163ae75b45b02483b19e5def6b56cd2be68e006d2d3cddb90912ecaa686a514"
    sha256 cellar: :any,                 arm64_sonoma:  "73d31459dec97e68c5a68d7756991422c26ee9f05ed6555223bca8536560244e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac0eede3af850e5460546b855e7374cc8130f70a38000b10adca6e55d2aadd6a"
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
