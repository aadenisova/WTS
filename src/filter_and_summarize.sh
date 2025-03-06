### cpus-per-task = 4
### ntasks = 8

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

vcftools --vcf WTS_24.multi.var.vcf --remove-indels --recode --recode-INFO-all --out WTS_24.multi.snp
