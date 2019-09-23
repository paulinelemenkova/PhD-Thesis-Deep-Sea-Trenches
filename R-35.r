library(ggridges)
library(ggplot2)
# Part-1 for tectonic plates
# step-1. Read in table, create data frame
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. Merge columns by categories (4 tectonic plates)
MDTt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDTt)
levels(MDTt$variable) = c("Philippine Plate" , "Pacific Plate", "Mariana Plate", "Caroline Plate")
head(MDTt)
# step-3. Create  short data frame of 2 categories: 4 tectonic plates and bathymetric depth points
dat <- data.frame(group = MDTt$variable,
pweight = MDTt$tectonics,
tectonics = MDTt$tectonics)
# step-4. Plot ridgeline plots
ggplot(dat, aes(x = tectonics, y = group, fill = group)) +
geom_density_ridges(scale = .95, jittered_points=TRUE, rel_min_height = .01,
point_shape = "|", point_size = 3, size = 0.25,
position = position_points_jitter(height = 0)) +
scale_fill_manual(values = c("lightsteelblue1", "plum1", "turquoise1", "lightgoldenrod1")) +
theme_ridges() +
theme(legend.position = "none",
plot.title = element_text(family = "Times New Roman", face = 2, size = 12),
plot.subtitle = element_text(family = "Times New Roman", face = 1, size = 12),
axis.title.y = element_text(family = "Times New Roman", face = 1, size = 12),
axis.title.x = element_text(family = "Times New Roman", face = 1, size = 12),
axis.text.x = element_text(family = "Times New Roman", face = 3, size = 12),
axis.text.y = element_text(family = "Times New Roman", face = 3, size = 12)) +
labs(title = 'Mariana Trench',
subtitle = 'Ridgeline Plot on Tectonics: Density Distribution of the Observation Points by Plates')

# Part-2 for bathymetry
# step-5. read in table, create data frame.
MDD <- read.csv("Depths.csv", header=TRUE, sep = ",")
MDD <- na.omit(MDD)
row.has.na <- apply(MDD, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDD)
# step-6. merge columns by categories (4 tectonic plates)
MDDl = melt(setDT(MDD), measure = patterns("^profile"), value.name = c("depth"))
head(MDDl)
# step-7. create short data frame of 2 categories: 4 tectonic plates and bathymetry
dat <- data.frame(group = MDDl$variable,
pweight = MDDl$depth,
depth = MDDl$depth)
# step-8. Plot ridge line plots
ggplot(dat, aes(x = depth, y = group, fill = group)) +
geom_density_ridges(scale = 0.95, jittered_points=FALSE, color = "blue", size = 0.2) +
labs(title = 'Mariana Trench',
subtitle = 'Ridgeline Plot on Bathymetry: Density Distribution of Depth Observation Points') +
scale_fill_viridis(discrete = T, option = "B", direction = -1, begin = .1, end = .9) +
theme_ridges() +
theme(legend.position = "none",
plot.title = element_text(family = "Times New Roman", face = 2, size = 12),
plot.subtitle = element_text(family = "Times New Roman", face = 1, size = 12),
axis.title.y = element_text(family = "Times New Roman", face = 1, size = 12),
axis.title.x = element_text(family = "Times New Roman", face = 1, size = 12),
axis.text.x = element_text(family = "Times New Roman", face = 3, size = 10),
axis.text.y = element_text(family = "Times New Roman", face = 3, size = 10))

