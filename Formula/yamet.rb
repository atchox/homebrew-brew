class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.1.0-rc.4.tar.gz"
  sha256 "a2144b606a19a5f5bec01cd3000add5f78f313ad62e9a8cbe1949dc44b5a8dcb"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.1.0-rc.4"
    sha256 cellar: :any,                 arm64_sequoia: "b50e5ca42023d368aca9fee81717f08df644520a036dc3532f86192d197ec1d8"
    sha256 cellar: :any,                 arm64_sonoma:  "c5a32baa9969c87b39e241d082a398276a14a4e995982cbfe12da4a1a996d29a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e407540d97220b46c129e96ad89682af04a7ac4daa49565d9f0d9baa5ba09517"
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
