#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -M nmf64@drexel.edu
#$ -P nsftuesPrj
#$ -l h_rt=24:00:00
#$ -l h_vmem=16G
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

module load ncbi-blast/gcc/64/2.2.30

for $file in Sample_GRWS002?/merge?.fasta; do
  blastx -query $file -db nr -out $file.out
done
