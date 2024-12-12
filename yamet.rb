class Yamet < Formula
  desc "Yamet: A tool powered by Boost and zlib"
  # homepage "https://github.com/imallona/yamet"
  url "https://github.com/imallona/yamet.git", :branch => "master"
  head "https://github.com/imallona/yamet.git", :branch => "method"
  # sha256 "your_tarball_sha256_checksum"
  license "GPL"

  version "0.1.0"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "zlib"

  def install
    cd "yamet/method" do
      # Set the build directory
      build_dir = "build"

      # Create the build directory
      mkdir build_dir

      # Run cmake to configure the build
      system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-B#{build_dir}", "-S."

      # Build the project
      system "make", "-C", build_dir

      # Install the project
      system "make", "-C", build_dir, "install"
    end
  end

  test do
    # Verify installation
    assert_match "Usage:", shell_output("#{bin}/yamet --help")
  end
end