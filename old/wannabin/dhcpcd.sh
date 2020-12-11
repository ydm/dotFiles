#!/bin/bash

# 1. Turn on DHCPCD
while true ; do
    sudo pkill dhcpcd
    out=$(sudo dhcpcd 2>&1)
    if [[ "$out" =~ "adding default route" ]] ; then
        echo "$(basename $0): connected to network"
        break
    else
        echo "$(basename $0): looping for network..."
        sleep 1
    fi
done

# 2. Run graphic env
# sway
