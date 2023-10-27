# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-27T18:22:31.540741566Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.2"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.2/spring-cli-standalone-0.7.2-linux.x86_64.zip"
    sha256 "fee5e202ddbb7d560a2e09a0a3bbab9ac1a8f19b36d4dbda46b3f944993d7ced"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.2/spring-cli-standalone-0.7.2-osx.x86_64.zip"
    sha256 "c27090ebe1febd992fff6ee379f7ef9ac8d137797857c02105b12bcef72162b2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/spring-projects-experimental/spring-cli/releases/download/v0.7.2/spring-cli-standalone-0.7.2-osx.x86_64.zip"
    sha256 "c27090ebe1febd992fff6ee379f7ef9ac8d137797857c02105b12bcef72162b2"
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
    assert_match "0.7.2", output
  end
end
