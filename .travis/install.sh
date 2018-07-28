#!/usr/bin/env bash

error_exit() {
    echo "quitting"
    exit 1
}

install_pyenv() {
    set -x
    if [[ -n "$PYENV_VERSION" ]]; then
        if [[ "$TRAVIS_OS_NAME" == 'osx' ]]; then
            brew update  > /dev/null
            brew upgrade readline openssl
            brew upgrade pyenv
        fi
        eval "$(pyenv init -)"
        if [[ "$TRAVIS_OS_NAME" == 'osx' ]]; then
            pyenv install -s "$PYENV_VERSION"
        else
            pyenv install -s "$PYENV_VERSION"
        fi
        pyenv rehash
        python -m pip install wheel
    fi
}

trap "error_exit" ERR
install_pyenv

