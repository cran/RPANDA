plot_phylosignal_sub_network <-
function(tree_A, results_sub_clades, network=NULL, legend=TRUE, show.tip.label=FALSE, where="bottomleft", corrected_pvalue=TRUE){
  
  host_tree <- tree_A
  
  if (!inherits(host_tree, "phylo")) {stop("object \"tree_A\" is not of class \"phylo\".")}
  
  
  if (!is.null(network)){
    network <- network[rowSums(network)>0,]
    network <- network[,colSums(network)>0]
    host_tree <- ape::drop.tip(host_tree, tip=host_tree$tip.label[!host_tree$tip.label %in% colnames(network)])
    network <- network[,host_tree$tip.label]
  }
  
  
  if ((Ntip(host_tree)+1)!=results_sub_clades$node[1]){
    stop("object \"tree_A\" contains more node than \"results_sub_clades\". Remove these nodes from \"tree_A\" before plotting.")
  }
  
  if (!corrected_pvalue) results_sub_clades$pvalue_upper_corrected <- results_sub_clades$pvalue_upper
  
  
  plot(host_tree, show.tip.label=show.tip.label)
  # significant and R>=0.05
  nodes=results_sub_clades$node[intersect(which(results_sub_clades$pvalue_upper_corrected<=0.05),which(results_sub_clades$mantel_cor>=0.5))]
  nodelabels(node=nodes,pie=rep(1,length(nodes)),piecol="#78281f",cex=0.5)
  
  # significant and 0.3<R<0.5
  nodes=results_sub_clades$node[intersect(which(results_sub_clades$pvalue_upper_corrected<=0.05),intersect(which(results_sub_clades$mantel_cor<0.5), which(results_sub_clades$mantel_cor>=0.3)))]
  nodelabels(node=nodes,pie=rep(1,length(nodes)),piecol="#b03a2e",cex=0.5)
  
  # significant and 0.1<R<0.3
  nodes=results_sub_clades$node[intersect(which(results_sub_clades$pvalue_upper_corrected<=0.05),intersect(which(results_sub_clades$mantel_cor<0.3), which(results_sub_clades$mantel_cor>=0.1)))]
  nodelabels(node=nodes,pie=rep(1,length(nodes)),piecol="#ec7063",cex=0.5)
  
  # significant and 0.1>R
  nodes=results_sub_clades$node[intersect(which(results_sub_clades$pvalue_upper_corrected<=0.05),which(results_sub_clades$mantel_cor<0.1))]
  nodelabels(node=nodes,pie=rep(1,length(nodes)),piecol="#f5b7b1",cex=0.5)
  
  # not significant 
  nodes=results_sub_clades$node[which(results_sub_clades$pvalue_upper_corrected>0.05)]
  nodelabels(node=nodes,pie=rep(1,length(nodes)),piecol="#aed6f1",cex=0.5)
  
  # too small
  nodes=((Ntip(host_tree)+2):(2*Ntip(host_tree)-1))[!(Ntip(host_tree)+2):(2*Ntip(host_tree)-1) %in% results_sub_clades$node]
  nodelabels(node=nodes,pie=rep(1,length(nodes)),piecol="#5d6d7e",cex=0.2)
  
  # add legend
  if (legend==TRUE) {legend(where, legend = c("0.5 < R","0.3 < R < 0.5","0.1 < R < 0.3","R < 0.1","Not significant","Small sub-clade"), pch = 19, 
                            col = c("#78281f","#b03a2e","#ec7063","#f5b7b1","#aed6f1","#5d6d7e"), bg="transparent", bty = "n", cex=0.89, y.intersp=0.9)}
  
}
