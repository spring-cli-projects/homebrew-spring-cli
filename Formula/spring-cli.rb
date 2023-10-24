# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-24T14:30:09.169496682Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-linux.x86_64.zip"
    sha256 "79abe069a7c19c01729a27c4f746805417da8b369b5cf9367e2113a431073d2e"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-osx.x86_64.zip"
    sha256 "3cf19a229f4ac0004ebc8c9106149d94612cdbfceca1d46ac16705c352dc11e5"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-osx.x86_64.zip"
    sha256 "3cf19a229f4ac0004ebc8c9106149d94612cdbfceca1d46ac16705c352dc11e5"
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
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.1", output
  end
end
