#!/bin/bash
yum install bzip2 mesa-libGL-devel freeglut freeglut-devel -y
export TERM=xterm-256color
tput setaf 2;
echo ""
echo "  ... Installing miniconda for IMOD ..."
echo ""
tput sgr0;
bash extra/Miniconda3-4.6.14-Linux-x86_64.sh -b
tput setaf 2;
echo ""
echo " ... done. Preparing the CONDA EMAN2 env ..."
echo ""
tput sgr0;
source /root/miniconda3/etc/profile.d/conda.sh
conda config --set auto_activate_base False
conda config --set auto_update_conda False
tput setaf 2;
echo ""
echo " ... done. Creating it (it may take) ..."
echo ""
tput sgr0;
conda create  --yes -n eman2 eman-deps-dev=22.1 -c cryoem -c defaults -c conda-forge
tput setaf 2;
echo ""
echo " ... done. Getting EMAN2 from git ..."
echo ""
tput sgr0;
git clone https://github.com/cryoem/eman2.git
cd eman2
git fetch --all --prune
git checkout master
cd 
echo ""
echo " ... done. Compiling EMAN2 ..."
mkdir /src
mkdir /src/eman2-src
cd /src/eman2-src
conda activate eman2
cmake /eman2 -DENABLE_OPTIMIZE_MACHINE=ON
make -j 8
make install
echo " "
echo "  ... done. Opening display..."
e2display.py 
