# Part-1. Generate data frame
# step-1. prepare data
MDepths <- read.csv("DepthTect.csv", header=TRUE, sep = ",")
MDFl <- na.omit(MDepths)
row.has.na <- apply(MDFl, 1, function(x){any(is.na(x))})
sum(row.has.na) #: [1] 0
head(MDFl)
# step-2. merge groups of categories by classes (here: tectonic plates, depths, slope angles)
DFDT = melt(setDT(MDFl), measure = patterns("^profile", "^tectonics", "^tg"), value.name = c("depth", "tectonics", "trench_angle"))
DFDT
# step-3. generate multi-plot (here: by types of the tectonic plates as slope angles and depths change)
densityplot(~ depth, groups = variable, data = DFDT, plot.points = FALSE, auto.key = FALSE)
densityplot(~ depth, groups = tectonics, data = DFDT, plot.points = FALSE, auto.key = TRUE)
