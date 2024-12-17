FAQ
---

Frequently asked questions regarding to installation and usage of
*FuSViz*.

**1. How to prepare input format for FuSViz?**

-  *FuSViz* accepts three types of data as input: SV calls from
   RNA-seq/DNA-seq data and mutation profile (i.e. small variants).
   Here, an in-house script **SV_standard.pl** (see its usage in
   **Installation** section) is provided to convert raw SVs from various
   callers to a uniform format, then aggregate calls of multiple samples
   together. In terms of SVs from RNA-seq data, many callers have been
   developed and there lacks of a standardization format for the output.
   In the processing of **SV_standard.pl**, a few common features
   (e.g. gene name, breakpoint position, sample id, read support for SV
   event) shared in the output of most callers are extracted and
   standardized as an input format of *FuSViz*. In contrast, most SV
   callers uing DNA-seq data output a standard VCF format, which can be
   converted to bedpe format with some key fields kept for *FuSViz*
   analysis. Now, output format of **10** SV callers (*STAR-fusion*,
   *Arriba*, *deFuse*, *FusionCatcher* and *Dragen* for RNA-seq;
   *Menta*, *Lumpy*, *Delly*, *SvABA* and *Gridss* for DNA-seq) are well
   supported by **SV_standard.pl**, and a support for more callers will
   be extended on basis of user’s requirement and feedback in the
   further.

**2. What are differences between SV calls from DNA-seq and RNA-seq, and
their respective characteristics? Why to combine them?**

-  Genomic SV at DNA level represents various types of large variations
   (e.g. deletions, insertions, duplications, inversions and
   translocations) that are related to the break, link, recombination
   and amplification of DNA strand. When it occurs in genic regions, a
   hybrid gene is formed (so-called “fusion gene”). In case of
   breakpoint in non-coding regions, duplications and deletions can lead
   to an alteration of genomic regulatory elements (e.g. enhancers or
   TADs). One common feature of SV rearrangement is to break up DNA
   sequence, which disrupts a proper transcription or translation of
   tumor suppressor gene, finally giving rise to a reduced activation or
   function loss of the gene.
-  In comparison, RNA-seq data is used to address whether a fusion gene
   can transcribe to a fusion transcript and produce a putative chimeric
   protein with an in-frame outcome. Although breakpoints of fusion
   genes usually occur in intronic regions, the observed breakpoints of
   most fusion transcripts coincide with exon boundary due to RNA
   splicing mechanism, from which some breakpoint pairs show a higher
   prevalence than others. One important biological consequence of
   fusion transcript is an activation of oncogene, in particular for a
   oncogenic downstream partner. In addition, a few SV types,
   e.g. **read-through** and **trans-splicing**, are exclusively
   detected at RNA level which represents a event of RNA-mediated
   regulatory mechanism.
-  In short, it is necessary to combine features of SV calls from
   DNA-seq and RNA-seq data together to interpret and visualize SVs
   associated with oncological-relevant genes in context of cancer
   genomic and transcriptomic annotations.

**3. Are SV calls from the third-generation sequencing technology
(e.g. PacBio or Nanopore platform) supported by FuSViz.**

-  Although *FuSViz* is designed to visualize and interpret aggregated
   SVs called from short read sequencing data (main for the Illumina
   platform), it provides a support for SV calls from long read
   sequencing data (e.g., Nanopore or PacBio technology) as well. To our
   knowledge, most SV tools using long read sequencing data output raw
   calls into a standard VCF file with a similar format as those from
   short read data. Users just need to convert SV calls to a format
   compatible with *FuSViz* requirement (i.e., bedpe or bedpe-like
   format).

**4. If I am only interested in copy number aberrations (CNAs), how
could I make a filtration on SVs.**

-  In general, CNAs represent abnormal amplifications and deletions of
   intra-chromosomal genomic regions. They are a sub-group of total SVs,
   which are tagged as **DUP** and **DEL** in the input format of
   *FuSViz*. If users only focus on an analysis of CNAs, please click on
   the button ``Load and refresh DNA SV Track in seg`` in Linear plot
   module. In addition, users can use ``SV_type`` Select box to filter
   out other types of SVs for a customized analysis.

**5. Can it be possible to utilize FuSViz for analysis of a single
sample and ‘tumor-normal’ pairwise samples?**

-  Users can utilize ``name`` or ``Sample`` in Select box to focus on
   their interested samples. Moreover, a few functionalities are
   provided to enhance the single sample analysis by allowing import of
   a read alignment file in **linear module** (e.g. SV quality control
   in **Appendix** section) and make a fusion plot including read
   converage of partner genes in **two-way module** under a CLI mode.
   However, *FuSViz* is not designed for a comparison analysis between
   “tumor” and “normal” pairs except for exploring genetic differences
   in read alignment.

**6. Is it possible for FuSViz to analyze SV calls from Non-human
organisms?**

-  *FuSViz* is a dedicated tool intended for interpretation of
   genomic/transcriptomic structural variations (SVs) in the context of
   human cancer, and hence has limited focus on serving datasets from
   other organisms. But, we have extended its functionality to the model
   organism mouse, given that mouse is frequently used to establish
   patient-derived xenograft (PDX) models for experimental
   investigations of molecularly targeted cancer therapies.

**7. Do SV calls in FuSViz input file include genotype information?**

-  No, there are several reasons for it:

   -  Firstly, genotype information of SVs is not a common feature
      presented in raw output of most callers.
   -  Secondly, the precision of genotype information highly depends on
      the type of SVs. In general, duplication and deletion are
      genotyped relatively accurate. Genotype of insertion and inversion
      can be inferred but with less precision. Most tools have a limited
      capacity to genotype translocation.
   -  Thirdly, it is challenging to make a consensus on SV genotypes in
      a merge process if discordance from different callers is present.

**8. Does FuSViz have a functionality to allow alignment file (BAM) as
input?**

-  Although the main purpose of *FuSViz* is used to visualize and
   interpret SVs of multiple samples, users can load read alignments in
   the ``file upload`` box of **Linear module** or using **Two-way
   module** for a single sample analysis (see **Appendix** - how to plot
   read coverage for a customized analysis of one specific sample using
   alignment file, either from RNA-seq/DNA-seq or both).
