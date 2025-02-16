#!/bin/bash
#SBATCH --job-name=bwa_mem
#SBATCH --output=bwa_mem_%j.out         # Файл для вывода
#SBATCH --error=bwa_mem_%j.err          # Файл для ошибок
#SBATCH --partition=vgl         
#SBATCH --cpus-per-task=4  

reference_fasta=$1
prefix=$2
dir=/vggpfs/fs3/vgl/store/adenisova/WTS
wts_audet_dir=/lustre/fs5/jarv_lab/scratch/jaudet/WTS-SNPs

bwa mem -t 4 $dir/genome_data/$reference_fasta ${wts_audet_dir}/${prefix}.r1.trimmed.filtered.fq ${wts_audet_dir}/${prefix}.r2.trimmed.filtered.fq > ${prefix}.sam 

