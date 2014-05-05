#!/bin/bash
mkdir -p ~/.fonts/Inconsolata-LGC
cd ~/dotFiles/fonts/Inconsolata-LGC
git archive HEAD | tar x -C ~/.fonts/Inconsolata-LGC
fc-cache -vf
