#!/bin/bash
#SBATCH --job-name=bowtie_align
#SBATCH --output=logs/bowtie_align_%j.out
#SBATCH --error=logs/bowtie_align_%j.err
#SBATCH --partition=vgl
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-user=savouriess2112@gmail.com

prefix=$1
hap=$2

cpu=$3

dir=/vggpfs/fs3/vgl/store/adenisova/WTS
wts_audet_dir=/lustre/fs5/jarv_lab/scratch/jaudet/WTS-SNPs

# if [ "$hap" -eq 1 ]; then
#   reference_fasta=/vggpfs/fs3/vgl/store/adenisova/WTS/genome_data/bZonAlb1.hap1.cur.20250122.fasta
# elif [ "$hap" -eq 2 ]; then
#   reference_fasta=/vggpfs/fs3/vgl/store/adenisova/WTS/genome_data/bZonAlb1.hap2.cur.20250131.fasta
# else
#   echo "Error: unsupported value for hap ($hap)."
#   exit 1
# fi

if [ $# -ne 3 ]; then
    echo "Usage: $0 <prefix> <hap> <cpu>"
    exit 1
fi

if [ ! -f "${wts_audet_dir}/${prefix}.r1.trimmed.filtered.fq" ]; then
    echo "Файл ${prefix}.r1.trimmed.filtered.fq не существует."
    exit 1
fi

if [ ! -f "${wts_audet_dir}/${prefix}.r2.trimmed.filtered.fq" ]; then
    echo "Файл ${prefix}.r2.trimmed.filtered.fq не существует."
    exit 1
fi


#align to each haplotype
mkdir -p $dir/index_WTS/sam
bowtie2 -p $cpu -x WTS_hap${hap} -1 ${wts_audet_dir}/${prefix}.r1.trimmed.filtered.fq -2 ${wts_audet_dir}/${prefix}.r2.trimmed.filtered.fq -S $dir/index_WTS/sam/${prefix}_hap${hap}.sam

#convert sam to bam
mkdir -p $dir/index_WTS/sam2bam

samtools sort -@ $cpu $dir/index_WTS/sam/${prefix}_hap${hap}.sam > $dir/index_WTS/sam2bam/${prefix}_hap${hap}.bam
samtools index $dir/index_WTS/sam2bam/${prefix}_hap${hap}.bam

# generate variant calls in VCF format
# mkdir -p $dir/index_WTS/bcf
# cd $dir/index_WTS/bcf
#bcftools mpileup -f $reference_fasta $dir/index_WTS/sam2bam/${prefix}_hap${hap}.bam | bcftools view -Ov - > $dir/index_WTS/bcf/${prefix}_hap${hap}.bcf
