FAQ
---

Frequently asked questions regarding to installation and usage of
**FuSViz**.

**1. How to prepare input format for FuSViz?**

-  FuSViz accepts three types of data as input: SV calls from
   RNA-seq/DNA-seq reads generated using illumina platform and mutation
   profile (i.e. small variants). Here, an in-house script
   **SV\_standard.pl** (see its usage in **Installation** section) is
   provided to convert raw SV calls from various finders to a uniform
   format, then aggregate calls of multiple samples together. In terms
   of SVs from RNA-seq data, numerous callers have been developed and
   there lacks of a standardization format for the output. In the
   processing of **SV\_standard.pl**, a few common features (e.g. gene
   name, breakpoint position, sample id, read support for SV event)
   present in output of most callers are extracted and standardized as
   an input format of FuSViz. In contrast, most DNA-seq SV finders
   output calls in a standard VCF format, which is converted to bedpe
   format and some key fields in VCF file are kept for FuSViz analysis.
   Currently, output format of **10** SV callers (*STAR-fusion*,
   *Arriba*, *deFuse*, *FusionCatcher* and *Dragen* for RNA-seq;
   *Menta*, *GRISSS*, *Lumpy*, *Delly* and *SvABA* for DNA-seq) are well
   supported by **SV\_standard.pl**, and we will of course extend to
   more callers on basis of user’s requirement and feedback in the
   further.

**2. What are differences between SV calls from DNA-seq and RNA-seq, and
their respective characteristics? Why to combine them?**

-  Genomic SV at DNA level represents various types of large variations
   (e.g. deletions, insertions, duplications, inversions and
   translocations) that are related to the break, link, recombination
   and amplification of DNA strand. If it occurs in genic regions, a
   hybrid gene could be formed (so-called “fusion gene”). In case of
   breakpoint in intergenic regions, duplications and deletions can lead
   to an alteration of genomic regulatory elements (e.g. enhancers or
   TADs). One common phenomenon of SV rearrangement is to break up DNA
   sequence, which disrupts proper expression or translation of a gene
   (e.g. tumor suppressor), finally giving rise to a reduced activation
   or function loss of such a gene.
-  In comparison, RNA-seq data is used to address whether a fusion gene
   could transcribe to a fusion transcript and produce a putative
   chimeric protein with an in-frame ORF. Although breakpoints of fusion
   genes usually occur in intron regions, the observed breakpoints of
   most fusion transcripts coincide with exon boundary due to RNA
   splicing mechanism, from which some breakpoint pairs show a higher
   prevalence than others. One important biological consequence of
   fusion transcripts is an activation of oncogenes, as the oncogenes
   often constitutes the downstream partner in fusion. Even when the
   oncogene is fused as upstream partner, the downstream partner can
   provide protein domains which enhance oncogenic function if read
   frame is intact. In addition, a few SV types, e.g. **read-through**
   and **trans-splicing**, are exclusively detected at RNA level which
   represents a event or outcome of RNA-mediated regulatory mechanism. A
   common limitation of RNA-seq data analysis is that intergenic SV
   events are not available.
-  In short, it is reasonable to combine the features of SV calls from
   DNA-seq and RNA-seq together to interpret and visualize SVs
   associated with oncological-relevant genes in context of cancer
   genomic and transcriptomic annotations.

**3. Are SV calls from the third-generation sequencing technology (e.g.
PacBio or Nanopore platform) supported by FuSViz.**

-  At this moment, **SV\_standard.pl** does not support to handle SV
   calls using reads generated from third-generation sequencing
   technology, and we are working on it. As PacBio represents a
   long-read sequencing technology, only “split” reads are used for SV
   detection and no “span” reads information is available. Users have to
   assign a “virtual” number to avoid any ‘NA’ or empty values in “span”
   column if they would like to prepare FuSViz input format by
   themselves.

**4. If I am only interested in copy number aberrations (CNAs), how
could I make a filtration on SVs.**

-  In general, CNAs show unusual amplifications and deletions of genomic
   regions in a chromosome. They represent intra-chromosome events and
   are in fact a subset of total SVs, which are tagged as **DUP** and
   **DEL** in the input format of FuSViz. Such an analysis is provided
   by clicking the button ``DNA SV Track in seg`` in Linear plot module.
   In addition, it can be done by using ``SV_type`` Select DropDown to
   control the type of SVs for a customized analysis.

**5. Can it be possible to utilize FuSViz for analysis of a single
sample and ‘tumor-normal’ pairwise samples?**

-  There are two ways for a single sample anlysis. First, SV calls or
   mutation profile of a single sample are allowed for input. Second,
   user could utilize ``name`` or ``Sample`` Select DropDown to
   customize their interested samples. Moreover, a few functinalities
   are provided to enhance the single sample analysis by allowing import
   of read alignment file (see **Appendix** section). However, FuSViz
   does not distingish 'tumor' samples from the 'normal' ones in data
   handling, a visualization strategy specific for "tumor-normal"
   comparison is therefore not supported currently.

**6. Is it possible for FuSViz to analyze SV calls from Non-human
organisms?**

-  Not yet now, but we are working on it and trying to extend FuSViz to
   other model organisms (e.g. mouse and rat).

**7. Do SV calls in FuSViz input file include genotype information?**

-  No, there are several reasons for it:

   -  Firstly, only a few of existed callers (around 1/3) provide
      genotype information of SVs in raw output.
   -  Secondly, even one tool has a functionality for genotyping SVs,
      and it actually depends on the type of SVs. In general,
      duplication and deletion can be genotyped relatively accurate.
      Sometimes, genotype of insertion and inversion can be inferred but
      less precision. It is still challenging to genotype translocation
      for any available tools.
   -  Thirdly, it is often difficult to obtain a genotype information if
      SV calls from multiple tools are merged, in particular when there
      are incongruent among different callers. Here, FuSViz is mainly
      designed for SV analysis of multiple samples and genotype
      information is not a key element for such a purpose.

**8. Does FuSViz have a functionality to allow alignment file (BAM) as
input?**

-  Though the main purpose of FuSViz is used to visualize and interpret
   SVs of multiple samples, users can load read alignments in the
   ``file upload`` panel of **Linear** module or using **Two-way**
   module (see **Appendix** - how to plot read coverage for a customized
   analysis of one specific sample using alignment file, either from
   RNA-seq or DNA-seq or both).
