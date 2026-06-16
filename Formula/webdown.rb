class Webdown < Formula
  desc "CLI tool for converting web pages to clean, readable Markdown format"
  homepage "https://github.com/kelp/webdown"
  url "https://files.pythonhosted.org/packages/a2/9d/06c754889fec505ebc385cd676c2b2f165065ee119e2285efc47129b093a/webdown-0.8.2.tar.gz"
  sha256 "3b9526f64430c57ec2a86fd18eb01ff97159bef9c4b8deba040b092cd20e11e8"
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