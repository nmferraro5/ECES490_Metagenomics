#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -M nmf64@drexel.edu
#$ -P nsftuesPrj
#$ -pe openmpi_ib 16
#$ -l h_rt=6:00:00
#$ -l h_vmem=8G
#$ -l h_vmem=6G
#$ -q all.q@@amdhosts


. /etc/profile.d/modules.sh
module load shared
module load proteus
module load sge/univa
module load gcc/4.8.1
module load python/2.7-current

module load bowtie2/2.2.5

cd metaphlan

export PATH='pwd':$PATH
mpa_dir='pwd'

mkdir -p profiled_samples
mkdir -p bowtieout


for dir in ProjectSamples/*; do
  for file in $dir/*.fastq; do
    ./metaphlan.py $file --bowtie2db bowtie2db/mpa --bt2_ps very-sensitive --nproc 5  --input_type multifastq --biom_output_file $file.biom
  done
done

