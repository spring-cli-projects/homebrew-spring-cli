# Generated with JReleaser 1.12.0 at 2024-05-23T12:20:43.644401732Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.9.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-linux.x86_64.zip"
    sha256 "d1bb6f3cee171f0dfe83d826e2e3cfc4d3315d638d3ae2bb2dafa114a9c66a7e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.aarch64.zip"
    sha256 "94af30bf00e9b10f3c8994d045c0d6be1338da788523fc0259abb25249c4df68"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.x86_64.zip"
    sha256 "fee1d6961dc11e9654520189ce7b61a3ae901d79839abb65c58632b48ec53218"
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
    assert_match "0.9.0", output
  end
end
