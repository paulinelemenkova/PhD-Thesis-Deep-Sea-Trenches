# Part 1: generate data.frame
# step-1. read-in table
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na) # : [1] 0
head(MDF) #
# Part-2. Hierarchical Custer Analysis, Dendrogramms
library(dendextend)
# step-3. generate 1st dendrogram (here: 25 clusters)
dend <- MDF[1:25,] %>%  scale %>% dist %>% # calculate a distance matrix,
hclust (method = "average") %>%
as.dendrogram %>%
set("labels", c(("profile"), rep(1:25), sep="")) %>%
set("labels_col","blue") %>% set("labels_cex", c(.7)) %>%
set("branches_k_color", k=5) %>% set("branches_lwd", 1) %>%
set("nodes_pch", 19) %>%  set("nodes_cex", 1) %>%
set("nodes_col", "plum1") %>%
set("leaves_pch", 19) %>% set("leaves_col", c("blue", "red"))
dend %>% plot(main = "Mariana Trench: \nCluster Analysis Dendrogramm-1 of the Bathymetric Profiles \nUnsorted Dendrogramm")
# step-4. generate 2nd dendrogram from the 1st one, sorted by cluster size
dend2 <- sort(dend)
dend2 %>%  set("branches_k_color", k=3) %>% set("branches_lwd", 1) %>%
set("labels_col","blue") %>% set("labels_cex", c(.7)) %>%
set("branches_k_color", k=5) %>% set("branches_lwd", 1) %>%
set("nodes_pch", 19) %>%  set("nodes_cex", 1) %>%
set("nodes_col", "plum1") %>%
set("leaves_pch", 19) %>% set("leaves_col", c("blue", "red"))
dend2 %>% plot(main = "Mariana Trench: \nCluster Analysis Dendrogramm-2 of the Bathymetric Profiles \nSorted Dendrogramm")
# step-5. compare both dendrograms (sorted one with unsorted)
tanglegram(dend, dend2)
tanglegram(dend, dend2) %>% plot(main = "Mariana Trench: \nComrapison of the Cluster Dendrogramms 1 and 2")
# step-6. Hierarchical Clustering with P-Values via Multiscale Bootstrap Resampling
data(MDF)
set.seed(518)
result <- pvclust(MDF, method.dist="cor", method.hclust="average", nboot=10)
plot(result, main = "Mariana Trench Bathymetric Profiles 1-25: \nHierarchical Clustering with P-Values (AU/BP, %) \nvia Multiscale Bootstrap Resampling")
pvrect(result)
# step-7. pvclust and dendextend - results in view of sorted dendrogram
result %>% as.dendrogram %>%
set("branches_k_color", k = 5, value = c("purple", "orange", "cyan1", "firebrick1", "springgreen")) %>%
plot(main = "Mariana Trench Bathymetric Profiles 1-25: Cluster Dendrogram\nwith AU/BP Values (%). nAU: Approximately Unbiased p-Value \n and BP: Bootstrap Probability")
result %>% text
result %>% pvrect
# the end. results can be saved as a pdf via "Save As" (here: 5 figures for every step from 3- to 7)
