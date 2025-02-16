#!/bin/bash
#SBATCH --job-name=generate_index
#SBATCH --output=generate_index_%j.out         # Файл для вывода
#SBATCH --error=generate_index_%j.err          # Файл для ошибок
#SBATCH --partition=vgl         
#SBATCH --cpus-per-task=4  

reference_fasta=$1
bwa index $reference_fasta 

