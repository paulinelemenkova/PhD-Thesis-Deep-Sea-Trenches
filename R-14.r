# Part-1. Prepare data frame.
# step-1. read in table with data on geomorphology. create initial data frame
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # check up data frame if there are any NA
sum(row.has.na) # sum up all NA, should be: [1] 0
head(MDF) # look up data frame
# Part 2: Generate Dot Plot with Encircling
# step-3 set up two areas 2 with encircling separately for each plot
crucial_igneous <- MDF[MDF$igneous_volc > 50 & MDF$igneous_volc <= 300 & MDF$profile > 5 & MDF$profile <= 25, ]
crucial_angles <- MDF[MDF$tg_angle > 0.00 & MDF$tg_angle <= 0.075 & MDF$profile > 5 & MDF$profile <= 22, ]

# step-4. draw plot nr. 1 for points distribution within areas of igneous volcanic zones by bathymetric profiles
g1 <- ggplot(MDF, aes(x = profile , y = igneous_volc)) +
geom_point(aes(x = profile , y = igneous_volc, colour = "igneous_volc"), size=3, alpha = .5, show.legend=TRUE) +    # Draw points
geom_segment(aes(x = profile, xend = profile, y=min(igneous_volc), yend=max(igneous_volc)),linetype="dashed", size=0.1) +   # Draw dashed lines
geom_encircle(aes(x = profile, y = igneous_volc), data = crucial_igneous, color="red", size=1, expand=0.05) +   # encircle
geom_smooth(aes(x = profile, y = igneous_volc, colour = "Regression loess method"), method = loess, se = FALSE, size = .3, linetype = "solid", span = 1, show.legend=TRUE) +
geom_smooth(aes(x = profile, y = igneous_volc, colour = "Regression lm method"), method = lm, formula = y ~ splines::bs(x, 3), se = FALSE, size=.3, linetype = "solid", show.legend=TRUE) +
#          coord_flip() +
scale_color_manual(values = c("Regression loess method" = "orange", "Regression lm method" = "blue", "igneous_volc" = "royalblue1")) +
xlab("Profiles, Nr.") +
ylab("Observation Points within Igneous Areas") +
labs(title="Mariana Trench, Profiles Nr.1-25.",
subtitle = "Ranking Dot Plot. \nDistribution of Observation Points across Igneous Volcanic Areas",
caption = "Statistics Processing and Graphs: R Programming. Data Source: QGIS") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(margin = margin(t = 0, r = 20, b = 5, l = 0), family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(margin = margin(t = 10, r = 20, b = 10, l = 0), family = "Hei", face = "bold", size = 10),
plot.caption = element_text(face = 2, size = 6),
panel.background=ggplot2::element_rect(fill = "white"),
axis.title.y = element_text(size = 8),
axis.title.x = element_text(size = 8),
axis.text.x = element_text(family = "Arial", face = 3, color = "gray24",size = 8, angle = 15),
axis.text.y = element_text(family = "Arial", face = 3, color = "gray24",size = 8, angle = 90),
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
legend.text = element_text(colour="black", size = 6, face=1),
legend.title = element_text(colour="black", size = 6, face=1))
g1
# step-5. draw plot nr. 2: increased steepness of the angles by the bathymetric profiles 1:25 (tangents)

g2 <- ggplot(MDF, aes(x = profile , y = tg_angle)) +
geom_point(aes(x = profile , y = tg_angle, colour = "tg angles"), size=3, alpha = .5, show.legend=TRUE) +    # Draw points
geom_segment(aes(x = profile, xend = profile, y=min(tg_angle), yend=max(tg_angle)),linetype="dashed", size=0.1) +   # Draw dashed lines
geom_encircle(aes(x = profile, y = tg_angle), data = crucial_angles, color="red", size=1, expand=0.05) +   # encircle
geom_smooth(aes(x = profile, y = tg_angle, colour = "Regression loess method"), method = loess, se = FALSE, size = .3, linetype = "solid", span = 1, show.legend=TRUE) +
geom_smooth(aes(x = profile, y = tg_angle, colour = "Regression lm method"), method = lm, formula = y ~ splines::bs(x, 3), se = FALSE, size=.3, linetype = "solid", show.legend=TRUE) +
#          coord_flip() +
xlab("Profiles, Nr.") +
ylab(expression(tg*degree*(A/H))) +
geom_segment(aes(x = 22, y = 0.075, xend = 23, yend = 0.079, color = "arrow"), size = .2, arrow = arrow(length = unit(0.1, "cm"))) + # draw arrow 1
geom_segment(aes(x = 22, y = 0.073, xend = 24.5, yend = 0.068, color = "arrow"), size = .2, arrow = arrow(length = unit(0.1, "cm"))) + # draw arrow 2
annotate("text", label = "Outliers", family = "Times New Roman", size = 3, color = "red", x = 22, y = 0.074) + # subscript annotation text by arrow (here: number of bathymetric observations)
scale_color_manual(values = c("Regression loess method" = "orange", "Regression lm method" = "blue", "tg angles" = "purple", "arrow" = "red")) +
labs(title="Mariana Trench, Profiles Nr.1-25.",
subtitle=expression(paste("Ranking Dot Plot. \nVariation of Steepness Angles ", tg*degree*(A/H), " by profiles 1:25")),
caption = "Statistics Processing and Graphs: R Programming. Data Source: QGIS") +
#        scale_fill_brewer(palette = "RdBu") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(margin = margin(t = 0, r = 20, b = 5, l = 0), family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(margin = margin(t = 10, r = 20, b = 10, l = 0), family = "Hei", face = "bold", size = 10),
plot.caption = element_text(face = 2, size = 6),
panel.background=ggplot2::element_rect(fill = "white"),
axis.title.y = element_text(size = 8),
axis.title.x = element_text(size = 8),
axis.text.x = element_text(family = "Arial", face = 3, color = "gray24",size = 8, angle = 15),
axis.text.y = element_text(family = "Arial", face = 3, color = "gray24",size = 8, angle = 90),
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
legend.text = element_text(colour="black", size = 6, face=1),
legend.title = element_text(colour="black", size = 6, face=1))
g2

# step-6. mege 2 plots.
figure <-plot_grid(g1, g2, labels = c("1", "2"), ncol = 2, nrow = 1)
figure
# step-7. save as a jpeg in R (require library(jpeg))
img<-readJPEG("volcanoes.jpg")
plot(1:10,ty="n")
rasterImage(img,1,1,10,10)
# optional step-8. dot plot via ggplot2.dotplot :
g1<- ggplot2.dotplot(data = MDF, xName='profile',yName='tg_angle',
xShowTitle=FALSE, yShowTitle=FALSE,
xTickLabelFont=c(8,"bold", "grey"),
yTickLabelFont=c(8,"bold", "grey"),
xtickLabelRotation=45, ytickLabelRotation=45)
