# Flu_g2p_mapping
## Model approaches for identifying genetic basis of antigenic variation

Mapping the impact of genetic changes on characteristics or traits is an important challenge in biology. The practical value of accurate genotype-to-phenotype mapping is clear in efforts to control human seasonal influenza viruses. These viruses, and particularly the A(H3N2) subtype, evolve rapidly with natural selection favouring variants possessing changes to the antigens recognized by the human immune system following prior infection or vaccination. This process of ‘antigenic drift’ necessitates global monitoring of the antigenic characteristics of the virus population and frequent vaccine updates.

The antigenic characterisation of circulating viruses is dependent upon haemagglutination inhibition (HI) and virus neutralisation (VN) assays, both of which are used to assess the antigenic similarity of a circulating test virus to a panel of reference viruses that includes previous and current vaccine viruses and other candidate vaccine viruses. The panel of reference viruses, and post-infection ferret antisera raised against them,  are selected to represent the diversity of antigenic phenotypes observed over the most recent seasons. A general challenge for modelling genotype-phenotype relationships is differentiating causative mutations from those that are non-causative and correlate with phenotypic changes due to genetic hitchhiking. Various phylogenetic comparative methods exist to account for shared evolutionary history of taxa when modelling quantitative traits, though these tend to focus on traits intrinsically associated with particular taxa rather than measures that relate to relationships between taxa, as is the case here when working with pairwise measures of antigenic similarity. 

Precise genotype-to-phenotype mapping has the potential to improve understanding of the drivers of evolutionary success of emerging virus variants. 


This repository includes designed for the analysis of variation in titres recorded in antigenic assays (such as the haemagglutination inhibition (HI) assay or the virus neutralisation (VN) test). The methodology is described in a biorxiv preprint (Harvey et al. 2022 A Bayesian approach to incorporate structural data into the mapping of genotype to antigenic phenotype of influenza A(H3N2) viruses. https://doi.org/10.1101/2022.03.26.485931).

Models are written to be run using JAGS (Just Another Gibbs Sampler), a program for analysis of Bayesian hierarchical models using Markov chain Monte Carlo (MCMC) simulation. For download instructions, see https://mcmc-jags.sourceforge.io.

JAGS can be run from R using various packages including rjags and runjags. 

### Controlling for phylogenetic structure

Phylogenetic comparative methods use information on the historical relationships of lineage to test evolutionary hypotheses. More closely related viruses share many traits and trait combinations as a result of their shared evolutionary history. Standard statistical approaches, which could be used to test relationships between characters (phenotypic or genetic), do not account for the non-independance of viruses that are a result of descent with modification.

Amino acid substitutions in HA (and mutations in the influenza genome more generally) tend to be correlated with antigenic distance; this could be a direct causative relationship or may arise indirectly due to the shared evolutionary history of viruses. Several phylogenetic comparative approaches exist to account for phylogenetic structure however these tend to focus on traits that can be measured for each individual virus rather than measurements that represent similarity between viruses (as is the case with antigenic assays). An approach to account for phylogenetic structure when modelling variation in measurements representing similarity between pairs of taxa was presented in application to foot-and-mouth disease and VN titres (Reeve et al. 2010, PLOS Computational Biology https://doi.org/10.1371/journal.pcbi.1001027). The same approach was adapted for application to the analysis of influenza HI (Harvey et al. 2016 PLOS Pathogens www.doi.org/10.1371/journal.ppat.1005526).

To implement this approach requires the generation of binary indicator variables for each branch. When a branch falls on a path  traced throuhg the phylogenetic tree along the branches falling between antisera and antigen, the associated indicator variable will be 1, otherwise it will be 0.

In the directory 'phylogenetic structure', an Rmarkdown script 'phylogenetic_variables.Rmd' describes how to read a phylogenetic tree into R and generate these variables for a given dataset of viruses. This script uses functions included in an R package called 'toolkitSeqTree' which is available at https://github.com/will-harvey/toolkit_seqTree.


### H3N2 dataset

This dataset is a selection of seasonal influenza A(H3N2) HI titres produced by the Worldwide Influenza Centre. These data and matched phylogenetic and genetic variables are analysed in the original research article Harvey et al. 2022 https://doi.org/10.1101/2022.03.26.485931.

- The phylogenetic tree described in the paper is located at 'dataset_h3n2/phylogeny/H3N2.trees'.
- An HA1 amino acid alignment including all viruses analysed in the paper is located at 'dataset_h3n2/h3n2_ha1_aa.fasta'._

The original research publication associated with this data set is:

Harvey WT, Davies V, Daniels RS, Whittaker L, Gregory V, Hay AJ, Husmeier D, McCauley JW and Reeve R (2023). A Bayesian approach to incorporate structural data into the mapping of genotype to antigenic phenotype of influenza A(H3N2) viruses. https://doi.org/10.1101/2022.03.26.485931

If using this dataset, please cite both the above research article and the full curated data set of H3N2 HI data generated at the Worldwide Influenza Centre between 1990 and 2021 which is available at:

Whittaker L , Gregory V, Harvey WT, Daniels RS, Reeve R, Halai C, Douglas A, Gonsalves R, Skehel JJ, Hay AJ and McCauley JW (2023) Human seasonal Influenza A(H3N2) haemagglutination inhibition data 1990-2021 from the WHO Collaborating Centre for Reference and Research on Influenza, London, UK. doi:10.5525/gla.researchdata.1405


### H1N1 example dataset

An example dataset based on former seasonal influenza A(H1N1) HI titres is used to demonstrate the functionality of the code base. The size of the dataset allows for fast implementation of models. Therefore, if you are interested in applying the described models to a manageable dataset perhaps before implementing on novel data, it may be preferable to explore this dataset.   

This dataset consists of HI titres measured between 43 viruses used as reference strains from which antisera were generated and used in assays. This data is is a subset of that available from https://researchdata.gla.ac.uk/289/ (Datacite DOI: 10.5525/gla.researchdata.289). The full citation associated with use of this data is:

Gregory, V., Harvey, W., Daniels, R. S., Reeve, R. , Whittaker, L., Halai, C., Douglas, A., Gonsalves, R., Skehel, J. J., Hay, A. J., McCauley, J. W. and Haydon, D.  (2016) Human former seasonal Influenza A(H1N1) haemagglutination inhibition data 1977-2009 from the WHO Collaborating Centre for Reference and Research on Influenza, London, UK. [Data Collection]

The original research publication associated with these data, if used, is available at http://dx.doi.org/10.1371/journal.ppat.1005526.
