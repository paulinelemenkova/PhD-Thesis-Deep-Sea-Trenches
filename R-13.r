# Part-1. Prepare data frame
# step-1. read in table. create initial data frame
MDepths <- read.csv("DepthTect.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # check up if there is any NA
sum(row.has.na) # sum up all NA, should be: [1] 0
head(MDF) # look up clean data frame
# step-3. merge table columns by 3 parameters, here: depths, tectonics, steepness angles. using melt от library(data.table)
DFDT = melt(setDT(MDF), measure = patterns("^profile", "^tectonics", "^tg"), value.name = c("depths", "tectonics", "angles"))
DFDT

# Part 2: draw categorywise bar chart, with colors by categories
# step-4. draw diagram, add , добавляем legend, design
g <- ggplot(DFDT, aes(variable)) +
geom_bar(aes(fill = tectonics), width = 0.5, na.rm = TRUE) +
theme(axis.text.x = element_text(angle=65, vjust=0.6)) +
xlab("Profiles, Nr.") +
ylab("Observation Points") +
labs(title="Mariana Trench, Profiles Nr.1-25.",
subtitle = "Categorywise Bar Chart. \nDistribution of Observation Points across Tectonic Plates: \nMariana, Philippine, Pacific and Caroline",
caption = "Statistics Processing and Graphs: R Programming. Data Source: QGIS") +
scale_fill_brewer(palette = "RdBu") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(margin = margin(t = 0, r = 20, b = 5, l = 0), family = "Kai", face = "bold", size = 12),
plot.subtitle = element_text(margin = margin(t = 0, r = 20, b = 4, l = 0), family = "Hei", face = "bold", size = 10),
plot.caption = element_text(face = 2, size = 6),
panel.background=ggplot2::element_rect(fill = "white"),
axis.title.y = element_text(size = 8),
axis.title.x = element_text(size = 8),
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
g
