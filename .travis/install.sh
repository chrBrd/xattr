#!/usr/bin/env bash

error_exit() {
    message="ERROR: Command '$BASH_COMMAND' exited with code '$?'"
    set +x
    echo "$message"
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
        python -m pip install wheel
    fi
}

trap "error_exit" ERR
install_pyenv


