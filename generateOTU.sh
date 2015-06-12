#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -M nmf64@drexel.edu
#$ -P nsftuesPrj
#$ -l h_rt=6:00:00
#$ -l h_vmem=20G
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

module load qiime/gcc/64/1.8.0

for file in ProjectSamples/Sample_GRWS002?/merge?.fasta; do
  pick_otus.py -i $file -o OTU_tables
done
