input_format = "mzmine"
input_iterations = 1000
input_minimum_ms2_intensity = 100
input_free_motifs = 300
input_bin_width = 0.005
input_network_overlap = 0.3
input_network_pvalue = 0.1
input_network_topx = 5


gnps_motif_include = "yes"
massbank_motif_include = "yes"
urine_motif_include = "yes"
euphorbia_motif_include = "no"
rhamnaceae_motif_include = "no"
strep_salin_motif_include = "no"
photorhabdus_motif_include = "no"
user_motif_sets = "None"

input_mgf_file = "data/specs_ms.mgf"
input_pairs_file = "data/pairs.tsv"
input_mzmine2_folder = "data/quantification_table_reformatted.csv" 

clean:
	rm -Rf .nextflow* work bin/*__pycache__* nf_output/*

run:
	nextflow run ./nf_workflow.nf --input_format "$(input_format)" --input_iterations $(input_iterations) --input_minimum_ms2_intensity $(input_minimum_ms2_intensity) --input_free_motifs $(input_free_motifs) --input_bin_width $(input_bin_width) --input_network_overlap $(input_network_overlap) --input_network_pvalue $(input_network_pvalue) --input_network_topx $(input_network_topx) --gnps_motif_include "$(gnps_motif_include)" --massbank_motif_include  "$(massbank_motif_include)" --urine_motif_include "$(urine_motif_include)" --euphorbia_motif_include "$(euphorbia_motif_include)" --rhamnaceae_motif_include "$(rhamnaceae_motif_include)" --strep_salin_motif_include "$(strep_salin_motif_include)" --photorhabdus_motif_include "$(photorhabdus_motif_include)" --user_motif_sets "$(user_motif_sets)" --input_mgf_file "$(input_mgf_file)" --input_pairs_file "$(input_pairs_file)" --input_mzmine2_folder "$(input_mzmine2_folder)" --output_prefix "output_ms2lda" -resume -c nextflow.config

run_hpcc:
	nextflow run ./nf_workflow.nf --input_format "$(input_format)" --input_iterations $(input_iterations) --input_minimum_ms2_intensity $(input_minimum_ms2_intensity) --input_free_motifs $(input_free_motifs) --input_bin_width $(input_bin_width) --input_network_overlap $(input_network_overlap) --input_network_pvalue $(input_network_pvalue) --input_network_topx $(input_network_topx) --gnps_motif_include "$(gnps_motif_include)" --massbank_motif_include  "$(massbank_motif_include)" --urine_motif_include "$(urine_motif_include)" --euphorbia_motif_include "$(euphorbia_motif_include)" --rhamnaceae_motif_include "$(rhamnaceae_motif_include)" --strep_salin_motif_include "$(strep_salin_motif_include)" --photorhabdus_motif_include "$(photorhabdus_motif_include)" --user_motif_sets "$(user_motif_sets)" --input_mgf_file "$(input_mgf_file)" --input_pairs_file "$(input_pairs_file)" --input_mzmine2_folder "$(input_mzmine2_folder)" --output_prefix "output_ms2lda" -resume -c nextflow_hpcc.config

run_docker:
	nextflow run ./nf_workflow.nf --input_format "$(input_format)" --input_iterations $(input_iterations) --input_minimum_ms2_intensity $(input_minimum_ms2_intensity) --input_free_motifs $(input_free_motifs) --input_bin_width $(input_bin_width) --input_network_overlap $(input_network_overlap) --input_network_pvalue $(input_network_pvalue) --input_network_topx $(input_network_topx) --gnps_motif_include "$(gnps_motif_include)" --massbank_motif_include  "$(massbank_motif_include)" --urine_motif_include "$(urine_motif_include)" --euphorbia_motif_include "$(euphorbia_motif_include)" --rhamnaceae_motif_include "$(rhamnaceae_motif_include)" --strep_salin_motif_include "$(strep_salin_motif_include)" --photorhabdus_motif_include "$(photorhabdus_motif_include)" --user_motif_sets "$(user_motif_sets)" --input_mgf_file "$(input_mgf_file)" --input_pairs_file "$(input_pairs_file)" --input_mzmine2_folder "$(input_mzmine2_folder)" --output_prefix "output_ms2lda" -resume -with-docker <CONTAINER NAME>