#!/usr/bin/env bash

if [ "$(uname -s)" == "Darwin" ]
then
  if test ! $(which rbenv)
  then
    echo "  Installing rbenv for you."
    brew install rbenv > /tmp/rbenv-install.log
  fi

  if test ! $(which ruby-build)
  then
    echo "  Installing ruby-build for you."
    brew install ruby-build > /tmp/ruby-build-install.log
  fi

  brew install rbenv-ctags rbenv-gem-rehash rbenv-default-gems
  if [ -f "./default-gems" -a ! -e "${RBENV_ROOT}/default-gems" ]
  then
    echo "  Setting up default-gems for you."
    ln -s "$(pwd)/default-gems" "${RBENV_ROOT}/default-gems"
  fi
fi
