#### ssh
```
ssh -i /home/datasets/xitong_id_rsa xitong@newton.ist.ucf.edu
ssh xi729145@crcv.eecs.ucf.edu 

scp -i /home/datasets/xitong_id_rsa xitong@newton.ist.ucf.edu:/home/xitong/example .
```

### run a interactive shell on Newton
```
srun --nodes=1 --ntasks=1 --cpus-per-task=16 --gres=gpu:4 --time=00:40:00  --constrain=h100 --pty bash

```

### run a interactive shell on CRCV cluster
```
# with gpu
srun --nodes=1 --ntasks=1 --cpus-per-task=16 --gres=gpu:ampere:2 --time=00:40:00  --pty bash
srun --nodes=1 --ntasks=1 --cpus-per-task=4 --gres=gpu:1  -C gmem32 --time=00:10:00  --pty bash

```

```
gpu:ampere=38,
NVIDIA RTX A6000

gres/gpu:pascal=22,
NVIDIA TITAN Xp

gres/gpu:turing=26,
NVIDIA GeForce RTX 2080 Ti

gres/gpu:volta=5
```

### Slurm commands
```
# submit a job
sbatch xl_submit.slurm

# cancel a job
scancel $JOBID

# show available QOS
sacctmgr show qos
sacctmgr show qos format=Name,Priority,MaxWall

# show PARTITION, nodes, state
sinfo

# detailed info about nodes
scontrol show nodes

# show jobs in the queue
squeue
squeue -u $USER

# show detailed info about the jobs
scontrol show job
scontrol show job $JOBID
```

# tmux commands
```
# Start a new session
tmux

# list sessoins
tmux ls

# Attach to last session
tmux a

# Detach from session
ctrl + b d

# Create window
ctrl + b c
```

#### create a conda environment
```
conda create -n lavis python=3.8 -y
conda init bash
conda activate lavis
```



#### Library path
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/cap6412.student14/usr/lib

```