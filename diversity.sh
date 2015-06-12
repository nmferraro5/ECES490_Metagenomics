#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -M nmf64@drexel.edu
#$ -P nsftuesPrj
#$ -l h_rt=6:00:00
#$ -l h_vmem=8G
#$ -q all.q

PATH=/mnt/HA/groups/nsftuesGrp/.local/bin:$PATH
# DATADIR=$HOME/tutorial07/data
# mkdir -p $DATADIR

# ---Keep this---

. /etc/profile.d/modules.sh
module load shared
module load proteus
module load sge/univa
module load gcc/4.8.1
unset PYTHONPATH
module load qiime/gcc/64/1.8.0

cd metaphlan

alpha_diversity.py -i merged_table.biom -o output/alphaTable.txt -m simpson
beta_diversity.py -i output/biomFiles -o output/beta -m binary_hamming
