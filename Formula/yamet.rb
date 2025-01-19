class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.0.0-rc.1.tar.gz"
  sha256 "c55a5d501cf0dce300e5dd871139cf59b08fe6594bf3f269e76f795b676245fc"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.0.0-rc.1"
    sha256 cellar: :any,                 arm64_sequoia: "93ed7d8ef42fac050f2cb812c10e0abe76b57fb4ebe68ea0f28747b63b57992c"
    sha256 cellar: :any,                 arm64_sonoma:  "c330c70e03f5a55bd9fb6c9203a8234b76ddf53122afbc35c5fb0b130c065f7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3d8bcd4c36b9accaa3ad610b236310e76ced3c721dbc00e4281f8eb959157ef"
  end

  depends_on "cmake" => :build
  depends_on "boost"
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
