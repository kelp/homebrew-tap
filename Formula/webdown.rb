class Webdown < Formula
  desc "CLI tool for converting web pages to clean, readable Markdown format"
  homepage "https://github.com/kelp/webdown"
  url "https://files.pythonhosted.org/packages/source/w/webdown/webdown-0.6.3.tar.gz"
  sha256 "9b11b36ebc19ea160b7418f4102483085bd4d092f8e3e99332872b6511a1e72b"
  license "MIT"

  depends_on "python"

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{Language::Python.major_minor_version "python3"}/site-packages"
    system "python3", "-m", "pip", "install", "--prefix=#{libexec}", "."
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    system bin/"webdown", "--version"
  end
end