require 'formula'

class Chnode < Formula
  homepage 'https://github.com/colinrymer/chnode#readme'
  url 'https://github.com/colinrymer/chnode/archive/v1.0.0.tar.gz'
  sha1 '64365226210f82b58092ed01a3fb57d379b99c80'

  head 'https://github.com/colinrymer/chnode.git'

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end

  def caveats; <<-EOS.undent
    Add the following to the ~/.bashrc or ~/.zshrc file:

      source #{opt_share}/chnode/chnode.sh

    By default chnode will search for Rubies installed into /opt/rubies/ or
    ~/.rubies/. For non-standard installation locations, simply set the NODES
    variable after loading chnode.sh:

      NODES=(
        /opt/jruby-1.7.0
        $HOME/src/rubinius
      )

    If you are migrating from another Node manager, set `NODES` accordingly:

      NVM:   NODES+=(~/.nvm/versions/node/*)

    To enable auto-switching of Nodes specified by .node-version files,
    add the following to ~/.bashrc or ~/.zshrc:

      source #{opt_share}/chnode/auto.sh
    EOS
  end
end
