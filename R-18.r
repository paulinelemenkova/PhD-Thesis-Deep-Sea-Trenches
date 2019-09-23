# Part-1. generate data frame.
# step-1.
MDepths <- read.csv("DepthTect.csv", header=TRUE, sep = ",")
MDFl <- na.omit(MDepths)
row.has.na <- apply(MDFl, 1, function(x){any(is.na(x))}) # check up NA
sum(row.has.na) # sum up NA: [1] 0
head(MDFl) # look up clean data frame
# step-2. merge groups of categories by classes (here: tectonic plates, depths, slope angles)
DFDT = melt(setDT(MDFl), measure = patterns("^profile", "^tectonics", "^tg"), value.name = c("depth", "tectonics", "trench_angle"))
head(DFDT)
# step-3. Multiple panels by groups: y ~ x | group generate multi-plot
p<- xyplot(depth ~ variable | tectonics,
group = tectonics, data = DFDT,
type = c("p", "smooth"),
scales = "free",
main="Multiple ScatterPlot: Depths Distribution by Tectonic Plates",
xlab="Profiles, Nr")
p
