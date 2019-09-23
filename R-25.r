# Part-1. Prepare data frame
# step-1. read in table with data. create initial data frame. clean data frame from the NA
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
Ml <- na.omit(MDepths)
row.has.na <- apply(Ml, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(Ml)
# step-2. Merge columns with identical attributes
MDTt = melt(setDT(Ml), measure = patterns("^profile"), value.name = c("depth"))
head(MDTt)

# Part-2. Plot 'violin plot' - statistical analysis of bathymetric data distribution (mean, standard deviation, median).
# step-3. variant-1. via library(violinmplot)
library(violinmplot)
violinmplot(depth ~ variable, MDTt, horizontal=FALSE, col.violin = "blue", main = "Violin plot of the Mariana Trench: a hybrid of a Box plot and a Kernel probability density estimation plot (rotated) + median")
# step-4.  variant-2. via library(ggplot2)
g<- ggplot(MDTt, aes(variable, depth)) +
geom_violin(aes(fill = factor(variable)), colour = "blue", size = 0.2, draw_quantiles = c(0.25, 0.5, 0.75), alpha = 0.5, scale = "count", trim = FALSE)
g
# step-5. add title, axises, etc.
Violin<- g +
xlab("Profiles") +
ylab("Depth, m") +
labs(
title = "Mariana Trench, Profiles 1-25.",
subtitle = "Violin plot of the Mariana Trench: \na hybrid of a Box plot and a Kernel probability density estimation plot (rotated). \nMedian and Quantiles (0.25, 0.5, 0.75)",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(family = "Hei", face = "bold", size = 10),
plot.caption = element_text(face = 2, size = 8),
panel.background=ggplot2::element_rect(fill = "white"),
legend.justification = "right",
legend.position = "right",
legend.box.just = "right",
legend.direction = "vertical",
legend.box = "vertical",
legend.box.background = element_rect(colour = "honeydew4",size=0.2),
legend.background = element_rect(fill = "white"),
legend.key.width = unit(1,"cm"),
legend.key.height = unit(.5,"cm"),
legend.spacing.x = unit(.2,"cm"),
legend.spacing.y = unit(.1,"cm"),
legend.text = element_text(colour="black", size=6, face=1),
legend.title = element_text(colour="black", size=8, face=1),
strip.text.x = element_text(colour = "white", size=6, face=1),
panel.grid.major = element_line("gray24", size = 0.1, linetype = "solid"),
panel.grid.minor = element_line("gray24", size = 0.1, linetype = "dotted"),
axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.ticks.length=unit(.1,"cm"),
axis.line = element_line(size = .3, colour = "grey80"),
axis.title.y = element_text(margin = margin(t = 20, r = .3), face = 2, size = 8),
axis.title.x = element_text(face = 2, size = 8, margin = margin(t = .2))) +
guides(col = guide_legend(nrow = 13, ncol = 2, byrow = TRUE)) # improve design
Violin
