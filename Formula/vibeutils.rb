class Vibeutils < Formula
  desc "Modern Unix utilities with colors, icons, and progress bars"
  homepage "https://github.com/kelp/vibeutils"
  url "https://github.com/kelp/vibeutils/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "2b0d74a4f634ad617fc48b1939b27fffaf7b58946724d8fc3a31edea69f9d59d"
  license "MIT"
  head "https://github.com/kelp/vibeutils.git", branch: "main"

  bottle do
    root_url "https://github.com/kelp/vibeutils/releases/download/v0.8.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1231aa55d29c477aa3474056ec79b1cda23c8c35b739557b53b1d74e797f863c"
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
