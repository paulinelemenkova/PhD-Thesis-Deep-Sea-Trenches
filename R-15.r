# Part-1. prepare data frame.
# step-1. read in table with data on geomorphology. Generate initial data frame
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # check up if any NA area available
sum(row.has.na) # sum up all NA, should be: [1] 0
head(MDF)

# Part-2а. Draw 2 plots Y on one axis X "Slope angle", "Sediment thickness"
library(latticeExtra)
# step-3. generate selection of data for new data frame (only 3 useful values)
set.seed(1)
profiles = MDF$profile
Slope_angle = MDF$slope_angle
Sediment_thickness =  MDF$sedim_thick
data=data.frame(profiles, Slope_angle, Sediment_thickness)
# step-4 two plots in one :
p<- xyplot(Slope_angle + Sediment_thickness ~ profiles, data, type = "l")
p
# step-5. plots 1 and 2 read into objects
obj1 <- xyplot(Slope_angle ~ profiles, data, type = "l" , lwd=1)
obj2 <- xyplot(Sediment_thickness ~ profiles, data, type = "l", lwd=1)
# step-6. add 2nd axis Y:
doubleYScale(obj1, obj2, add.ylab2 = TRUE)
# step-7. add legend:
p<- doubleYScale(obj1, obj2, text = c("Slope angle", "Sediment thickness") , add.ylab2 = TRUE)

# Part-2b. Categories: "Slope angle", "Aspect degree" by bathymetric profiles
# step-8. generate selection of data for new data frame (only 3 useful values)
set.seed(1)
profiles = MDF$profile
Slope_angle = MDF$slope_angle
Aspect_degree =  MDF$aspect_degree
data=data.frame(profiles, Slope_angle, Aspect_degree)
p<- xyplot(Slope_angle + Aspect_degree ~ profiles, data, type = "l")
p
# step-9. plots 1 and 2 read into objects
obj1 <- xyplot(Slope_angle ~ profiles, data, type = "l" , lwd=1)
obj2 <- xyplot(Aspect_degree ~ profiles, data, type = "l", lwd=1)
doubleYScale(obj1, obj2, add.ylab2 = TRUE)
# step-10. add legend:
p1 <- doubleYScale(obj1, obj2, text = c("Slope angle", "Aspect degree") , add.ylab2 = TRUE)

# Part-2c. Categories: "Slope angle", "igneous volcanic areas" by bathymetric profiles
# step-10. generate selection of data for new data frame (only 3 useful values)
set.seed(1)
profiles = MDF$profile
Slope_angle = MDF$slope_angle
Igneous_volcanic =  MDF$igneous_volc
data=data.frame(profiles, Slope_angle, Igneous_volcanic)
# step-11 plots together:
p<- xyplot(Slope_angle + Igneous_volcanic ~ profiles, data, type = "l")
p
# step-12. plots 1 and 2 read into objects, add 2nd axis Y:
obj1 <- xyplot(Slope_angle ~ profiles, data, type = "l" , lwd=1)
obj2 <- xyplot(Igneous_volcanic ~ profiles, data, type = "l", lwd=1)
doubleYScale(obj1, obj2, add.ylab2 = TRUE)
# step-13. add legend:
p2 <- doubleYScale(obj1, obj2, text = c("Slope angle", "Igneous volcanic") , add.ylab2 = TRUE)
p2

