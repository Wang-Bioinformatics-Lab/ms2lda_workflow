#!/usr/bin/env nextflow
nextflow.enable.dsl=2



params.publishdir = "./nf_output"
params.input_format = "mzmine"
params.input_iterations = 1000
params.input_minimum_ms2_intensity = 100
params.input_free_motifs = 300
params.input_bin_width = 0.005
params.input_network_overlap = 0.3
params.input_network_pvalue = 0.1
params.input_network_topx = 5


params.gnps_motif_include = "yes"
params.massbank_motif_include = "yes"
params.urine_motif_include = "yes"
params.euphorbia_motif_include = "no"
params.rhamnaceae_motif_include = "no"
params.strep_salin_motif_include = "no"
params.photorhabdus_motif_include = "no"
params.user_motif_sets = "None"

params.input_mgf_file = "data/specs_ms.mgf"
params.input_pairs_file = "data/pairs.tsv"
params.input_mzmine2_folder = "data/quantification_table_reformatted.csv" 

// parms for graphml
params.output_graphml = "ms2lda_network.graphml"
params.output_pairs = "ms2lda_pairs.tsv"


// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"

TOOL_FOLDER = "$baseDir/bin"

def printParams(){
    println $parms.input_format $params.publishDir
}

process processMS2LDA {
    publishDir "$params.publishdir", mode: 'copy', overwrite: false

    input:
    path mgf_file, name: params.input_mgf_file
    path pairs_file, name: params.input_pairs_file
    path mzmine, name: params.input_mzmine2_folder
    val input_format
    val input_iterations
    val input_minimum_ms2_intensity
    val input_free_motifs
    val input_bin_width
    val input_network_overlap
    val input_network_pvalue
    val input_network_topx
    val gnps_motif_include
    val massbank_motif_include
    val urine_motif_include
    val euphorbia_motif_include
    val rhamnaceae_motif_include
    val strep_salin_motif_include
    val photorhabdus_motif_include
    val user_motif_sets

    output:
    path "ms2lda_nf_motifs_in_scans.tsv", emit: motifs
    path "ms2lda_nf_ms2lda_edges.tsv", emit: edges
    path "ms2lda_nf_ms2lda_nodes.tsv", emit: nodes
    
    
    """
    python $TOOL_FOLDER/lda/ms2lda_runfull.py --input_format $input_format --input_iterations $input_iterations --input_minimum_ms2_intensity $input_minimum_ms2_intensity --input_free_motifs $input_free_motifs --input_bin_width $input_bin_width --input_network_overlap $input_network_overlap --input_network_pvalue $input_network_pvalue --input_network_topx $input_network_topx --gnps_motif_include $gnps_motif_include --massbank_motif_include  $massbank_motif_include --urine_motif_include $urine_motif_include --euphorbia_motif_include $euphorbia_motif_include --rhamnaceae_motif_include $rhamnaceae_motif_include --strep_salin_motif_include $strep_salin_motif_include --photorhabdus_motif_include $photorhabdus_motif_include --user_motif_sets $user_motif_sets --input_mgf_file $mgf_file --input_pairs_file $pairs_file --input_mzmine2_folder $mzmine --output_prefix "ms2lda_nf"

    """
}

process processGraphML {
    publishDir "$params.publishdir", mode: 'copy', overwrite: false

    input:
    path motifs
    path edges
    val input_network_overlap
    val input_network_pvalue
    val input_network_topx

    output:
    path "ms2lda.graphml"
    path "pairs.tsv"
    

    """
    python $TOOL_FOLDER/lda/create_graphml.py --ms2lda_results $motifs --input_network_edges $edges --output_graphml "ms2lda.graphml" --output_pairs "pairs.tsv" --input_network_pvalue $input_network_pvalue --input_network_overlap $input_network_overlap --input_network_topx $input_network_topx 
    """    
}



workflow{
    ch1 = Channel.fromPath(params.input_mgf_file) 
    ch2 = Channel.fromPath(params.input_pairs_file) 
    ch3 = Channel.fromPath(params.input_mzmine2_folder) 
    processMS2LDA(ch1,ch2,ch3,params.input_format, params.input_iterations, params.input_minimum_ms2_intensity, params.input_free_motifs, params.input_bin_width, params.input_network_overlap, params.input_network_pvalue, params.input_network_topx, params.gnps_motif_include, params.massbank_motif_include, params.urine_motif_include, params.euphorbia_motif_include, params.rhamnaceae_motif_include, params.strep_salin_motif_include, params.photorhabdus_motif_include, params.user_motif_sets) 
    processGraphML(processMS2LDA.out.motifs, processMS2LDA.out.edges, params.input_network_pvalue, params.input_network_overlap, params.input_network_topx)
}
