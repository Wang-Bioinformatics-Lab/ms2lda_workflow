# msms2lda Nextflow

To test the workflow simply do

```
make run [-e --annotations=<annotations_file> --xmlpath=<xmlpath)> --ppm_tolerance=<ppm_tolerance>]
```

If you do not specify an input file, by default it will take the sample files located in [data/annotations.tsv](data/annotations.tsv) and the mzXML files containing the [positive](data/sulfamethizine_positive_2pt5uL_01.mzXML) and [negative](data/sulfamethizine_negative_2pt5uL_01.mzXML) spectra. The default ppm_tolerance is 10.0

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
nextflow [options] ./nf_workflow.nf --annotations="$(annotations_file)" --path_to_spectra="$(path_to_spectra)" --ppm_tolerance=$(ppm_tolerance) --resume -c nextflow.config
```

## Run in a conda environment

To run the workflow in a conda environment, there is a configuration file [conda_env.yml](bin/conda_env.yml). This file configured the environment named msms-choser-env. It can be created and activated by:

```
conda env create -f bin/conda_env.yml
conda activate msms-choser-env
```

and then the workflow can be executed from the conda environment. If you do not specify an input file, by default it will take the sample files located in [data/annotations.tsv](data/annotations.tsv) and the mzXML files containing the [positive](data/sulfamethizine_positive_2pt5uL_01.mzXML) and [negative](data/sulfamethizine_negative_2pt5uL_01.mzXML) spectra.

```
nextflow [options] ./nf_workflow.nf --annotations="$(annotations_file)" --path_to_spectra="$(path_to_spectra)" --ppm_tolerance=$(ppm_tolerance) --resume -c nextflow.config
```