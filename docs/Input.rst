Input
-----

Input source and format
~~~~~~~~~~~~~~~~~~~~~~~

FuSViz accepts input files from three sources:

-  Aggregated SV calls from multiple samples RNA-seq data (e.g.
   `RNA\_SV\_example.txt <https://fusviz.s3.eu-north-1.amazonaws.com/RNA_SV_example.txt>`__)
-  Aggregated SV calls from multiple samples DNA-seq data (e.g.
   `DNA\_SV\_example.txt <https://fusviz.s3.eu-north-1.amazonaws.com/DNA_SV_example.txt>`__)
-  Aggregated mutation variants (SNVs+Indels) from multiple samples
   DNA-seq data (e.g.
   `TCGA.PRAD.mutect.somatic.maf <https://fusviz.s3.eu-north-1.amazonaws.com/TCGA.PRAD.mutect.somatic.maf>`__)

To run FuSViz needs SV calls from either one or both of DNA-seq and
RNA-seq. Mutation profile is optional, but recommended.

Description of input format for RNA-seq SV calls
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    | Column 1st: **chrom1** – chromosome name of upstream partner’s
      breakpoint (must be started with “chr”).
    | Column 2nd: **pos1** - genomic coordinate of upstream partner’s
      breakpoint.
    | Column 3rd: **gene1** - symbol name of upstream partner gene.
    | Column 4th: **chrom2** - chromosome name of downstream partner’s
      breakpoint (must be started with “chr”).
    | Column 5th: **pos2** - genomic coordinate of downstream partner’s
      breakpoint.
    | Column 6th: **gene2** - symbol name of downstream partner gene.
    | Column 7th: **name** - sample/patient/case id.
    | Column 8th: **split** - the number of support reads across the
      breakpoint of SV.
    | Column 9th: **span** - the number of discordant read pairs
      supporting the SV.
    | Column 10th: **strand1** – The strand direction of upstream fusion
      part.
    | Column 11th: **strand2** – The strand direction of downstream
      fusion part.

Description of input format for DNA-seq SV calls
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    | Column 1st: **chrom1** - chromosome name on which the first end of
      SV exists (must be started with “chr”).
    | Column 2nd: **start1** - zero-based starting position of the first
      end of SV on chrom1.
    | Column 3rd: **end1** - one-based ending position of the first end
      of SV on chrom1.
    | Column 4th: **chrom2** - chromosome name on which the second end
      of SV exists (must be started with “chr”).
    | Column 5th: **start2** - zero-based starting position of the
      second end of SV on chrom2.
    | Column 6th: **end2** - one-based ending position of the second end
      of SV on chrom2.
    | Column 7th: **name** - sample/patient/case id.
    | Column 8th: **type** - the type of SV (e.g. BND - translocation,
      DEL- deletion, DUP - duplication, INS - insertion, INV -
      inversion).
    | Column 9th: **split** - the number of support reads across the
      breakpoint of SV.
    | Column 10th: **span** - the number of discordant read pairs
      supporting the SV.
    | Column 11th: **gene1** - symbol name if the first end of SV within
      genic region, otherwise it is tagged as ``*``.
    | Column 12th: **gene2** - symbol name if the second end of SV
      within genic region, otherwise it is tagged as ``*``.

Description of input format for mutation profile
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A full description of the columns in MAF format and their definitions
are at
https://docs.gdc.cancer.gov/Data/File\_Formats/MAF\_Format/#introduction.
**Eight** columns are required for FuSViz:

    | Column **Hugo\_Symbol** - gene symbol name.
    | Column **Chromosome** - chromosome name (must be started with
      “chr”).
    | Column **Start\_Position** - genomic start coordinate of a variant
      on the chromosome.
    | Column **End\_Position** - genomic end coordinate of a variant on
      the chromosome.
    | Column **Reference\_Allele** - reference allele type.
    | Column **Tumor\_Seq\_Allele2** - alternative allele type.
    | Column **Variant\_Classification** - variant consequence on
      protein alteration.
    | Column **Tumor\_Sample\_Barcode** - sample/patient/case id.

Prepare input files for FuSViz
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FuSViz does not take raw output of any SV callers as input. Here, we
provide an in-house script **SV\_standard.pl** to prepare the input
format for FuSViz. In short, SV calls of all samples are aggregated
directly if only one caller is used. Sometimes multiple callers are
utilized - **SV\_standard.pl** firstly merges and makes a consensus set
from output of multiple callers per sample, then aggregates the results
of all samples. This script depends on the tool
`SURVIVOR <https://github.com/fritzsedlazeck/SURVIVOR>`__ (download and
install it according to the developer’s instruction and make it
available in your ``$PATH``).

Installation
^^^^^^^^^^^^

After downloading
`SV\_standard.pl <https://github.com/senzhaocode/SV_standard>`__, add
Perl library path to your environment variables

::

    PERL5LIB="$PERL5LIB:/where_is_path/SV_standard/lib"
    export PERL5LIB

Run SV\_standard.pl to merge and aggregate SV calls from DNA-seq data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Run an example:

::

    perl SV_standard.pl \
    --type DNA \
    --genome hg38 \
    --filter PASS \
    --anno /where_is_path/SV_standard/anno \
    --input /where_is_path/input_dna_dir \
    --output /where_is_path/output_dna_dir

-  The organization of *input\_dna\_dir* directory:

