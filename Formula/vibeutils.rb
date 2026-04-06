class Vibeutils < Formula
  desc "Modern Unix utilities with colors, icons, and progress bars"
  homepage "https://github.com/kelp/vibeutils"
  url "https://github.com/kelp/vibeutils/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "623d9e25caa945ba62870f6ed55c817ebfdca2f017583efcd88a46aa7c5f9766"
  license "MIT"
  head "https://github.com/kelp/vibeutils.git", branch: "main"

  bottle do
    root_url "https://github.com/kelp/vibeutils/releases/download/v0.9.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a91c62a86a149663f83cd648a04eec296616a343f20d73120cd461299196b235"
  end

  depends_on "zig" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseSafe"

    # Install all binaries from zig-out/bin with 'v' prefix
    Dir["zig-out/bin/*"].each do |file|
      base_name = File.basename(file)
      next if base_name == "["
      bin.install file => "v#{base_name}"
    end

    # Create vibebin directory with unprefixed symlinks
    (libexec/"vibebin").mkpath
    bin.children.each do |file|
      base_name = file.basename.to_s.sub(/\Av/, "")
      (libexec/"vibebin"/base_name).make_symlink(file)
    end

    # Install man pages
    man1.install Dir["man/man1/*"] if Dir.exist?("man/man1")
  end

  def caveats
    <<~EOS
      vibeutils commands are installed with a 'v' prefix:
        vls, vcp, vmv, vrm, vmkdir, vtouch, etc.

      To use without prefix, add vibebin to your PATH:
        export PATH="#{opt_libexec}/vibebin:$PATH"
    EOS
  end

  test do
    assert_match "vibeutils", shell_output("#{bin}/vecho vibeutils")
  end
end
