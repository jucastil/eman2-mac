#!/bin/bash
export TERM=xterm-256color
tput setaf 2;
echo ""
echo "  ... Getting conda eman2 ..."
echo ""
tput sgr0;
source /root/miniconda3/etc/profile.d/conda.sh
echo " "
echo "  ... done. Opening display..."
conda activate eman2
e2display.py 
