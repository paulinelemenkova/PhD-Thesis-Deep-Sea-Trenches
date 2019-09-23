# Regression Analysis
# Part 1: create data.frame
# step-1. read in table, create data frame.
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")

# step-2. clean up data frame from the NA
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
(row.has.na) # sum up NA, result: [1] 0
head(MDF) #

# Part 2: perform regression analysis and plot (Mathematical method includes 3 types of curves with confidence intervals and quantiles).
# step-3. (here: profile \#11)
Loess_profile11 <- ggplot(MDF, aes(x = observ, y = profile11)) +
geom_point(aes(x = observ, y = profile11, colour = "Samples", shape = "Samples"), show.legend=TRUE) +
geom_smooth(aes(x = observ, y = profile11, colour = "Loess method"), method = loess, se = TRUE, span = .4, size=.3, linetype = "solid", show.legend=TRUE) +
geom_smooth(aes(x = observ, y = profile11, colour = "Glm method"), method = glm, se = FALSE, span = .4, size=.4, linetype = "dotted", show.legend=TRUE) +
geom_smooth(aes(x = observ, y = profile11, colour = "Lm method"), method = lm, se = TRUE, size=.3, linetype = "solid", show.legend=TRUE) +
geom_quantile(aes(x = observ, y = profile11, colour = "Quantiles"), linetype = "solid", show.legend=TRUE) +
xlab("Observations") +
ylab("Depths, m") +
scale_color_manual(values = c("Samples" = "seagreen", "Loess method" = "red", "Lm method" = "blue", "Glm method" = "orange", "Quantiles" = "purple")) + # set up colors
scale_shape_manual(values = c("Samples" = 1)) + # set up shapes (here: \#1 - "transparent circle")
#    scale_size_manual(values = c(profile11 = 1)) +
labs(title="Mariana Trench, Profile 11.",
subtitle = "Local Polynomial Regression, \nConfidence Interval, Quantiles \n(LOESS method: locally weighted scatterplot \nsmoothing for non-parametric regression)",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(family = "Kai", face = "bold", size = 8),
plot.subtitle = element_text(family = "Hei", face = "bold", size = 6),
plot.caption = element_text(face = 2, size = 6),
panel.background=ggplot2::element_rect(fill = "white"),
legend.justification = "bottom",
legend.position = "bottom",
legend.box.just = "right",
legend.direction = "horizontal",
legend.box = "horizontal",
legend.box.background = element_rect(colour = "honeydew4",size=0.2),
legend.background = element_rect(fill = "white"),
legend.key.width = unit(1,"cm"),
legend.key.height = unit(.5,"cm"),
legend.spacing.x = unit(.2,"cm"),
legend.spacing.y = unit(.1,"cm"),
legend.text = element_text(colour="black", size=6, face=1),
legend.title = element_text(colour="black", size=6, face=1),
strip.text.x = element_text(colour = "white", size=6, face=1),
panel.grid.major = element_line("gray24", size = 0.1, linetype = "solid"),
panel.grid.minor = element_line("gray24", size = 0.1, linetype = "dotted"),
axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.ticks.length=unit(.1,"cm"),
axis.line = element_line(size = .3, colour = "grey80"),
axis.title.y = element_text(margin = margin(t = 20, r = .3), face = 2, size = 8),
axis.title.x = element_text(face = 2, size = 8, margin = margin(t = .2))) +
guides(col = guide_legend(nrow = 1, ncol = 6, byrow = TRUE))
Loess_profile11

# Part 2: combine 3 plots on one layout
library(ggpubr)
#ggarrange function

Regression_Profiles111824 <- ggarrange(Loess_profile11, Loess_profile18, Loess_profile24, labels = c("1", "2", "3"), ncol = 3, nrow = 1, common.legend = TRUE, legend = "bottom")
