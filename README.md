# chnode

Changes the current Node. Basically what you get if you `s/ruby/node/g` with [chruby](https://github.com/postmodern/chruby), so huge props to @postmodern for their work!

## Features

* Updates `$PATH`.
* Calls `hash -r` to clear the command-lookup hash-table.
* Fuzzy matching of Nodes by name.
* Defaults to the system Node.
* Optionally supports auto-switching and the `.node-version` file.
* Supports [bash] and [zsh].
* Small (~100 LOC).

## Anti-Features

* Does not hook `cd`.
* Does not install executable shims.
* Does not require Nodes be installed into your home directory.
* Does not automatically switch Nodes by default.

## Requirements

* [bash] >= 3 or [zsh]

## Install

    wget -O chnode-1.0.0.tar.gz https://github.com/colinrymer/chnode/archive/v1.0.0.tar.gz
    tar -xzvf chnode-1.0.0.tar.gz
    cd chnode-0.3.9/
    sudo make install

### Homebrew

chnode can also be installed with [homebrew]:

    brew install chnode

Or the absolute latest chnode can be installed from source:

    brew install chnode --HEAD

## Configuration

Add the following to the `~/.bashrc` or `~/.zshrc` file:

``` bash
source /usr/local/share/chnode/chnode.sh
```

### System Wide

If you wish to enable chnode system-wide, add the following to
`/etc/profile.d/chnode.sh`:

``` bash
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/local/share/chnode/chnode.sh
  ...
fi
```

This will prevent chnode from accidentally being loaded by `/bin/sh`, which
is not always the same as `/bin/bash`.

### Rubies

When chnode is first loaded by the shell, it will auto-detect Nodes installed
in `/opt/nodes/` and `~/.nodes/`. After installing new Rubies, you _must_
restart the shell before chnode can recognize them.

For Nodes installed in non-standard locations, simply append their paths to
the `NODES` variable:

``` bash
source /usr/local/share/chnode/chnode.sh

NODES+=(
  /opt/node-0.12.7
  $HOME/nodes/v5.1.1
)
```

### Migrating

If you are migrating from another Node manager, set `RUBIES` accordingly:

#### RVM

``` bash
RUBIES+=(~/.rvm/rubies/*)
```

#### rbenv

``` bash
RUBIES+=(~/.rbenv/versions/*)
```

#### rbfu

``` bash
RUBIES+=(~/.rbfu/rubies/*)
```

### Auto-Switching

If you want chnode to auto-switch the current version of Node when you `cd`
between your different projects, simply load `auto.sh` in `~/.bashrc` or
`~/.zshrc`:

``` bash
source /usr/local/share/chnode/chnode.sh
source /usr/local/share/chnode/auto.sh
```

chnode will check the current and parent directories for a [.node-version]
file. Other Node switchers also understand this file:
https://gist.github.com/1912050

### Default Node

If you wish to set a default Node, simply call `chnode` in `~/.bash_profile` or
`~/.zprofile`:

    chnode 5.3.0

If you have enabled auto-switching, simply create a `.node-version` file:

    echo "5.3.0" > ~/.node-version

