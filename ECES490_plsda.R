library(mixOmics)
library(RVAideMemoire)
library(cluster)
library(fpc)
library(ade4)

eVoom <- read.table('ECES490data/merged_abundances_ID.txt', header=TRUE, sep="\t")
eVoom <- eVoom[ 2:60]
phenotypes <- c("D", "D", "D", "D", "D", "D", "E", "E", "E", "E", "E", "E", "F", "F", "F", "F", "F", "F", "G", "G", "G", "G", "G", "G", "H", "H", "H", "H", "H", "H", "I", "I", "I", "I", "I", "I", "J", "J", "J", "J", "J", "J", "K", "K", "K", "K", "K", "K", "L", "L", "L", "L", "L", "L", "M", "M", "M", "M", "M", "M", "N", "N", "N", "N", "N", "N", "N", "N", "O", "O", "O", "O", "O", "O", "O", "O", "P", "P", "P", "P", "P", "P", "Q", "Q", "Q", "Q", "Q", "Q")
types <- c(rep("C", 18), rep("H", 18), rep("C", 18), rep("H", 34))
plsda.voom <- plsda(eVoom, types, ncomp = 2)
eVoom = na.omit(eVoom)
fit <- kmeans(eVoom, 2)
plotcluster(eVoom, fit$cluster)
out1 <- data.frame(cbind(phenotypes, clusterNum = fit$cluster))
centers <- data.frame(cbind(data.frame(fit$center[,1]), 
                            data.frame(fit$center[,2]), 
                            clusterNum=rownames(fit$center)))
title('K-means clustering with k=2 of unlabeled samples')
out2 <- merge(out1, centers, all.x = TRUE) 
text(x, labels=km$cluster, col=km$cluster)

#palette(c("red", "blue", "green", "yellow", "magenta", "deeppink3", "darkolivegreen", "cyan3", "orange", "blueviolet", "brown", "pink", "black", "gray"))
palette(c("red", "blue"))
col.voom <- as.numeric(as.factor(types))
plotIndiv(plsda.voom, ind.names = TRUE, col = col.voom)
legend('bottomleft', c("C", "H"), pch = c(1, 1),
       col = unique(col.voom), cex = 0.7, pt.cex = c(1, 1),
       title = "Sample")
#legend('bottom', c("D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q"), pch = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
       #col = unique(col.voom), cex = 0.5, pt.cex = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
       #title = "Sample")
title("PLS-DA clustering of Mice samples")
palette("default")

vipValsP <- PLSDA.VIP(plsda.voom)
write.table(vipValsP$tab, file="vipVals_ECES490.txt", append=FALSE, sep="\t")