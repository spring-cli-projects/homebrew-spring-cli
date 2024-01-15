# Generated with JReleaser 1.11.0-SNAPSHOT at 2024-01-15T11:24:54.889368807Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.8.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-linux.x86_64.zip"
    sha256 "79188dc37ec7bc661cb3731cadbe10cea800f2d96acb98e1a649bcffb935395c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-osx.aarch64.zip"
    sha256 "7f8ed20f99eaefe2c51dcec8678119263313960320b9c206c099a788b5c1a5af"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-osx.x86_64.zip"
    sha256 "5a37769f933720fb2bd3c87f5654e70dd3c09d884fd3b143e4f2f08a0538d66c"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
    zsh_completion.install Dir["#{libexec}/completion/zsh/_spring"]
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
    assert_match "0.8.0", output
  end
end
