# Part-1. Generate data frame
# step-1. read in table
MorDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
head(MorDF)
summary(MorDF)

# Part-2. Draw Dumbbell chart
theme_set(theme_classic())
# step-2. set up factor value (here: numbers of the bathymetric profiles 1:25)
profile<- factor(MorDF$profile, levels=as.character(MorDF$profile))  # for right ordering of the dumbells
# step-3. compare distribution of the bathymetric observation points in a pair "Pacific vs Philippine plates"
PacPhil <- ggplot(MorDF, aes(x = plate_phill, xend = plate_pacif, y = profile, group = profile)) +
geom_dumbbell(color = "thistle4", size=0.3, colour_xend = "deeppink", size_xend = 1.5, colour_x = "darkviolet", size_x = 1.5, show.legend = T) +
labs(x = "Observation Points", y = "Profiles", title="Dumbbell Chart \nMariana Trench, Profiles Nr1-25",
subtitle="Value Change: Observation Points; Philippine Plate vs Pacific Plate",
caption="OUC, Qingdao2018. \nStatistics Processing and Graphs: R Programming. Data Source: QGIS") +
scale_x_continuous(breaks = c(seq(0, 500, by = 100)), minor_breaks = c(seq(0, 500, by = 50))) +
scale_y_continuous(breaks = c(seq(1, 25, by = 1))) +
theme(plot.title = element_text(margin = margin(t = 0, r = 20, b = 5, l = 0), family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(margin = margin(t = 0, r = 20, b = 4, l = 0), family = "Hei", face = "bold", size = 8),
plot.caption = element_text(margin = margin(t = 20, r = 10, b = 4, l = 0), family = "Kai", face = "bold", size = 8),
plot.background=element_rect(fill = "white"),
axis.text.x = element_text(face = 3, color = "gray24", size = 6),
axis.text.y = element_text(face = 3, color = "gray24", size = 6),
axis.title.y = element_text(size = 8),axis.title.x = element_text(size = 8),
axis.ticks=element_blank(),legend.position="top",
panel.background=element_rect(fill = "grey95", colour = "grey95"),
panel.grid.major = element_line("white", size = 0.4), panel.grid.minor = element_line("white", size = 0.4, linetype = "dotted"), panel.border=element_blank())
PacPhil
# step-4. compare distribution of the bathymetric observation points in a pair  "Mariana vs Caroline plates"
MarCar <- ggplot(MorDF, aes(x = plate_maria, xend = plate_carol, y = profile, group = profile)) +
geom_dumbbell(color = "thistle4", size=0.3, colour_xend = "orange", size_xend = 1.5, colour_x = "navy", size_x = 1.5, show.legend = T) +
labs(x = "Observation Points", y = "Profiles",
title="Dumbbell Chart \nMariana Trench, Profiles Nr.1-25.",
subtitle="Value Change: Observation Points; Mariana Plate vs Caroline Plate",
caption="OUC, Qingdao 2018. \nStatistics Processing and Graphs: R Programming. Data Source: QGIS") +
scale_x_continuous(breaks = c(seq(0, 500, by = 100)), minor_breaks = c(seq(0, 500, by = 50))) +
scale_y_continuous(breaks = c(seq(1, 25, by = 1))) +
theme(plot.title = element_text(margin = margin(t = 0, r = 20, b = 5, l = 0), family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(margin = margin(t = 0, r = 20, b = 4, l = 0), family = "Hei", face = "bold", size = 8),
plot.caption = element_text(margin = margin(t = 20, r = 10, b = 4, l = 0), family = "Kai", face = "bold", size = 8),
plot.background=element_rect(fill = "white"),
axis.text.x = element_text(face = 3, color = "gray24", size = 6),
axis.text.y = element_text(face = 3, color = "gray24", size = 6),
axis.title.y = element_text(size = 8),axis.title.x = element_text(size = 8),
axis.ticks=element_blank(),legend.position="top",
panel.background=element_rect(fill = "grey95", colour = "grey95"),
panel.grid.major = element_line("white", size = 0.4),
panel.grid.minor = element_line("white", size = 0.4, linetype = "dotted"),
panel.border=element_blank())
MarCar
# step-5. place both plots on one layout.
figure <-plot_grid(MarCar, PacPhil, labels = c("1", "2"), ncol = 2, nrow = 1)
