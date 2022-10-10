#' Add antigenic info from JAGS model to tree dataframe
#'
#' @param tree treedata object read in by ggtree
#' @param tree_dat fortified dataframe created from tree. Must have branch identifiers matching model
#' @param JAGS_results dataframe containing posterior estimates of phylogenetic antigenic variables
#' @param branches vector of branches tested in JAGS model e.g. colnames(jags_data$X1)
#' @param antigenic_pattern character string to match JAGS posterior estimates of antigenic coefficients
#' @param ind_pattern character string to match JAGS posterior estimates of antigenic indicator variables
#'
#' @return
#' @export
#'
#' @examples
antigenic_to_treeDF <- function(tree_dat = NA, JAGS_results = NA, branch_vec = NA,
                                antigenic_pattern = "^antig", ind_pattern = "^ind") {

  antigenic <- names(JAGS_results)[grep(pattern = antigenic_pattern, names(JAGS_results))]
  ind <- names(JAGS_results)[grep(pattern = ind_pattern, names(JAGS_results))]

  JAGS_summary <- data.frame(branch = branch_vec,
                             coef.mean = apply(X = JAGS_results[,antigenic],
                                               MARGIN = 2, FUN = mean),
                             coef.median = apply(X = JAGS_results[,antigenic],
                                                 MARGIN = 2, FUN = quantile, probs = 0.5),
                             coef.lower = apply(X = JAGS_results[,antigenic],
                                                MARGIN = 2, FUN = quantile, probs = 0.025),
                             coef.upper = apply(X = JAGS_results[,antigenic],
                                                MARGIN = 2, FUN = quantile, probs = 0.975),
                             ind = colMeans(JAGS_results)[ind])

  ## Merge info from JAGS with tree DF
  # "^[a-z]+\\." matches control. and chalcont.
  JAGS_summary$Control <- gsub("^[a-z]+\\.", "c", JAGS_summary$branch)
  tree_dat <- merge(tree_dat, JAGS_summary, by = "Control", all.x = T)
  tree_dat <- tree_dat[order(tree_dat$node),] # ggtree likes DF in node order

  ## beast_dat now has antigenic weights for branches
  # create a duplicate column with 0 replacing NA for branches not modelled
  tree_dat$coef.full <- tree_dat$coef.mean
  tree_dat$coef.full[is.na(tree_dat$coef.full)] <- 0

  # new variable for each node - antigenic distance from root
  tree_dat$dist.root <- NA
  tree_dat$dist.root[tree_dat$node == tree_dat$parent] <- 0

  ## continue looping through nodes until no NA values for dist.root remain
  while (sum(is.na(tree_dat$dist.root)) > 0) {
    # loop through nodes
    for (i in 1:nrow(tree_dat)) {
      parent <- i

      # procede if dist.root for parent node is not NA
      if (is.na(tree_dat$dist.root[tree_dat$node == parent]) == F) {
        parent_dist <- tree_dat$dist.root[tree_dat$node == parent]

        # identify child nodes (use setdiff to avoid getting root as parent and child)
        children <- setdiff(tree_dat$node[tree_dat$parent == parent], parent)
        c1 <- children[1]
        c2 <- children[2]

        # for each child node, dist.root is sum of parent dist.root and branch coef.mean
        tree_dat$dist.root[tree_dat$node == c1] <- sum(parent_dist,
                                                       tree_dat$coef.full[tree_dat$node == c1])
        tree_dat$dist.root[tree_dat$node == c2] <- sum(parent_dist,
                                                       tree_dat$coef.full[tree_dat$node == c2])
      }
    }
  }
  # function returns treeDF with additional columns summarising model output
  # includes coef per branch and distance to root
  tree_dat
}
