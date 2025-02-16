#!/bin/bash

#SBATCH --job-name=launch_bowtie_align
#SBATCH --output=logs/launch_bowtie_align_%j.out
#SBATCH --error=logs/launch_bowtie_align_%j.err
#SBATCH --partition=vgl
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=savouriess2112@gmail.com

cpu=$1
MAX_JOBS=$2

# Check if CPU count is provided
if [ -z "$cpu" ]; then
  echo "Usage: $0 <number_of_cpus>"
  exit 1
fi

# Check if MAX_JOBS is provided
if [ -z "$MAX_JOBS" ]; then
  echo "Usage: $0 <MAX_JOBS>"
  exit 1
fi


mkdir -p logs


for ((num=1; num<=42; num++)); do
  echo "Processing sample $num"

  for ((hap=1; hap<=2; hap++)); do
    echo "For haplotype $hap"

    while true; do
    #check if we can launch next job
      JOB_COUNT=$(squeue --user=$(whoami) --noheader | wc -l)
      if [ "$JOB_COUNT" -ge "$MAX_JOBS" ]; then
        echo "Too many jobs ($MAX_JOBS)"
        sleep 60 #sleep for 1 minute
      else
        echo "Continue work with ($JOB_COUNT) tasks"
        break
      fi
    done

    sbatch -c $cpu --output=logs/align_${num}_hap_${hap}.out \
     --error=logs/align_${num}_hap_${hap}.err ../src/bowtie_align.sh \
    WTS_24_${num} ${hap} $cpu || echo "Job submission failed for sample ${num}, haplotype ${hap}"

  done

done
