# step-1. load table
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. variant-1 for aspect class
library(waffle)
var <- MDF$aspect_class
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows)
categ_table <- round(table(var) * ((nrows*nrows)/(length(var))))
categ_table
aspect <- c("East"=8, "North" =24, "North-East" = 8, "North-West" = 16, "South" = 4, "South-East" = 12, "South-West" = 16, "West" = 12 )
aspect
wa<- waffle(aspect, rows=10, size=0.5,
colors=c("aquamarine", "cadetblue1", "darkseagreen1", "papayawhip", "thistle1", "lavender", "lightsteelblue1", "mistyrose"),
title=list("Aspect degree in basement. \nMariana Trench, bathymetric profiles 1:25", size=0.3), xlab="total square: 100%")
wa
# step-3. variant-2 for morphology (angle steepness)
var <- MDF$morph_class
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows)
categ_table <- round(table(var) * ((nrows*nrows)/(length(var))))
categ_table
morph <- c("Extreme Slope"=24, "Steep Slope" =20, "Strong Slope" = 16, "Very Steep Slope" = 40)
morph
wm<- waffle(morph, rows=10, size=0.5,
title=list("Steepness angle morphology class. \nMariana Trench, bathymetric profiles 1:25", size=0.3),
xlab="total square: 100%")
wm
# step-4. combine both plots together on one layout
iron(wa, wm)
