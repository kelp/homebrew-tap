class Bluemastodon < Formula
  desc "A tool to synchronize posts from Bluesky to Mastodon"
  homepage "https://github.com/kelp/bluemastodon"
  url "https://files.pythonhosted.org/packages/36/a7/d7b29ec3fb2406a4594ac6a1f384511a463dd6f3a5e1fef97da00cb94c29/bluemastodon-0.9.10.tar.gz"
  sha256 "f85ca2881d313962139663d5c562fbf7a13c9d7404ec0f7af0cbdddfefed031d"
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