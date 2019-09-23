library(car)
library(RColorBrewer)
# Part 1: create data.frame
# step-1. read in table. build data frame
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. merge values of 4 tectonic plates into one category
MDFT = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDFT)
levels(MDFT$variable) = c("Philippine Plate" , "Pacific Plate", "Mariana Plate", "Caroline Plate") # rename values
head(MDFT)
# step-3. read data frame into object 'data'
data= MDFT
# step-4. set up colors Set2 by category 'tectonics'
my_colors <- brewer.pal(nlevels(as.factor(data$variable)), "Set2")

# Part-2. Plotting
# step-5. Variant-1: tectonics + slope angle + igneous volcanic zones
scatterplotMatrix(~ tectonics + slope_angle + igneous_volc | variable, data=data ,
smoother="", col=my_colors , smoother.args=list(col="grey") ,
regLine = list(method=lm, lty=1, lwd=1),
lwd=0.5, pch=c(15,16,17) ,
main="Mariana trench scatter plot (tectonics, geomorphology, magmatism) \nwith four tectonic plates options: Mariana, Caroline, Philippine, Pacific",
cex=1.0, cex.axis = 1.0, # cex.axis, font of legend
legend = TRUE, cex.labels =1.3, cex.main = 1.0, ellipse=F,
var.labels = c("tectonics", "geomorphology \n(slope angle)", "magmatism \n(igneous volcanic zones)")
)
# step-6. Variant-2: depths + sediments + igneous volcanic zones
scatterplotMatrix(~ tectonics + Min + sedim_thick | variable, data=data ,
smoother="", col=my_colors , smoother.args=list(col="grey") ,
regLine = list(method=lm, lty=1, lwd=1),
lwd=0.5, pch=c(15,16,17) ,
main="Mariana trench scatter plot (tectonics, bathymetry, geology) \nwith four tectonic plates options: Mariana, Caroline, Philippine, Pacific",
cex=1.0, cex.axis = 1.0, # cex.axis, font of legend
legend = TRUE, cex.labels =1.3, cex.main = 1.0, ellipse=F,
var.labels = c("tectonics", "bathymetry \n(minimal depth)", "geology \n(sedimental thickness)")
)
# step-7. plotting
plot(data , pch=1 , cex=0.3 , col=rgb(0.5, 0.8, 0.9, 0.7))
