#!/bin/bash

echo $ sed -Ei "s/$1/$2/"
grep -lr -e $1 | grep -v ^build | xargs sed -Ei "s/$1/$2/"
