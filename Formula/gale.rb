class Gale < Formula
  desc "Fast, isolated package management for developers"
  homepage "https://github.com/kelp/gale"
  url "https://github.com/kelp/gale/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "a6787cb08abca1ee8c83b3f6081ead585ea32fbb527cff1a9ef65ac5c5b32b14"
  license "MIT"
  head "https://github.com/kelp/gale.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-X main.version=#{version}"
    system "go", "build",
           "-ldflags", ldflags,
           "-o", bin/"gale",
           "./cmd/gale/"
    man1.install "gale.1"
  end

  def caveats
    <<~EOS
      Add managed packages to your PATH:
        export PATH="$HOME/.gale/current/bin:$PATH"

      For per-project environments with direnv:
        eval "$(gale hook direnv)" >> ~/.config/direnv/direnvrc
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gale --version")
  end
end
