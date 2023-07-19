# msms2lda Nextflow

To test the workflow simply do

```
make run [-e --input_format "$(input_format)" --input_iterations $(input_iterations) --input_minimum_ms2_intensity $(input_minimum_ms2_intensity) --input_free_motifs $(input_free_motifs) --input_bin_width $(input_bin_width) --input_network_overlap $(input_network_overlap) --input_network_pvalue $(input_network_pvalue) --input_network_topx $(input_network_topx) --gnps_motif_include "$(gnps_motif_include)" --massbank_motif_include  "$(massbank_motif_include)" --urine_motif_include "$(urine_motif_include)" --euphorbia_motif_include "$(euphorbia_motif_include)" --rhamnaceae_motif_include "$(rhamnaceae_motif_include)" --strep_salin_motif_include "$(strep_salin_motif_include)" --photorhabdus_motif_include "$(photorhabdus_motif_include)" --user_motif_sets "$(user_motif_sets)" --input_mgf_file "$(input_mgf_file)" --input_pairs_file "$(input_pairs_file)" --input_mzmine2_folder "$(input_mzmine2_folder)" --output_prefix "output_ms2lda"]
```

If you do not specify an input file, by default it will take the sample files located in [data/specs_ms.mgf](data/specs_ms.mgf) for the spectra,  and the mzXML files containing the [pairs](data/data/pairs.tsv) and [quantification from mzmine](data/quantification_table_reformatted.csv) spectra. The default values for parameters can be seen at [Makefile](Makefile) or [nf_workflow.nf](nf_workflow.nf). 

To learn NextFlow checkout this documentation:

https://www.nextflow.io/docs/latest/index.html

## Parameters in nextflow 

The parameters in nextflow follow the next priority:

i. Parameters specified on the command line (--something value)
ii. Parameters provided using the -params-file option
iii. Config file specified using the -c my_config option
iv. The config file named nextflow.config in the current directory
v. The config file named nextflow.config in the workflow project directory
vi. The config file $HOME/.nextflow/config
vii. Values defined within the pipeline script itself (e.g. main.nf)

In case you wish to set your parameters directly in nextflow, please use the next syntaxis:


```
nextflow [options] ./nf_workflow.nf --input_format "$(input_format)" --input_iterations $(input_iterations) --input_minimum_ms2_intensity $(input_minimum_ms2_intensity) --input_free_motifs $(input_free_motifs) --input_bin_width $(input_bin_width) --input_network_overlap $(input_network_overlap) --input_network_pvalue $(input_network_pvalue) --input_network_topx $(input_network_topx) --gnps_motif_include "$(gnps_motif_include)" --massbank_motif_include  "$(massbank_motif_include)" --urine_motif_include "$(urine_motif_include)" --euphorbia_motif_include "$(euphorbia_motif_include)" --rhamnaceae_motif_include "$(rhamnaceae_motif_include)" --strep_salin_motif_include "$(strep_salin_motif_include)" --photorhabdus_motif_include "$(photorhabdus_motif_include)" --user_motif_sets "$(user_motif_sets)" --input_mgf_file "$(input_mgf_file)" --input_pairs_file "$(input_pairs_file)" --input_mzmine2_folder "$(input_mzmine2_folder)" --output_prefix "output_ms2lda" --resume -c nextflow.config
```

## Run in a conda environment

To run the workflow in a conda environment, there is a configuration file [conda_env.yml](bin/conda_env.yml). This file configured the environment named msms-choser-env. It can be created and activated by:

```
conda env create -f bin/conda_env.yml
conda activate msms-choser-env
```

and then the workflow can be executed from the conda environment. If you do not specify an input file, by default it will take the sample files located in [data/specs_ms.mgf](data/specs_ms.mgf) for the spectra,  and the mzXML files containing the [pairs](data/data/pairs.tsv) and [quantification from mzmine](data/quantification_table_reformatted.csv) spectra. The default values for parameters can be seen at [Makefile](Makefile) or [nf_workflow.nf](nf_workflow.nf). 

```
nextflow [options] ./nf_workflow.nf --annotations="$(annotations_file)" --path_to_spectra="$(path_to_spectra)" --ppm_tolerance=$(ppm_tolerance) --resume -c nextflow.config
```


## Deployment in GNPS2

Check [Nexftlow template instructions from Mingxun Wang](https://github.com/Wang-Bioinformatics-Lab/Nextflow_Workflow_Template)
