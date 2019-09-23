library(treemap)
# step-1. Create a dataset
group=c(rep("tectonics",4),rep("bathymetry",10),rep("geology",2))
subgroup=paste(c("Mariana Plate", "Philippine Plate", "Pacific Plate", "Caroline Plate",
"Depth \n(absolute maximum)", "Slope angle", "Aspect degree", "Depth (Mean)", "Depth (Median)", "Aspect class", "Steepness class", "Depth \n(1 quart.)", "Depth \n(3 quart.)", "tg angle",
"sedimental \nthickness", "igneous \nvolcanic \nspots"))
value=c(22,14,18,7,12,10,6,4,5,9,10,3,2,7,14,17)
data=data.frame(group,subgroup,value)
# step-2. Plot treemap
treemap(data,
title = "Mariana Trench Impact Factors",
index=c("group","subgroup"),
#    palette="Set2"
#    palette="Set1",
palette="Accent",
vSize="value",
type="index" ,
fontsize.labels=c(18,12),# size of labels per level of aggregation: group, subgroup, subsubgroups
fontcolor.labels=c("white","gray40"),
fontface.labels=c(2,1),# Fonts: 1,2,3,4 for normal, bold, italic, bold-italic
bg.labels=c("transparent"),# Background color of labels
align.labels=list(c("center", "center"), c("center", "center")),
overlap.labels=0.9,
inflate.labels=F,# If true, labels are bigger when rectangle is bigger.
border.col=c("gray48","gray30"),# Color of borders of groups, of subgroups
border.lwds=c(4,1)
)

