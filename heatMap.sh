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
module load qiime/gcc/64/1.8.0

# module load bowtie2/2.2.5

# ---Keep this---

cd metaphlan

# export PATH=`pwd`:$PATH
# mpa_dir=`pwd`


# This is the step to merge all abundance tables into one file

mkdir -p output
utils/merge_metaphlan_tables.py profiled_samples/Sample_GRWS002?/*.txt > output/merged_abundance_table_all.txt

# This is the step to create a heatmap

plotting_scripts/metaphlan_hclust_heatmap.py -f euclidean -d euclidean  -c bbcry --top 25 --minv 0.1 -s log \
 --in output/merged_abundance_table_all.txt \
 --out output_images/abundance_all_heatmap.png
