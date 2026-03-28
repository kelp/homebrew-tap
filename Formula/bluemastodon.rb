class Bluemastodon < Formula
  desc "A tool to synchronize posts from Bluesky to Mastodon"
  homepage "https://github.com/kelp/bluemastodon"
  url "https://files.pythonhosted.org/packages/95/3a/d90ef719c0c5ed2876d132d988f006a027dbdfe7b60491864c1218f63ab5/bluemastodon-0.9.5.tar.gz"
  sha256 "82b63eeb8b4d9cd6df0e63955e1bf7d2d9b51805b015fa90f1c2f87433a35b1f"
  license "MIT"

  depends_on "python"

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{Language::Python.major_minor_version "python3"}/site-packages"
    system "python3", "-m", "pip", "install", "--prefix=#{libexec}", "."
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    system bin/"bluemastodon", "--version"
  end
end