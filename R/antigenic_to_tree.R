#' Add antigenic info from JAGS model to tree
#'
#' Given a tree and matching tree dataframe with columns 'dist.root' and 'coef.mean'
#'
#' @param tree treedata object read in by ggtree
#' @param tree_dat tree dataframe with info added on antigenic weights and distance from root
#'
#' @return
#' @export
#'
#' @examples
antigenic_to_tree <- function(tree = NA, tree_dat = NA) {

  # create blank space for new entries in tree data block
  tree@data$dist.root <- NA
  tree@data$antigenic <- NA

  # loop through nodes of tree extracting matching info from tree dataframe
  for (i in 1:length(tree@data$node)) {
    tree@data$dist.root[i] <- tree_dat$dist.root[tree_dat$node == tree@data$node[i]]
    tree@data$antigenic[i] <- tree_dat$coef.mean[tree_dat$node == tree@data$node[i]]
  }

  # function returns tree object with
  tree
}
