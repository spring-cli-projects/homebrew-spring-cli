# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-12T14:51:23.915246609Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.4"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.4/spring-cli-standalone-0.7.4-linux.x86_64.zip"
    sha256 "e780c20f0cb2c5cf5bf29e5288e272d270002da7a30e18e2bcb45223b4914ef5"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.4/spring-cli-standalone-0.7.4-osx.aarch64.zip"
    sha256 "2644aed5b8d2a3688694c22a6d749ab77ba9251cc35907cc27a2a258ceb2b6ec"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.4/spring-cli-standalone-0.7.4-osx.x86_64.zip"
    sha256 "626fc1d74e1b3c23df90e88facc3223c2a14e8db7e91781a22746b8c99760bce"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
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
    assert_match "0.7.4", output
  end
end
