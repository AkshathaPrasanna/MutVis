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



# Inputs

1. VCF file.
2. Reference genome in FASTA format.
3. If VCF file is not available, fastq formatted raw reads for variant calling to generate VCF files.



# Installation

git clone https://github.com/AkshathaPrasanna/MutVis.git

cd MutVis

#### Install Snakemake with the following command: 

conda create -c conda-forge -c bioconda -n snakemake snakemake

conda activate snakemake



# Running MutVis for variant calling






# Running MutVis for mutation signature analysis






# Tutorial














