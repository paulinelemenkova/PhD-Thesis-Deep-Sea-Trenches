# step-1. read in table, create data frame
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. merge columns by categories (4 tectonic plates)
MDTt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDTt)
levels(MDTt$variable) = c("Philippine Plate" , "Pacific Plate", "Mariana Plate", "Caroline Plate")
head(MDTt)
# step-3. plot mosaic by 4 tectonic plates
mosaicplot(MDF, color = NULL, main = "Title")
count <- table(MDTt$variable, MDTt$tectonics)
count
# step-4. variant-1 normal plot
MosaicTect<- mosaicplot(count, main = "Mariana Trench: \nMosaic Plot",
sub = "1:518 observation points in each profile",
xlab = "Tectonic Plates", ylab = "Profiles", las = 1,
color =c("steelblue1", "royalblue1", "dodgerblue", "steelblue3", "cornflowerblue", "royalblue4"),
border = "tomato")
MosaicTect
# step-5. vatiant-2 - plot with residuals
MosaicTectRes<- mosaicplot(count, main = "Mariana Trench: \nMosaic Plot",
sub = "1:518 observation points in each profile",
xlab = "Tectonic Plates", ylab = "Profiles", las = 1,
border = "chocolate",
shade = TRUE)
MosaicTectRes
# step-6. via library(vcd) merge columns by categories (4 tectonic plates)
MDTt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDTt)
# step-7.
count <- table(MDF$geom_sedim_thick, MDF$geom_slope_angle)
library(vcd)
mosaic(count, shade=TRUE, legend=TRUE)
# step-8.
# Association Plot Example
library(vcd)
assoc(count, shade=TRUE)
