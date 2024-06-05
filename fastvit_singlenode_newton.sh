#!/bin/bash
#SBATCH --nodes=1                      
#SBATCH --cpus-per-task=32        
#SBATCH --ntasks=1              
#SBATCH --gres=gpu:2           
#SBATCH --gres-flags=enforce-binding 
#SBATCH --time=6-00:00:00                   
#SBATCH --job-name=imagenet_1k_XL
#SBATCH --output=output.txt
#SBATCH --constrain=h100

#SBATCH --mail-type=BEGIN,END,FAIL             # Send me email for various states
#SBATCH --mail-user xitong@ucf.edu         # Use this address 

# Load modules
module load anaconda/anaconda3

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

conda activate fastvit

cd pytorch-image-models


./distributed_train.sh 2   /datasets/ImageNet2012nonpub --model fastvit_t8 -b 128 --lr 1e-3 \
--mixup 0.2 --output output \
--input-size 3 256 256 \
--resume output/20240531-154051-fastvit_t8-256/checkpoint-267.pth.tar
