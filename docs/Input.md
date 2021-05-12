## Input

FuSViz accepts input files from three sources:

* Aggregated SV callings from multiple samples RNA-seq data (e.g. [RNA_SV_example.txt](https://fusviz.s3.eu-north-1.amazonaws.com/RNA_SV_example.txt))
* Aggregated SV callings from multiple samples DNA-seq data (e.g. [DNA_SV_example.txt](https://fusviz.s3.eu-north-1.amazonaws.com/DNA_SV_example.txt))
* Aggregated mutation variants (SNVs+Indels) from multiple samples DNA-seq data (e.g. [TCGA.PRAD.mutect.somatic.maf](https://fusviz.s3.eu-north-1.amazonaws.com/TCGA.PRAD.mutect.somatic.maf))

To run FuSViz needs SV callings from either one or both of DNA-seq and RNA-seq. Mutation profile is an optional, but recommended.

### Input of SV callings from DNA-seq / RNA-seq data

FuSViz does not take raw output of any SV callers as input. Here, we provide an in-house script **SV_standard** to prepare the input format for FuSViz. In short, SV callings of all samples are aggregated directly if only one caller is used for detection. Sometimes multiple callers are utilized - **SV_standard** firstly merges and makes a consensus set from output of multiple callers for one sample, then aggregates the results of all samples. This script depends on the tool [SURVIVOR](https://github.com/fritzsedlazeck/SURVIVOR) (download and install it according to the developers’ instructions and make it available in your `$PATH`).

#### Use **SV_standard** to merge/aggregate SV callings from DNA-seq data

Run an example:

	./SV_standard \
	--type DNA \
	--genome hg38 \
	--Manta “/path/folder_Manta” \ #// contains multiple-sample DNA SV callings in VCF format from Manta 
	--Lumpy "/path/folder_Lumpy" \ #// contains multiple-sample DNA SV callings in VCF format from Lumpy
	--Delly "/path/folder_Delly" \ #// contains multiple-sample DNA SV callings in VCF format from Delly
	--output "“/path/ouput_dna.bedpe"

* VCF file should be uncompressed.
* VCF file name of each sample in “/path/folder_Manta”, “/path/folder_Delly” and “/path/folder_Lumpy” should be identical.
* SVs tagged as “PASS” and "." in VCF file are kept in final result.
* Currently, output from SV callers (Menta, GRISSS, Lumpy, Delly and SvABA) is supported by **SV_standard**.

#### Use **SV_standard** to merge/aggregate SV callings from RNA-seq data

Run an example:

	./SV_standard \
	--type RNA \
	--genome hg38 \
	--Arriba “/path/folder_Arriba” \ #// contains multiple-sample RNA SV callings from Arriba 
	--STAR-Fusion “/path/folder_STAR-Fusion” \ #// contains multiple-sample RNA SV callings from STAR-Fusion
	--FusionCatcher “/path/folder_FusionCatcher” \ #// contains multiple-sample RNA SV callings from FusionCatcher
	--output “/path/output_rna.txt”

* **SV_standard** supports SV output from six callers (i.e. STAR-fusion, Arriba, deFuse, FusionCatcher, SOAPFuse and Pizzly). For some callers, several output files are generated in data processing and the output format of different versions shows somewhat variable. An extra note is made on which type of output from a caller (>= version X) is used as an input by SV_standard.
	* For deFuse (>=??)
	* For FusionCatcher (>=??)
	* For Arriba (>=??)
	* For STAR-Fusion (>=??)
	* For SOAPFuse (>=??)
	* For Pizzly (>=??)
* file name for each sample in “/path/folder_Arriba”, “/path/folder_STAR-Fusion” and “/path/FusionCatcher” should be identical.

#### For usage of **SV_standard** arguments

	./SV_standard --help 
	--type {DNA, RNA}
	#// either DNA or RNA. If DNA is set, --Manta, --Delly, --Lumpy will be activated; otherwise --Arriba, --STAR-fusion, --deFuse, --SOAPFuse and –Pizzly are valid.
	--genome {hg19, hg38} 
	#// genome version
	--dis {max distance between breakpoints during merging, default: 500}
	--sv_type {whether SV type is needed the same during merging, default: yes}
	--sv_strand {whether SV strand is needed the same during merging, default: no}
	--size {min size of SVs to be taken in account, default: 0}

#### Run **SV_standard** via Singularity container

COMING SOON

### Input of mutation profile (optional)

FuSViz only accepts input of mutation profile in Muation Annotation Format (MAF), which is tab-delimited text file with aggregated mutation information (SNVs+Indels) from multiple VCF files. In general, users can use the tool [vcf2maf](https://github.com/mskcc/vcf2maf) to convert VCF to MAF and aggregate results of multiple samples.

