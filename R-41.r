#Part-1
# Scatterplot matrix by GGally
require(GGally)
# step-1. read in table. create data frame
MDFGeo <- read.csv("GeoMorphology.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDFGeo <- na.omit(MDFGeo)
row.has.na <- apply(MDFGeo, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDFGeo)
# step-3. Check correlation between variables
cor(MDF)
# step-4. variant-1. Check correlations (as scatterplots), distribution and print correleation coefficient
pi<- ggpairs(MDFGeo, axisLabels = "show",
title = "Mariana Trench: Scatterplot Correlation Matrix",
labeller = "label_parsed",
upper = list(continuous = wrap("density", alpha = 0.5), combo = "box_no_facet"),
lower = list(combo = "denstrip"))
pi
pair<- pi + theme(axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15))
pair
# step-5. variant-2, with numerical correlations
pin<- ggpairs(MDFGeo,axisLabels= "show",
title = "Mariana Trench: Scatterplot Correlation Matrix", )
pin
pair<- pi + theme(axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15))
pair

#Part-2. Scatterplot matrix by GGally, detailed
#step-6. read in data table
MDF4 <- read.csv("Morph-9-factors.csv", header=TRUE, sep = ",")
MDF4 <- na.omit(MDF4)
row.has.na <- apply(MDF4, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF4)
library(data.table)
library(GGally)
library(ggplot2)
# step-7. set up factor value
MDF4$slope_class <- factor(MDF4$class)
# step-8. plot scatterplot matrix by steepness angle
sl<- ggpairs(MDF4 ,
title= "Mariana Trench \nScatterplot Correlation Matrix by Slope Angle Class",
upper = list(continuous = wrap("density", alpha = 0.5, lwd = 0.3)),
lower = list(continuous = wrap("points", color = "red", alpha = 0.5),
combo = wrap("box", color = "orange", alpha = 0.6, lwd = 0.3)),
diag = list(continuous = wrap("densityDiag",  color = "blue", alpha = 0.5, lwd = 0.3)))
sl
# step-9. add axis ticks
pair<- sl + theme(
axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15))
pair
# step-10. Visualization of correlations
ggcorr(data=MDF, method = c("everything", "pearson"))

#Part-4. Correlation matrices by 3 approaches
# step-11. Read in data table
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-12. Check correlation between variables
cor(MDF)
# step-13. Variant-1: Pearson correlation coefficients, using pairwise observations (default method)
gp<- ggcorr(data=MDF, method = c("everything", "pearson"),
name = "\nPearson \ncorrelation \nmethod \n(parametric)",
label = TRUE, label_size = 2, label_round = 2, label_alpha = TRUE,
hjust = 0.75, size = 3, color = "grey50", legend.position = "left")
gpt<- gp + labs(title="Mariana Trench",
subtitle = "Correlation of Geomorphlogical Impact Factors \nPearson correlation method (parametric)",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
theme(plot.title = element_text(family = "Times New Roman", face = 2, size = 12),
plot.subtitle = element_text(family = "Times New Roman", face = 1, size = 10),
plot.caption = element_text(family = "Times New Roman", face = 2, size = 8))
gpt
# step-14. Variant-2: Spearman correlation coefficients, using strictly complete observations
gs<-ggcorr(data=MDF, method = c("everything", "spearman"), geom = "circle", nbreaks = 5,
min_size = 3, max_size = 9, palette = "PiYG",
name = "\nSpearman \ncorrelation \nmethod \n(non-parametric)",
label = TRUE, label_size = 2, label_round = 2, label_alpha = TRUE,
hjust = 0.75, size = 3, color = "grey50", legend.position = "left")
gs
gst<- gs + labs(title="Mariana Trench",
subtitle = "Correlation of Geomorphlogical Impact Factors \nSpearman correlation method \n(nonparametric measure of rank using monotonic function)",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
theme(plot.title = element_text(family = "Times New Roman", face = 2, size = 12),
plot.subtitle = element_text(family = "Times New Roman", face = 1, size = 10),
plot.caption = element_text(family = "Times New Roman", face = 2, size = 8))
gst
# step-15. Variant-3: Kendall correlation coefficients, using complete observations
gk<- ggcorr(data=MDF, method = c("complete", "kendall"),
geom = "text", nbreaks = 5, palette = "RdYlBu", hjust = 1, label = TRUE, label_alpha = 0.4)
gk
gkt<- gk + labs(title="Mariana Trench",
subtitle = "Correlation of Geomorphlogical Impact Factors \nKendall correlation coefficients, \nusing complete observations",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS")
gkt
figure <-plot_grid(gpt, gst, labels = c("1", "2"), ncol = 2, nrow = 1)
figure