::

    input_dna_dir
    |
    |_____ T001 (sample name)
    |       |____ Manta.vcf.gz (rename output vcf file to 'Manta.vcf.gz').
    |       |____ Svaba.vcf (rename output vcf file to 'Svaba.vcf' after SVTYPE re-classification using 'SV_standard/script/svaba_svtype.R').
    |       |____ Delly.vcf (rename output vcf file to 'Delly.vcf').
    |       |____ Gridss.vcf.gz (rename output vcf file that is post-processed by script 'gridss_somatic_filter' and re-classified in SVTYPE by script 'gridsss/example/simple-event-annotation.R' to 'Gridss.vcf.gz').
    |       |____ Lumpy.vcf (rename output vcf file that is genotyed by 'SVTyper' tool to 'Lumpy.vcf').
    |
    |_____ T002 (sample name)
    |       |____ Manta.vcf, Svaba.vcf, Delly.vcf, Gridss.vcf and Lumpy.vcf
    |
    |_____ T003 (sample name)
            |____ Manta.vcf, Svaba.vcf, Delly.vcf, Gridss.vcf and Lumpy.vcf

-  **SV\_standard.pl** supports a merging of DNA SVs from five callers
   currently. As vcf output fields of callers with differen versions may
   be somewhat variable, we recommend users run SV calls using the
   following version: *Manta* (>= v1.6.0), *svaba* (>= 1.1.0), *Delly*
   (>= v0.8.7), *gridss* (>= v2.12.0) and *lumpy* (>= v0.3.1). VCF file
   in compressed format (i.e. vcf.gz) is acceptable.
-  ``Final_DNA_SVs.txt`` in *output\_dna\_dir* directory is the DNA SV
   input format for FuSViz. In general, breakpoint is annotated by a
   specific gene if it falls in a genic region, otherwise it is
   annotated as **'\*'**. When more than two gene annotations are
   available, a few prioritization rules are applied:

   -  Protein coding genes are always prioritised (non- 'ORF' gene is
      chosen when a 'ORF' gene is present).
   -  miRNA and lincRNA are prioritised if no protein coding gene
      annotations are available.
   -  When gene nomenclature is not available, **ENSEMBL** gene\_id is
      used for denotation.

-  ``--filter PASS`` suggests SVs tagged as “PASS” or "." in VCF file
   are kept in data processing.
-  SV merging principle per sample - SVs detected by at least one caller
   are included.

Run SV\_standard.pl to merge and aggregate SV calls from RNA-seq data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Run an example:

::

    perl SV_standard.pl \
    --type RNA \
    --genome hg38 \
    --anno /where_is_path/SV_standard/anno \
    --input /where_is_path/input_rna_dir \
    --output /where_is_path/output_rna_dir

-  The organization of *input\_rna\_dir* directory:

::

    input_rna_dir
    |
    |_____ T001 (sample name)
    |       |____ Arriba.tsv|txt (rename output file 'fusion.tsv' to 'Arriba.tsv|txt').
    |       |____ STAR-fusion.tsv|txt (rename output file 'star-fusion.fusion_predictions_loose.tsv' to 'STAR-fusion.tsv|txt').
    |       |____ Fusioncatcher.tsv|txt (rename output file 'final-list_candidate-fusion-genes.txt' to 'Fusioncatcher.tsv|txt').
    |       |____ deFuse.tsv|txt (rename output file 'results.classify.tsv' to 'deFuse.tsv|txt').
    |       |____ Dragen.tsv|txt (rename output file 'XXX.fusion_candidates.final' to 'Dragen.tsv|txt').
    |
    |_____ T002 (sample name)
    |       |____ Arriba.tsv|txt, STAR-fusion.tsv|txt, Fusioncatcher.tsv|txt, deFuse.tsv|txt and Dragen.tsv|txt
    |
    |_____ T003 (sample name)
            |____ Arriba.tsv|txt, STAR-fusion.tsv|txt, Fusioncatcher.tsv|txt, deFuse.tsv|txt and Dragen.tsv|txt

-  **SV\_standard.pl** supports a merging of RNA SVs from five callers
   currently. As output format of callers with differen versions may be
   somewhat variable, we recommend users run SV calls using the
   following version: *deFuse* (>= v0.8.1), *fusioncatcher* (>= v1.2.0),
   *arriba* (>= v2.0.0), *STAR-Fusion* (>= v1.9.1) and *Dragen* (>=
   v3.9.3).
-  ``Final_RNA_SVs.txt`` in *output\_rna\_dir* directory is the RNA SV
   input format for FuSViz. Fusion partner gene names are standardized
   if they are incongruent (related to synonymous gene nomenclature)
   among multiple callers. When gene nomenclature is not available,
   **ENSEMBL** gene\_id is used for denotation.
-  **SV\_standard.pl** applies some filters to reduce false positives:

   -  RNA SVs nominated by any caller **MUST** meet the support number
      of split reads >= 2.
   -  For filtering *deFuse* calls , ``splitr_span_pvalue > 0.05``,
      ``splitr_pos_pvalue > 0.05``, ``splitr_min_pvalue > 0.05``,
      ``breakpoint_homology <= 5``, ``num_multi_map/span_count < 0.2``
      and ``probability > 0.05`` have to be met.

-  SV merging principle per sample - SVs detected by at least one caller
   are included.

For usage of **SV\_standard.pl** arguments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

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

Input of mutation profile (optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

FuSViz only accepts input of mutation profile in Muation Annotation
Format (MAF), which is tab-delimited text file with aggregated mutation
information (SNVs+Indels) from multiple VCF files. In general, users can
use the tool `vcf2maf <https://github.com/mskcc/vcf2maf>`__ to convert
VCF to MAF and aggregate results of multiple samples.

Run SV\_standard.pl via Singularity container
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

COMING SOON
