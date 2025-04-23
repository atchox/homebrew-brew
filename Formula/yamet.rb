class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.1.0-rc.3.tar.gz"
  sha256 "5be828545fd81b0a0bf018484945c554daf740a60dd1d28917be3525ef675755"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.1.0-rc.3"
    sha256 cellar: :any,                 arm64_sequoia: "44caddeb3fb4ab57e4ed8243c28c8a4b389ac661dfc7e043fc44f46813963425"
    sha256 cellar: :any,                 arm64_sonoma:  "bd4d3f6e84c987ccdb4d393b8cc400b35bd9d07f1d3c4f5ea13f41af061992b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8fe41653b55287769f5b2e6da18e78a64e823f49b931849e3259c1080b10e60"
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
