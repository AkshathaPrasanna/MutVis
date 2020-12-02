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

```
conda create -n Mutvis -c conda-forge -c bioconda snakemake

conda activate Mutvis
```

# Installation

```
git clone https://github.com/AkshathaPrasanna/MutVis.git

cd MutVis
```

# Inputs

1. VCF file.
2. Reference genome in FASTA format.
3. If VCF file is not available, fastq formatted raw reads for variant calling to generate VCF files.

#### Adding input data

1. Copy VCF files to the VCF_files/ directory and ensure the file names follow the convention of {sample_name}.vcf
2. Add reference genome to the data/fasta directory and ensure the file name follow the convention of genome.fasta
3. To generae VCF files, Copy each of the raw sample fastq files to the data/fastq directory and ensure the file names follow the convention of {ID}_1.fastq and {ID}_2.fastq





  
# Running MutVis-Variant calling

Here is an overview of the Snakemake rule graph for variant calling:

![dag3](https://user-images.githubusercontent.com/53608357/99771365-0a3a9200-2b2f-11eb-9192-a80931e85b8d.png)

  ## Usage
  
  After finishing the setup and enabling the conda environment, navigate to VCF_Gen/ directory with Snakefile and do a dry run to check for errors
    
  ```
  snakemake -n
  ```
  
  Once you're ready to run the analysis, type

  ```
  snakemake --use-conda --cores 16              
  ```
    
  The minimum number of 2 cores to be given depending on your system configuration.

# Running MutVis-Genome mutation TvTi plot generation

Here is an overview of the Snakemake rule graph for TvTi plot for whole genome:

<p align="center">
  <img src="https://user-images.githubusercontent.com/53608357/100833351-cbda9680-348f-11eb-800e-729e9d67646a.png">
</p>

 Once you're ready with the vcf files, type

  ```
  snakemake --use-conda --cores 16  MutVis_TiTvGenome_Plots        
  ```
    
  The minimum number of 2 cores to be given depending on your system configuration.
  This results in the proportion and frequency plots of trasition and transversion observed across the whole genome. 
  
# Running MutVis-Gene TvTi plot generation

Here is an overview of the Snakemake rule graph for TvTi plot for selected gene :

<p align="center">
  <img src="https://user-images.githubusercontent.com/53608357/100833803-b1ed8380-3490-11eb-87a0-fc6e146784e9.png">
</p>



 To analyse specific genes, 
 
 Provide the gene coordinates in the config file ( start and end position of the gene to be analysed) and then type,
 
 
  ```
  snakemake --use-conda --cores 16  MutVis_TiTvGene_Plots        
  ```
    
  The minimum number of 2 cores to be given depending on your system configuration.
  This results in the proportion and frequency plots of trasition and transversion observed in the specified gene. 
  
  

# Running MutVis-Mutation signature analysis
Here is an overview of the Snakemake rule graph for Mutation signature analysis :

<p align="center">
  <img src="https://user-images.githubusercontent.com/53608357/100834217-861ecd80-3491-11eb-8a47-ff106f6f1969.png">
</p>


 To derive mutation signatures for the given set of samples, type

  ```
  snakemake --use-conda --cores 16 MutVis_MutSign        
  ```
    
  The minimum number of 2 cores to be given depending on your system configuration.
  This results in the mutation count matrix, base substitution matrix, relative contribution of derived mutation signatures for the given samples and clustered heatmap. 

# Tutorial



```
Box made with Triple Backticks
```





>[!WARNING]
>This is a warning

