#!/bin/bash

#set -e
trap "exit 1" ERR
set -x

if [[ -n "$PYENV_VERSION" ]]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        brew update
        brew upgrade readline openssl
        brew cask uninstall oclint
        brew install expat xz gcc
        brew upgrade pyenv
    fi
    eval "$(pyenv init -)"
    pyenv install --list
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        CFLAGS="-I$(xcrun --show-sdk-path)/usr/include /usr/local/opt/expat/include $CFLAGS" \
        pyenv install -s "$PYENV_VERSION"
    else
        pyenv install -s "$PYENV_VERSION"
    fi
    pyenv rehash
    python -m pip install wheel
fi
