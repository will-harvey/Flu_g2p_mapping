# Flu_g2p_mapping

Model approaches for identifying genetic basis of antigenic variation

This repository includes designed for the analysis of variation in titres recorded in antigenic assays (such as the haemagglutination inhibition (HI) assay or the virus neutralisation (VN) test). The methodology is described in a biorxiv preprint (Harvey et al. 2022 A Bayesian approach to incorporate structural data into the mapping of genotype to antigenic phenotype of influenza A(H3N2) viruses. https://doi.org/10.1101/2022.03.26.485931).

Models are written to be run using JAGS (Just Another Gibbs Sampler), a program for analysis of Bayesian hierarchical models using Markov chain Monte Carlo (MCMC) simulation. For download instructions, see https://mcmc-jags.sourceforge.io.

JAGS can be run from R using various packages including rjags and runjags. 

### Controlling for phylogenetic structure

Phylogenetic comparative methods use information on the historical relationships of lineage to test evolutionary hypotheses. More closely related viruses share many traits and trait combinations as a result of their shared evolutionary history. Standard statistical approaches, which could be used to test relationships between characters (phenotypic or genetic), do not account for the non-independance of viruses that are a result of descent with modification.

Amino acid substitutions in HA (and mutations in the influenza genome more generally) tend to be correlated with antigenic distance; this could be a direct causative relationship or may arise indirectly due to the shared evolutionary history of viruses. Several phylogenetic comparative approaches exist to account for phylogenetic structure however these tend to focus on traits that can be measured for each individual virus rather than measurements that represent similarity between viruses (as is the case with antigenic assays). An approach to account for phylogenetic structure when modelling variation in measurements representing similarity between pairs of taxa was presented in application to foot-and-mouth disease and VN titres (Reeve et al. 2010, PLOS Computational Biology https://doi.org/10.1371/journal.pcbi.1001027). The same approach was adapted for application to the analysis of influenza HI (Harvey et al. 2016 PLOS Pathogens www.doi.org/10.1371/journal.ppat.1005526).

To implement this approach requires the generation of binary indicator variables for each branch. When a branch falls on a path  traced throuhg the phylogenetic tree along the branches falling between antisera and antigen, the associated indicator variable will be 1, otherwise it will be 0.

In the directory 'phylogenetic structure', an Rmarkdown script 'phylogenetic_variables.Rmd' describes how to read a phylogenetic tree into R and generate these variables for a given dataset of viruses. This script uses functions included in an R package called 'toolkitSeqTree' which is available at https://github.com/will-harvey/toolkit_seqTree.


### H1N1 example dataset

An example dataset based on former seasonal influenza A(H1N1) HI titres is used to demonstrate the functionality of the code base. The size of the dataset allows for fast implementation of models.     

This dataset consists of HI titres measured between 43 viruses used as reference strains from which antisera were generated and used in assays. This data is is a subset of that available from https://researchdata.gla.ac.uk/289/ (Datacite DOI: 10.5525/gla.researchdata.289). The full citation associated with use of this data is:

Gregory, V., Harvey, W., Daniels, R. S., Reeve, R. , Whittaker, L., Halai, C., Douglas, A., Gonsalves, R., Skehel, J. J., Hay, A. J., McCauley, J. W. and Haydon, D.  (2016) Human former seasonal Influenza A(H1N1) haemagglutination inhibition data 1977-2009 from the WHO Collaborating Centre for Reference and Research on Influenza, London, UK. [Data Collection]

The original research publication associated with this data, if used, is available at http://dx.doi.org/10.1371/journal.ppat.1005526.
