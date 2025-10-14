#!/usr/bin/env bash

hostsFile="/etc/hosts"
hostname="wsl.host"
ip=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')

die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

remove() {
    if [ -n "$(grep -P "[[:space:]]$hostname" /etc/hosts)" ]; then
        try sudo sed -ie "/[[:space:]]$hostname/d" "$hostsFile";
    fi
}

add() {
    if ! [ -n "$(grep -P "[[:space:]]$hostname" /etc/hosts)" ]; then
        try printf "%s\t%s\n" "$ip" "$hostname" | sudo tee -a "$hostsFile" > /dev/null;
    fi
}

remove
add
