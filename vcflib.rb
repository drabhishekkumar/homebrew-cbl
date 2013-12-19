require 'formula'

class RecursiveGitDownloadStrategy < GitDownloadStrategy
  def clone_args
    args = %w{clone}
    args << '--recursive'
    args << @url << @clone
  end
  def stage
    FileUtils.cp_r Dir[@clone+"{.}"], Dir.pwd
  end
  def clone_repo
    safe_system 'git', *clone_args
    fetch
  end
  def reset
  end
  def submodules?
    false
  end
end

class Vcflib < Formula
  homepage 'https://github.com/ekg/vcflib'
  version '2013-11-30'
  url 'https://github.com/ekg/vcflib.git', :using => RecursiveGitDownloadStrategy, :revision => '506b80ac6b'

  def install
    system 'make'
    bin.install Dir['bin/*']
  end

  test do
    system 'vcfallelicprimitives', '-h'
  end
end