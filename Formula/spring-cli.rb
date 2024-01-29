# Generated with JReleaser 1.11.0-SNAPSHOT at 2024-01-29T14:49:45.197284112Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.8.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-linux.x86_64.zip"
    sha256 "ee0831fbcc9a21b7ff906278d55755c92118d626c59dfb2b3e2977c48cb297c5"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.aarch64.zip"
    sha256 "3109768e3bb76af474917d00da894de743cfa64a5c35c496452a32a20a9ef4c9"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.x86_64.zip"
    sha256 "f8d0d5fdf8946ef38c768f1d02eac2816ef984350fe202244ccf0d95d609f6da"
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
    assert_match "0.8.1", output
  end
end
