# QQ t.test facetwrap // QQ- statistics (quantiles)
# Part 1: generate data.frame
# step-1. read-in table. generate data frame.
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) #
sum(row.has.na) # sum up all NA: [1] 0
head(MDF) # look up data frame.

# Part 2: merge all columns by "profile nr." type into one category "profiles".
# step-3. id - numbers of bathymetric observation points (1:518).
MarDF_NEW<- melt(MDF, id.vars = c('observ'), measure.vars = c("profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "profile9", "profile10","profile11", "profile12", "profile13", "profile14", "profile15", "profile16", "profile17", "profile18", "profile19", "profile20","profile21", "profile22", "profile23", "profile24", "profile25"), variable.name ='profiles')
head(MarDF_NEW)

# Part 3: generate multiple facets plot from 25 bathymetric profiles using QQ-statistics, draw plot.
# step-4.
QQ_facetwrapMD<- ggplot(MarDF_NEW, aes(sample = value, color = "profiles", size = "profiles"), show.legend=FALSE) +
stat_qq() +
facet_wrap( ~ profiles, labeller = label_both) +
xlab("Theoretical Quantiles") +
ylab("Sample Quantiles (Depths, m)") +
labs(title="Mariana Trench, Profiles Nr.1-25.",
subtitle = "Normal QQ Statistics (Quantile-Quantile))",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
geom_abline(aes(intercept = mean(value), slope = sd(value), color = "mean"), size = .3) + # draw mean linens  standard deviation
geom_segment(aes(x = 1, y = -7500, xend = 0, yend = -5000, color = "nr_of_samples"), size = .1, arrow = arrow(length = unit(0.1, "cm"))) + # draw arrow for annotation by every plot
annotate("text", label = "n = 518", family = "Times New Roman", size = 2, color = "blue", x = 1, y = -8000) + # subscript annotation text vy the arrow (here: number of observations)
scale_color_manual(name = "Legend:", values = c(mean = "red", text = "blue", nr_of_samples = "blue", profiles = "green")) +
scale_size_manual(values= c(0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1)) +
scale_x_continuous(breaks = c(seq(-3, 3, by = 1))) + # additional X axises, by 1, from -3 up to 3.
scale_y_continuous(breaks = c(seq(-10000, 0, by = 2500))) +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(family = "Kai", face = "bold", size = 10),
plot.subtitle = element_text(family = "Hei", face = "bold", size = 8),
plot.caption = element_text(face = 2, size = 6),
panel.background=ggplot2::element_rect(fill = "white"),
legend.justification = "bottom",
legend.position = "bottom",
legend.box.just = "right",
legend.direction = "horizontal",
legend.box = "horizontal",
legend.box.background = element_rect(colour = "honeydew4",size=0.2),
legend.background = element_rect(fill = "white"),
legend.key.width = unit(.1,"cm"),
legend.key.height = unit(.1,"cm"),
legend.spacing.x = unit(.1,"cm"),
legend.spacing.y = unit(.1,"cm"),
legend.text = element_text(family = "Arial", colour="black", size=6, face=1),
legend.title = element_text(family = "Arial", colour="black", size=6, face=1),
strip.text.x = element_text(colour = "white", family = "Arial", size=6, face=1),
panel.grid.major = element_line("gray24", size = 0.1, linetype = "solid"),
panel.grid.minor = element_line("gray24", size = 0.1, linetype = "dotted"),
axis.text.x = element_text(family = "Arial", face = 3, color = "gray24",size = 5, angle = 15),
axis.text.y = element_text(family = "Arial", face = 3, color = "gray24",size = 4, angle = 15),
axis.ticks.length=unit(.1,"cm"),
axis.line = element_line(size = .3, colour = "grey80"),
axis.title.y = element_text(margin = margin(t = 20, r = .3), family = "Times New Roman", face = 2, size = 8),
axis.title.x = element_text(family = "Times New Roman", face = 2, size = 8, margin = margin(t = .2))) +
guides(col = guide_legend(nrow = 2, ncol = 3, byrow = TRUE)) # extend legend vertically.
QQ_facetwrapMD
