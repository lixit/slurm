#!/bin/bash
#SBATCH --nodes=1                      
#SBATCH --cpus-per-task=16              
#SBATCH --ntasks=1              
#SBATCH --gres=gpu:ampere:2           
#SBATCH --gres-flags=enforce-binding 
#SBATCH --time=5-00:00:00                   
#SBATCH --job-name=imagenet_1k_XL
#SBATCH --output=output.txt

#SBATCH --mail-type=BEGIN,END,FAIL             # Send me email for various states
#SBATCH --mail-user xitong@ucf.edu         # Use this address 

# Load modules


module load anaconda3/2022.05
module load cuda/12.4

# conda create -n fastvit python=3.9 -y
# conda init bash

# source /home/xi729145/.bashrc


conda activate fastvit

cd pytorch-image-models


./distributed_train.sh 2 /share/datasets/ImageNet/ --model fastvit_t8 -b 128 --lr 1e-3 \
--resume output/20240531-144744-fastvit_t8-256/checkpoint-4.pth.tar \
--mixup 0.2 --output output \
--input-size 3 256 256
