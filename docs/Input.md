## Input

### Input source and format

FuSViz accepts input files from three sources:

* Aggregated multiple-sample SV calls from RNA-seq data (e.g. [RNA_SV_example.txt](https://fusviz.s3.eu-north-1.amazonaws.com/RNA_SV_example.txt))
* Aggregated multiple-sample SV calls from DNA-seq data (e.g. [DNA_SV_example.txt](https://fusviz.s3.eu-north-1.amazonaws.com/DNA_SV_example.txt))
* Aggregated multiple-sample small variants (SNVs+Indels) from DNA-seq data (e.g. [TCGA.PRAD.mutect.somatic.maf](https://fusviz.s3.eu-north-1.amazonaws.com/TCGA.PRAD.mutect.somatic.maf))

To run FuSViz, it needs SV calls from either one or both of DNA-seq and RNA-seq. Mutation profile is optional, but recommended.

#### Description of input format for RNA-seq SV calls

> Column 1st: **chrom1** – chromosome name of upstream partner’s breakpoint (must be started with “chr”).  
> Column 2nd: **pos1** - genomic coordinate of upstream partner’s breakpoint.  
> Column 3rd: **gene1** - symbol name of upstream partner gene.  
> Column 4th: **chrom2** - chromosome name of downstream partner’s breakpoint (must be started with “chr”).  
> Column 5th: **pos2** - genomic coordinate of downstream partner’s breakpoint.  
> Column 6th: **gene2** - symbol name of downstream partner gene.  
> Column 7th: **name** - sample/patient/case ID.  
> Column 8th: **split** - the number of support reads across the breakpoint of SV.  
> Column 9th: **span** - the number of discordant read pairs supporting the SV.  
> Column 10th: **strand1** – the strand direction of upstream fusion sequence.  
> Column 11th: **strand2** – the strand direction of downstream fusion sequence.  
> Column 12th: **untemplated_insert** – the untemplated insert sequence.  

#### Description of input format for DNA-seq SV calls

> Column 1st: **chrom1** - chromosome name on which the first end of SV exists (must be started with “chr”).  
> Column 2nd: **start1** - zero-based starting position of the first end of SV on chrom1.  
> Column 3rd: **end1** - one-based ending position of the first end of SV on chrom1.  
> Column 4th: **chrom2** - chromosome name on which the second end of SV exists (must be started with “chr”).  
> Column 5th: **start2** - zero-based starting position of the second end of SV on chrom2.  
> Column 6th: **end2** - one-based ending position of the second end of SV on chrom2.  
> Column 7th: **name** - sample/patient/case id.  
> Column 8th: **type** - the type of SV (e.g. BND - translocation, DEL- deletion, DUP - duplication, INS - insertion, INV - inversion).  
> Column 9th: **split** - the number of support reads across the breakpoint of SV.  
> Column 10th: **span** - the number of discordant read pairs supporting the SV.  
> Column 11th: **gene1** - symbol name if the first end of SV within genic region, otherwise it is tagged as `*`.  
> Column 12th: **gene2** - symbol name if the second end of SV within genic region, otherwise it is tagged as `*`.  

#### Description of input format for mutation profile

A full description of the columns in MAF format and their definitions are at https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/#introduction. **Eight** columns are required for FuSViz:

> Column **Hugo_Symbol** - gene symbol name.  
> Column **Chromosome** - chromosome name (must be started with “chr”).  
> Column **Start_Position** - genomic start coordinate of a variant on the chromosome.  
> Column **End_Position** - genomic end coordinate of a variant on the chromosome.  
> Column **Reference_Allele** - reference allele type.  
> Column **Tumor_Seq_Allele2** - alternative allele type.  
> Column **Variant_Classification** - variant consequence on protein alteration.  
> Column **Tumor_Sample_Barcode** - sample/patient/case ID.  

### Prepare input files for FuSViz

FuSViz does not take raw output of SV callers as input. Here, we provide an in-house script **SV_standard.pl** to prepare the input format for FuSViz. In short, SV calls of sample cohort are aggregated directly if one caller is used. Sometimes multiple callers are utilized - **SV_standard.pl** firstly merges and makes a consensus set from output of multiple callers per sample, then aggregates the results of all samples together. This script depends on the tool [SURVIVOR](https://github.com/fritzsedlazeck/SURVIVOR) (download and install it according to the developer’s instruction and make it available in your `$PATH`).

#### Installation

After downloading [SV_standard.pl](https://github.com/senzhaocode/SV_standard), add Perl library path to environment variables

	PERL5LIB="$PERL5LIB:/where_is_path/SV_standard/lib"
	export PERL5LIB

#### Run SV_standard.pl to merge and aggregate SV calls from DNA-seq data

Run an example:

	perl SV_standard.pl \
	--type DNA \
	--genome hg38 \
	--filter PASS \
	--anno /where_is_path/SV_standard/anno \
	--input /where_is_path/SV_standard/example/DNA/input  \
	--output output_dna_dir

* The organization of */where_is_path/SV_standard/example/DNA/input* directory:

```
/where_is_path/SV_standard/DNA/input
|
|_____ T001 (sample name)
|		|____ Manta.vcf.gz (rename Manta output VCF file to 'Manta.vcf.gz').
|		|____ Svaba.vcf (rename Svaba output VCF file to 'Svaba.vcf' after SVTYPE re-classification using 'SV_standard/script/svaba_svtype.R').
|
|_____ T002 (sample name)
|		|____ Delly.vcf (rename Delly output VCF file to 'Delly.vcf').
|
|_____ T003 (sample name)
		|____ Lumpy.vcf (rename Lumpy output VCF file that is genotyed by *SVTyper* tool to 'Lumpy.vcf').
```

* **SV_standard.pl** supports a merging of DNA SVs from four callers currently. As VCF output fields of callers with different versions may be somewhat variable, we recommend users run SV calls using the following version: *Manta* (>= v1.6.0), *svaba* (>= 1.1.0), *Delly* (>= v0.8.7) and *lumpy* (>= v0.3.1). VCF file in compressed format (i.e. vcf.gz) is acceptable.
* `Final_DNA_SVs.txt` in *output_dna_dir* directory is an example of DNA SV input file for FuSViz. In general, breakpoint is annotated with a gene symbol if it falls in a genic region, otherwise it is annotated as **'\*'**. If more than two gene annotations are available, a few prioritization rules are applied: 
	* Protein coding genes are always prioritised (non- 'ORF' gene is chosen when a 'ORF' gene is present).
	* miRNA and lincRNA are prioritised if no protein coding gene annotations are available. 
	* When gene nomenclature is not available, **ENSEMBL** gene_id is used for denotation.
* `--filter PASS` suggests SVs tagged as “PASS” or "." in VCF file are kept in data processing.
*  The principle of SV merging per sample - SVs detected by at least one caller are included.

#### Run SV_standard.pl to merge and aggregate SV calls from RNA-seq data

Run an example:

	perl SV_standard.pl \
	--type RNA \
	--genome hg38 \
	--anno /where_is_path/SV_standard/anno \
	--input /where_is_path/SV_standard/example/RNA/input \
	--output output_rna_dir

* The organization of */where_is_path/SV_standard/example/RNA/input* directory:

```
input_rna_dir
|
|_____ T001 (sample name)
|		|____ Arriba.tsv (rename Arriba output file 'fusion.tsv' to 'Arriba.tsv').
|		|____ STAR-fusion.tsv (rename STAR-fusion output file 'star-fusion.fusion_predictions_loose.tsv' to 'STAR-fusion.tsv').
|
|_____ T002 (sample name)
		|____ Dragen.txt (rename Dragen output file 'XXX.fusion_candidates.final' to 'Dragen.txt').
		|____ Fusioncatcher.txt (rename Fusioncatcher output file 'final-list_candidate-fusion-genes.txt' to 'Fusioncatcher.txt').
```

* **SV_standard.pl** supports a merging of RNA SVs from five callers currently. As output format of callers with differen versions may be somewhat variable, we recommend users run SV calls using the following version: *deFuse* (>= v0.8.1), *fusioncatcher* (>= v1.2.0), *arriba* (>= v2.0.0), *STAR-Fusion* (>= v1.9.1) and *Dragen* (>= v3.9.3).
* `Final_RNA_SVs.txt` in *output_rna_dir* directory is an example of RNA SV input file for FuSViz. Names of fusion partner genes are standardized if they are incongruent (related to synonymous gene nomenclature) among multiple callers. If gene nomenclature is not available, **ENSEMBL** gene_id is used for denotation.
* **SV_standard.pl** applies some filters to reduce false positives: 
	* RNA SVs nominated by any caller **MUST** meet the support number of split reads >= 2.
	* For filtering *deFuse* calls , `splitr_span_pvalue > 0.05`, `splitr_pos_pvalue > 0.05`, `splitr_min_pvalue > 0.05`, `breakpoint_homology <= 5`, `num_multi_map/span_count < 0.2` and `probability > 0.05` need to be met.
* The principle of SV merging per sample - SVs detected by at least one caller are included.

#### For usage of **SV_standard.pl** arguments

	perl SV_standard.pl --help 
	--type {DNA, RNA}
	#// choose input SV calls from DNA-seq or RNA-seq.
	--genome {hg19, hg38} 
	#// genome version used for SV calling
	--filter {PASS, ALL}
	#// Set an option for filtering raw SV calls (default: PASS), only available for DNA SVs
	--support {min, max, median}
	#// Set a method to obtain split and spanning read support if SVs from multiple callers are available (default: median)
	--offset {default: 1000}
	#// Set an offset value for extending a gene interval, e.g. [start-offset pb, end+offset bp]
	--anno "/where_is_path/SV_standard/anno"
	#// Set annotation file directory
	--input "input_directory_path"
	#// Set input directory path
	--output "output_directory_path"
	#// Set output directory path

#### Input of mutation profile (optional)

FuSViz utilizes input of mutation profile in Muation Annotation Format (MAF), which is tab-delimited text file with aggregated mutation information (SNVs+Indels) from multiple VCF files. In general, the tool [vcf2maf](https://github.com/mskcc/vcf2maf) is used to convert VCF to MAF and aggregate results of multiple samples.

#### Run SV_standard.pl via Singularity container

COMING SOON

