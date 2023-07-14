#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.input_mgf_file = "data/annotations.tsv"
params.input_pairs_file = "data/"
params.input_mzmine2_folder = "./nf_output"
params.ppm_tolerance = 10.0

// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"

TOOL_FOLDER = "$baseDir/bin"

process processCandidates {
    publishDir "$params.publishdir", mode: 'copy', overwrite: false

    input:
    path annotations, name: params.annotations
    path path_to_spectra, name: params.path_to_spectra
    val ppm_tolerance

    
    output:
    path "batchfile.tsv"

    """

    python $TOOL_FOLDER/prepare_library_addtions_gnps_collections.py $annotations $path_to_spectra batchfile.tsv --ppm_tolerance $ppm_tolerance
    """
}


workflow{
    ch1 = Channel.fromPath(params.annotations) 
    ch2 = Channel.fromPath(params.path_to_spectra) 
    processCandidates(ch1,ch2,params.ppm_tolerance)
}



parser.add_argument('input_format', help='input_format')
parser.add_argument('input_iterations', type=int, help='input_iterations')
parser.add_argument('input_minimum_ms2_intensity', type=float, help='input_minimum_ms2_intensity')
parser.add_argument('input_free_motifs', type=int, help='input_free_motifs')
parser.add_argument('input_bin_width', type=float, help='input_bin_width')
parser.add_argument('input_network_overlap', type=float, help='input_network_overlap')
parser.add_argument('input_network_pvalue', type=float, help='input_network_pvalue')
parser.add_argument('input_network_topx', type=int, help='input_network_topx')

parser.add_argument('gnps_motif_include', help='gnps_motif_include')
parser.add_argument('massbank_motif_include', help='massbank_motif_include')
parser.add_argument('urine_motif_include', help='urine_motif_include')
parser.add_argument('euphorbia_motif_include', help='euphorbia_motif_include')
parser.add_argument('rhamnaceae_motif_include', help='rhamnaceae_motif_include')
parser.add_argument('strep_salin_motif_include', help='strep_salin_motif_include')
parser.add_argument('photorhabdus_motif_include', help='photorhabdus_motif_include')
parser.add_argument('user_motif_sets', help='user_motif_sets')

parser.add_argument('input_mgf_file', help='input_mgf_file')
parser.add_argument('input_pairs_file', help='input_pairs_file')
parser.add_argument('input_mzmine2_folder', help='input_mzmine2_folder')
parser.add_argument('output_prefix', help='output_prefix')


python bin/lda/ms2lda_runfull.py --input_format "mzmine" --input_iterations 1 --input_minimum_ms2_intensity 100 --input_free_motifs 300 --input_bin_width 0.005 --input_network_overlap 0.3 --input_network_pvalue 0.1 --input_network_topx 5 --gnps_motif_include "yes" --massbank_motif_include  "yes" --urine_motif_include "yes" --euphorbia_motif_include "no" --rhamnaceae_motif_include "no" --strep_salin_motif_include "no" --photorhabdus_motif_include "no" --user_motif_sets "None" --input_mgf_file "data/specs_ms.mgf" --input_pairs_file "data/networkedges_selfloop/pairs.tsv" --input_mzmine2_folder "data/quantification_table_reformatted.csv" --output_prefix "nf_output/whatever"