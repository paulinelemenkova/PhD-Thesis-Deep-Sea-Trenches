# step-1. read in table with data on geomorphology. create data frame
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. set up values XYZ
x <- MDF$slope_angle
y <- MDF$depth_min
data <- expand.grid(X=x, Y=y)
data$Z <- MDF$sedim_thick
# step-3. generate levelplot by (ggplot2) library
ggplot(data, aes(X, Y, z = Z)) + geom_tile(aes(fill = Z)) +
theme_bw() +
scale_fill_gradient(name = "Sediment \nThickness", low="white", high="blue") +
labs(
title = "Mariana Trench",
subtitle = "Levelplot of Sediment Thickness",
x = "Trench slope angle",
y = "Depth (m)")

