# HPC Use Case BERT (Sentiment Analysis)

This guide provides a step-by-step approach to performing **sentiment analysis with BERT using R and Python** on a HPC cluster. The workflow and example code are adapted from [R-Bloggers](https://www.r-bloggers.com/2023/08/hugging-face-%F0%9F%A4%97-with-a-warm-embrace-meet-r%EF%B8%8F-%E2%9D%A4%EF%B8%8F/). We generated evaluation comments (file "eval_comment.csv") using **GPT-4** with the following prompt: *"Please write me 40 comments on evaluation of anonymous employee with minimum of 2 to 3 sentences with another column showing its sentiment whether it is positive or negative. Use column headers "Comment" and "Sentiment."*

---

**Step 1 - Transfer the materials onto the cluster**:
After logging into the HPC cluster, got to a workspace directory, then clone the repository with:

 ```
git clone git@github.com:Data-Science-Center-UB/HPC-Use-Case-BERT.git
 ```

**Step 2 - Create a new environment**:
Note that we run the environment installation on the CPU compute node to avoid putting too much load on the login node in hackathon/workshop settings where many people work in parallel. We therefore run the installation via the sbatch script `setup.sh` so it executes on a compute node, not on the login node. Open `setup.sh` to see the exact steps.

```
# 1. Enter the project folder
cd HPC-Use-Case-BERT

# 2. Create the conda environment & run the installation via the sbatch script "setup.sh"
sbatch setup.sh
```

**Step 3 - Run the Python script by submitting a SLURM job**:
Submit the job so it runs on a compute node. Open `run_BERT.sh` to see the exact steps.

```bash
sbatch run_BERT.sh
```
