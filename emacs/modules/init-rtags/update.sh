#!/bin/bash

content=$(curl https://github.com/Andersbakken/rtags/tree/master/src 2>/dev/null)
hrefs=$(echo "$content" | grep -Poe '(?!href=")/[-/\d\w]+\.el(isp)?(?=")')
echo "$hrefs" | while read -r line
do
    url=$(echo "https://raw.githubusercontent.com$line" | sed 's/blob\///')
    echo "$url"
    curl -O "$url"
    echo
done
