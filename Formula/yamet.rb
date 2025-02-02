class Yamet < Formula
  desc "Yet Another Methylation Entropy Tool"
  homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet/archive/refs/tags/v1.0.0-rc.1.tar.gz"
  sha256 "7c022786ee0e907713f1e444dda2744b6a5bf7ea2a8cf3c801e21bcf026a5950"
  license "GPL-3.0-only"
  head "https://github.com/imallona/yamet.git", branch: "master"

  bottle do
    root_url "https://github.com/imallona/yamet/releases/download/v1.0.0-rc.1"
    sha256 cellar: :any,                 arm64_sequoia: "dadd87aecda3170bebd4ee85c3ece756acadee404f6c06d4d859897948cdae81"
    sha256 cellar: :any,                 arm64_sonoma:  "5f177b3aeba769a4c3898df98e590ec7b58ea397be23e39498cd50a29df479cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "614ed1294ab901571b4eb06dff133738fbc32c5c39016226f50fbd17bddff42e"
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
