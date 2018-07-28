#!/usr/bin/env bash

error_exit() {
    echo "quitting"
    exit 1
}

install_pyenv() {
    set -x
    if [[ -n "$PYENV_VERSION" && "$TRAVIS_OS_NAME" == "osx" ]]; then
        brew update  > /dev/null
        brew upgrade readline openssl pyenv
        eval "$(pyenv init -)"
        pyenv install -s "$PYENV_VERSION"
        pyenv rehash
    fi
}

trap "error_exit" ERR
install_pyenv
python -m pip install wheel

