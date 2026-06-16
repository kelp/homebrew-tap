class Gale < Formula
  desc "Fast, isolated package management for developers"
  homepage "https://github.com/kelp/gale"
  url "https://github.com/kelp/gale/archive/refs/tags/v0.18.0.tar.gz"
  sha256 "0346e0fd39ab4dbc5572977de1fb164742b140d2853392a5a837e05c3785ccf7"
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
