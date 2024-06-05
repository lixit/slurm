#!/bin/bash
#SBATCH --job-name=multinode_imagenet_1k
#SBATCH --nodes=4                      
#SBATCH --ntasks=4              
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=2


##SBATCH --gres-flags=enforce-binding 
#SBATCH --time=2-00:00:00                   
#SBATCH --output=output_multinode.txt

#SBATCH --mail-type=BEGIN,END,FAIL             # Send me email for various states
#SBATCH --mail-user xitong@ucf.edu         # Use this address 


# Load modules
module load anaconda/anaconda3

source /apps/anaconda/anaconda3/etc/profile.d/conda.sh

conda activate fastvit


nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)

declare -p nodes
declare -p nodes_array
declare -p head_node
declare -p head_node_ip

echo Node IP: $head_node_ip
export LOGLEVEL=INFO


cd pytorch-image-models || return

nvidia-smi

srun torchrun \
--nnodes 4 \
--nproc_per_node 2 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:29500 \
train.py /datasets/ImageNet2012nonpub --model fastvit_t8 -b 128 --lr 1e-3 \
--resume output/20240531-154051-fastvit_t8-256/checkpoint-267.pth.tar \
--mixup 0.2 --output output \
--input-size 3 256 256