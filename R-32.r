# step-1. read in table. create data frame.
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. plot correlation ellipses using libraries (ellipse) and (RColorBrewer)
data=cor(MDF)
# Build a panel of 100 colors with Rcolor Brewer
my_colors <- brewer.pal(5, "Spectral")
my_colors=colorRampPalette(my_colors)(100)
# step-3. Order correlation matrix
ord <- order(data[1, ])
data_ord = data[ord, ord]
# step-4. variant-1 correlation ellipses
plotcorr(data_ord , col=my_colors[data_ord*50+50] , mar=c(1,1,1,1),
outline = TRUE, numbers = FALSE,
main = "Mariana Trench: Correlation Ellipses",
xlab = "Geomorphological, bathymetric and geological factors",
ylab = "Geomorphological, bathymetric and geological factors",
cex.lab = 0.7)
# step-5. variant-2 correlation numbers
plotcorr(data_ord , col=my_colors[data_ord*50+50] , mar=c(1,1,1,1),
outline = TRUE, numbers = TRUE,
main = "Mariana Trench: Numerical Correlation",
xlab = "Geomorphological, bathymetric and geological factors",
ylab = "Geomorphological, bathymetric and geological factors",
cex.lab = 0.7)
