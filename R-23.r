# Part-1. Prepare dataframe
# step-1. Read table. Clean up NA
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)

# Part-2. Create Euler-Venn Diagram: 3 cases.
library(venn)
# case-1. Morphology and tectonic plates
x <- list(Philippine = MDF$plate_phill, Pacific = MDF$plate_pacif,
Mariana = MDF$plate_maria, Caroline = MDF$plate_carol,
Aspect = MDF$aspect_class,
Morphology = MDF$morph_class, Slope = MDF$slope_class)
venn(x, ilabels = TRUE, col = "navyblue", zcolor = "style")
# case-2. tectonics plates
xp <- list(Philippine = MDF$plate_phill, Pacific = MDF$plate_pacif,
Mariana = MDF$plate_maria, Caroline = MDF$plate_carol)
venn(xp, ilabels = TRUE, ellipse = TRUE, col = "navyblue",
zcolor = "style")
# case-3. Geomorphic parameters
x3 <- list(Depth = MDF$Min, Volcanoles = MDF$igneous_volc,
Sediments = MDF$sedim_thick,
Angle = MDF$slope_angle, Hillshade = MDF$hillshade,
Aspect = MDF$aspect_degree)
venn(x3, ilabels = TRUE, col = "navyblue", zcolor = "style")

