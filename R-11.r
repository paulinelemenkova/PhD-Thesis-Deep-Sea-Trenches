# Part-1. Generate inicial data frame
# step-1. read in table
MorDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
head(MorDF)
summary(MorDF)
# step-2. select two necessary columns from the initial table: numeric and symbol values. Generate from the them a new MDF data frame.
profile<- as.character(MorDF$profile)
tg_angle <- as.numeric(MorDF$tg_angle)
MDF<- data.frame(profile, tg_angle)
head(MDF)

# Part-2. change data frame MDF.
# step-3. Add new column for bathymetric profile names (here: by rows 1:25)
MDF$"profile name" <- rownames(MDF)
# step-4. re-calculate argumant values (by axis X) normalized by the difference between mean and standard deviation)
MDF$norm_tg_angle <- round((MDF$tg_angle - mean(MDF$tg_angle))/sd(MDF$tg_angle), 2)  # compute normalized tg_angle
# step-5. distribute values of the normalized argument on "above" and "below" mean
MDF$angle_type <- ifelse(MDF$norm_tg_angle < 0, "below", "above")  # above / below avg flag
# step-6. sort dataframe
MDF <- MDF[order(MDF$norm_tg_angle), ]  # sort
# step-7. values by Y axis (here: profile names) convert onto factor
MDF$"profile name" <- factor(MDF$"profile name", levels = MDF$"profile name")  # convert to factor to retain sorted order in plot.
class(MDF$profile name) # check up class
# [1] "factor" - should be
MDF # look up new data frame (5 columns vs initial 2 columns)

# Part-3. draw 2 plots by data frame MDF created in Part-2.
# step-8. Diverging Barcharts
Diverging_Bars<- ggplot(MDF, aes(x = MDF$"profile name", y = MDF$norm_tg_angle, label = MDF$norm_tg_angle)) +
geom_bar(stat='identity', aes(fill = MDF$angle_type), width=.5) +
xlab("Profiles, Nr.") +
ylab(expression(tg*degree*(A/H))) +
scale_fill_manual(name="(tg(A/H))",
labels = c("Above Average", "Below Average"),
values = c("above"="lawngreen", "below"="coral1")) +
labs(title= "Mariana Trench. Diverging Bars",
subtitle=expression(paste("Normalized steepness ", tg*degree*(A/H), " vs profiles 1:25"))) +
coord_flip() +
theme(plot.title = element_text(size = 10),
legend.title = element_text(size=8), legend.text = element_text(colour="black", size = 8))
Diverging_Bars
# step-9. Plotting "Lollipop Chart"
Lollipop <- ggplot(MDF, aes(x = MDF$"profile name", y = MDF$norm_tg_angle, label = MDF$norm_tg_angle)) +
xlab("Profiles, Nr.") +
ylab(expression(tg*degree*(A/H))) +
geom_point(stat='identity', fill="black", size=6)  +
geom_segment(aes(y = 0, x = MDF$"profile name", yend = MDF$norm_tg_angle, xend = MDF$"profile name"), color = "black") +
geom_text(color="white", size=2) +
labs(title="Mariana Trench: Diverging Lollipop Chart",
subtitle=expression(paste("Normalized steepness ", tg*degree*(A/H), " vs profiles 1:25"))) +
ylim(-2.5, 2.5) +
coord_flip() +
theme(plot.title = element_text(size = 10), legend.title = element_text(size=8), legend.text = element_text(colour="black", size = 8))
Lollipop
# step-10. place both pots on one layout
figure <-plot_grid(Diverging_Bars, Lollipop, labels = c("1", "2"), ncol = 2, nrow = 1)
# step-11. add common title, subtitle, subscript
LollipopBar <- figure +
labs(title="Mariana Trench, Profiles Nr.1-25.",
subtitle = "Geomorphological Analysis: Normalised Steepness Angles",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(margin = margin(t = 0, r = 20, b = 5, l = 0), family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(margin = margin(t = 0, r = 20, b = 4, l = 0), family = "Hei", face = "bold", size = 10),
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
legend.title = element_text(colour="black", size=6, face=1))
LollipopBar
