#!/bin/bash
readonly DEBUG=${DEBUG:-false}

if [ ${DEBUG} ]; then
    set -exuo pipefail
fi

readonly PROGRAM=$(basename $0)
readonly BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


readonly SHORTOPTS="hd:p:rt"
readonly LONGOPTS="help,distro:profile:reinstall,target"

readonly DISTROS=(debian gentoo)
readonly PROFILES=$(for f in "${BASE_DIR}"/profile/*; do basename $f; done | tr '\n' ' ')

readonly USAGE="
Dotfiles Setup.

Usage:
    ${PROGRAM} [options] [<package>...]
    ${PROGRAM} (-h | --help)

Options:
    -h --help               Show this message.
    -d --distro=<distro>    Linux distribution to use [default: auto].
    -p --profile=<profile>  Profile to use [default: lite].
    -r --reinstall          Do not perform first-time-setup actions.
    -t --target=<tgt>       Target install directory [default: ${HOME}].

Distros:    (${DISTROS[@]})
Profiles:   (${PROFILES[@]})
"

function main {
    # set up local variables
    opt_help=false
    opt_distro="auto"
    opt_profile="lite"
    opt_reinstall=false
    opt_target="${HOME}"
    arg_packages=""

    # parse arguments
    options=$(getopt \
        -o "${SHORTOPTS}" \
        --long "${LONGOPTS}" \
        -n "${PROGRAM}" \
        -- "$@")

    # validate arguments
    if [ $? != 0 ]; then
        echo "${USAGE}" >&2
        exit 1
    fi

    eval set -- "${options}"

    # map arguments to variables
    while true; do
        case "$1" in
            -h | --help )       opt_help=true; shift ;;
            -d | --distro )     opt_distro="$2"; shift; shift ;;
             -p | --profile )   opt_profile="$2"; shift; shift ;;
             -r | --reinstall ) opt_reinstall=true; shift ;;
             -t | --target )    opt_target="$2"; shift; shift ;;
            -- )                arg_packages="${@:2}"; break ;;
        esac
    done

    # handle help option
    if [ ${opt_help} = true ]; then
        echo "${USAGE}" >&2
        exit 0
    fi

    # print variables for debugging
    print_opts

    # detect distro
    if [ "${opt_distro}" = "auto" ]; then
        opt_distro=$(detect_distro)
        echo "detected distro: ${opt_distro}"
    fi

    # validate options
    validate_distro
    validate_profile

    # select packages
    if [ -z ${arg_packages} ]; then
        arg_packages=$(select_packages)
    fi

    # install setup dependencies
    if [ ! ${opt_reinstall} = true ]; then
        local deps="$(get_dependencies)"
        case "${opt_distro}" in
            debian ) sudo apt-get install ${deps} ;;
            gentoo ) sudo emerge -au ${deps} ;;
            * ) error_exit "unrecognized distribution - '${opt_distro}'.\ncould not install setup dependencies"
        esac
    fi

    # install dotfile packages
    install_packages
}

function detect_distro {
    local distro_string=$(uname -a)
    for distro in ${DISTROS[@]}; do
        if echo "${distro_string}" | grep --quiet -i "${distro}"
        then
            echo $distro
            return
        fi
    done
    echo "unknown"
}

function validate_distro {
    if [[ " ${DISTROS[@]} " =~ " ${opt_distro} " ]]; then
        return
    fi

    if [[ " ${DISTROS[@]} " =~ " unknown " ]]; then
        error_exit "failed to detect distro"
    fi

    echo "${PROGRAM}: unrecognized distro -- '${opt_distro}'" >&2
    echo "vaild distros are:" >&2
    echo "${DISTROS[@]}"
    exit 1
}

function validate_profile {
    if [[ " ${PROFILES[@]} " =~ " ${opt_profile} " ]]; then
        return
    fi

    if [[ " ${PROFILES[@]} " =~ " unknown " ]]; then
        error_exit "failed to detect profile"
    fi

    echo "${PROGRAM}: unrecognized profile -- '${opt_profile}'" >&2
    echo "vaild profiles are:" >&2
    echo "${PROFILES[@]}"
    exit 1
}

function get_dependencies {
    local pkgs_file="${BASE_DIR}/${opt_distro}.deps"
    if [ -f "${pkgs_file}" ]; then
        cat "${pkgs_file}"
    fi
    for pkg in ${arg_packages}; do
        local pkgs_file="${BASE_DIR}/pkg/${pkg}/${opt_distro}.deps"
        if [ -f "${pkgs_file}" ]; then
            cat "${pkgs_file}"
        fi
    done
}

function select_packages {
    cat "${BASE_DIR}/profile/${opt_profile}"
}

function install_packages {
    for pkg in ${arg_packages}; do
        install_package "${pkg}"
    done
}

function install_package {
    local pkg="$1"
    local pkgdir="${BASE_DIR}/pkg/${pkg}"
    echo "INSTALLING: ${pkg}"

    pushd "${pkgdir}"

    run_stage preinstall

    local stowdir="stow"
    if [ -d "${stowdir}" ]; then
        echo "  INSTALLING: ${stowdir}"
        stow --target="${opt_target}" "${stowdir}"
    else
        echo "  NOT FOUND: ${stowdir}"
    fi

    run_stage postinstall

    popd
}

function run_stage {
    local stage="${1}"
    local script="${stage}.${opt_distro}.sh"
    if [ -f "${script}" ]; then
        echo "  RUNNING: ${stage}"
        source "${script}"
        return
    fi
    local script="${stage}.sh"
    if [ -f "${script}" ]; then
        echo "  RUNNING: ${stage}"
        source "${script}"
        return
    fi
    echo "  NOT FOUND: ${stage}"
    return
}

function print_opts {
    echo DISTRO=$opt_distro
    echo PROFILE=$opt_profile
    echo PACKAGES=$arg_packages
}

function error_exit {
    echo "${PROGRAM}: $1" >&2
    exit 1
}

main "$@"
