# MutVis

MutVis is an open-source, user-friendly, automated framework for analysis and visualization of mutational signatures in pathogenic bacterial strains, regardless the number, origin or species. 
The current framework integrates various opensource tools and is scripted using Python, R programming and Snakemake workflow management software. 
MutVis supports variant calling, processing of VCF files, transition and transversion graphical representation, generation of mutational count matrix, graphical visualization of basepair substitution spectrum (BPS) and mutation signatures.





# Steps

![mutvis_process](https://user-images.githubusercontent.com/53608357/99533707-53260580-29cc-11eb-8296-ece9ace7e94e.png)









# Requirements

1. Python 3
2. R
3. Miniconda


# Setup

To setup a minimal snakemake environment, first install Miniconda with Bioconda channels by following the instructions [here](https://bioconda.github.io/user/install.html).

#### Install Snakemake with the following command: 

conda create -n Mutvis -c conda-forge -c bioconda snakemake

conda activate Mutvis


# Installation

git clone https://github.com/AkshathaPrasanna/MutVis.git

cd MutVis


# Inputs

1. VCF file.
2. Reference genome in FASTA format.
3. If VCF file is not available, fastq formatted raw reads for variant calling to generate VCF files.

#### Adding input data

1. Copy VCF files to the VCF_files/ directory and ensure the file names follow the convention of {sample_name}.vcf
2. Add reference genome to the data/fasta directory and ensure the file name follow the convention of genome.fasta
3. To generae VCF files, Copy each of the raw sample fastq files to the data/fastq directory and ensure the file names follow the convention of {ID}_1.fastq and {ID}_2.fastq





  
# Running MutVis for variant calling

Here is an overview of the Snakemake rule graph:


![dag2](https://user-images.githubusercontent.com/53608357/99770967-5802ca80-2b2e-11eb-820c-1738804df457.png)




# Running MutVis for mutation signature analysis






# Tutorial














