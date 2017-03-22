#!/usr/bin/env bash

docker() {
    case $@ in
        clean)
            ${HOME}/.local/bin/docker-clean
            ;;
        *)
            command docker "$@"
            ;;
    esac
}
