# Main Workflow - TvTi(Transition and transversion) frequency and proportion analysis and visualization
#                 & Mutation Siganture analysis in bacterial strains.
#
# Contributors: @Akshatha Prasanna


# Packages installed in yml files

# conda install -c r r-data.table
# conda install -c bioconda/label/cf201901 bioconductor-genvisr
# conda install -c r r-gridextra
# conda install -c r r-dplyr
# conda install -c conda-forge r-devtools
# library(devtools)
# devtools::install_github("carjed/musigtools")
# conda install -c conda-forge r-rlist
# conda install -c bioconda bioconductor-mutationalpatterns


# --- Main Build Rules --- #
## To be constructed
#
(IDS,) = glob_wildcards("./data/vcf/{ip}.vcf")

rule all:
    input:
        helmsman_out_check = expand("output_helmsman/{ip}/subtype_count_matrix.txt",ip=IDS)

rule helmsman:
    input:
        ref="data/fasta/reference_genome.fasta",
        vcf_files="data/vcf/{ip}.vcf"
    output:
        "output_helmsman/{ip}/subtype_count_matrix.txt"

    params:
         output_path  = "output_helmsman/{ip}/"

    conda: 'scripts/helmsman/env.yml'
    shell:
        "python scripts/helmsman/helmsman.py --input {input.vcf_files} --fastafile {input.ref} --projectdir {params.output_path}"


rule MutVis_vcf_read:
    input : "scripts/VcfRead.R"
    output: "scripts/vcf_files_vc.rds"
    conda: 'env/env_datatable.yml'
    shell:
        "Rscript {input}"

rule MutVis_TiTv_Gene:
    input:
        rds1 = "scripts/vcf_files_vc.rds",
        script1 = "scripts/position_filtering.R"
    output: "scripts/vcf_pos.rds"
    conda: 'env/env_dplyr.yml'
    shell:
        "Rscript {input.script1}"
#
rule MutVis_vcf_format:
    input:
        rds2 =  "scripts/vcf_pos.rds",
        script2 = "scripts/vcf_combine_gene.R"

    output: "scripts/vcf_combine_gene.rds"
    conda: 'env/env_datatable.yml'
    shell:
        "Rscript {input.script2}"
#
rule MutVis_TiTv_Genome:
    input:
        rds3 = "scripts/vcf_files_vc.rds",
        script3 = "scripts/GenVisR_vcf_combine.r"

    output: "scripts/vcf_combine_genome.rds"
    conda: 'env/env_datatable.yml'
    shell:
        "Rscript {input.script3}"
#
rule MutVis_TiTvGene_Plots:
    input:
        rds4 = "scripts/vcf_combine_gene.rds",
        script4 = "scripts/GenVisR_gene_based_TVTI.r"

    conda: 'env/environment_droplet.yml'
    shell:
        "Rscript {input.script4}"
#
rule MutVis_TiTvGenome_Plots:
    input:
        rds5 = "scripts/vcf_combine_genome.rds",
        script5 = "scripts/GenVisR_genome_based_TVTI.R"
    conda: 'env/environment_droplet.yml'
    shell:
        "Rscript {input.script5}"


#
rule MutVis_norm:
    input:
        # matrix = "output_helmsman/{ip}/subtype_count_matrix.txt",
        script6 = "scripts/norm.R"
    output: "scripts/df_norm.rds"
    conda: 'env/env_datatable.yml'
    shell:
        "Rscript {input.script6}"

rule MutVis_addID:
    input:
        rds6 = "scripts/df_norm.rds",
        script7 = "scripts/check.R"
    output: "scripts/df_t.rds"
    conda: 'env/env_rlist.yml'
    shell:
        "Rscript {input.script7}"

rule MutVis_FormatMatrix:
    input:
        rds7 = "scripts/df_t.rds",
        script8 = "scripts/format_matrix.R"
    output: "scripts/msm_MutationalPatterns.rds"
    conda: 'env/env_devtools.yml'
    shell:
        "Rscript {input.script8}"
#
rule MutVis_CombineMatrix:
    input:
        rds8 = "scripts/msm_MutationalPatterns.rds",
        script9 = "scripts/combine_matrix.R"
    output: "scripts/msm_MutationalPatterns_combined.rds"
    conda: 'env/env_rlist.yml'
    shell:
        "Rscript {input.script9}"


rule MutVis_MutSign:
    input:
        rds9 = "scripts/msm_MutationalPatterns_combined.rds",
        script10 = "scripts/MutSign.R"
    conda: 'env/env_mutsign.yml'
    shell:
        "Rscript {input.script10}"
