#!/bin/bash
#SBATCH --job-name=snp_calling
#SBATCH --output=logs/snp_calling_%j.out
#SBATCH --error=logs/snp_calling_%j.err
#SBATCH --partition=vgl
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --ntasks=1
#SBATCH --mail-user=savouriess2112@gmail.com

# ls sam2bam/ | grep hap1.bam | grep -v .bai | sed 's#^#/vggpfs/fs3/vgl/store/adenisova/WTS/index_WTS/sam2bam/#' > bamlist.txt

hap=$1
FILEPATH="/vggpfs/fs3/vgl/store/adenisova/WTS/index_WTS"

if [ "$hap" -eq 1 ]; then
  all_chroms="SUPER_1,SUPER_2,SUPER_3,SUPER_Z,SUPER_4,SUPER_5,SUPER_6,SUPER_7,SUPER_8,SUPER_9,SUPER_10,SUPER_W,SUPER_11,SUPER_12,SUPER_13,SUPER_14,SUPER_15,SUPER_16,SUPER_17,SUPER_18,SUPER_19,SUPER_20,SUPER_21,SUPER_22,SUPER_23,SUPER_24,SUPER_25,SUPER_26,SUPER_27,SUPER_30,SUPER_33,SUPER_29,SUPER_28,SUPER_31,SUPER_32,SUPER_34,SUPER_35,SUPER_36,SUPER_37,SUPER_38,SUPER_3_unloc_7,SUPER_Z_unloc_1,SUPER_39,SUPER_3_unloc_6,SUPER_3_unloc_3,SUPER_6_unloc_1,SUPER_40,SUPER_3_unloc_5,SUPER_34_unloc_1,SUPER_3_unloc_2,SUPER_3_unloc_1,SUPER_3_unloc_4"
  REF="/vggpfs/fs3/vgl/store/adenisova/WTS/genome_data/bZonAlb1.hap1.cur.20250122.fasta"
elif [ "$hap" -eq 2 ]; then
  all_chroms="SUPER_1,SUPER_3,SUPER_4,SUPER_5,SUPER_6,SUPER_7,SUPER_8,SUPER_9,SUPER_10,SUPER_13,SUPER_12,SUPER_11,SUPER_14,SUPER_15,SUPER_16,SUPER_17,SUPER_18,SUPER_19,SUPER_20,SUPER_22,SUPER_23,SUPER_21,SUPER_26,SUPER_25,SUPER_31,SUPER_24,SUPER_27,SUPER_38,SUPER_28,SUPER_35,SUPER_32,SUPER_36,SUPER_29,SUPER_30,SUPER_37,SUPER_34,SUPER_33,SUPER_39,SUPER_3_unloc_4,SUPER_40,SUPER_3_unloc_1,SUPER_39_unloc_1,SUPER_3_unloc_5,SUPER_36_unloc_1,SUPER_6_unloc_1,SUPER_3_unloc_2,SUPER_20_unloc_1,SUPER_3_unloc_6,SUPER_3_unloc_8,SUPER_3_unloc_7,SUPER_3_unloc_9,SUPER_3_unloc_3,SUPER_2"
  REF="/vggpfs/fs3/vgl/store/adenisova/WTS/genome_data/bZonAlb1.hap2.cur.20250131.fasta"
else
  echo "Error: unsupported value for hap ($hap)."
  exit 1
fi

cd $FILEPATH

bcftools mpileup -Ou -f $REF --bam-list bamlist_hap${hap}.txt --threads 32 \
-r $all_chroms | bcftools call -Ov -mv --threads 32 -o WTS_24_hap${hap}.multi.var.vcf
