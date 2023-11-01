# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-11-01T09:27:34.658370262Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.3"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.3/spring-cli-standalone-0.7.3-linux.x86_64.zip"
    sha256 "8b4a5e0f2dd198a5422893537cd4b0b83ea73f6203b741212f43d89b8900f4ed"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.3/spring-cli-standalone-0.7.3-osx.aarch64.zip"
    sha256 "f1a4a00454fbde5607a985cee48c5ce54035cd59dc2317aa26964f983766612c"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.3/spring-cli-standalone-0.7.3-osx.x86_64.zip"
    sha256 "a74124dd2161b5104e30674454176a122d202183000aaf72ab727cfd6f647cdf"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.3", output
  end
end
