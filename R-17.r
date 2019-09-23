# Multiple Strip plots
# Part-1. prepare data frame
# step-1. read in table with data. create initial data frame. clean up data frame from the NA values
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. merge 4 columns with names of the plates into one named "tectonic plates"
MDFt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonic plates"))
head(MDFt)
# step-3. indicate column with names of the tectonic plates as factor value (variable)
MDFt$variable =as.factor(MDFt$variable)
levels(MDFt$variable)=c("Philippine" , "Pacific", "Mariana", "Caroline") # implicitly write the names of the 4 plates to be indicated on the X axis

# Part-2. generate well structured name (title + subtitle)
# step-4.
doubleTitle <- function(a,b) {
    gTree(children=gList(
    textGrob(a, gp=gpar(fontsize=10, fontface=1), y=0,
    vp=viewport(layout.pos.row=1, layout.pos.col=1)),
    textGrob(b, gp=gpar(fontsize=8, fontface=3), y=0,
    vp=viewport(layout.pos.row=2, layout.pos.col=1))
    ), vp=viewport(layout=grid.layout(nrow=2, ncol=1)), cl="doubletitle")
}
heightDetails.doubletitle <- function(x, recording=T) {
    Reduce(`+`, lapply(x$children, grid:::heightDetails.text)) * 2
}

# Part-3. Strip plot (vertical distribution of the values by 4 categories))
# step-5. strip plot
# step 5.1 angle of steepness:
s1<- stripplot(slope_angle ~ variable,  data = MDFt, jitter.data = TRUE, pch = 20,  palette="Set2",
xlab = list(label="Tectonic Plates", cex= 0.60),
ylab = list(label="Slope Angle(tg(A/H))", cex= 0.60),
main=doubleTitle("Mariana Trench","Slope Angle(tg(A/H)) in 25 Profiles by Tectonic Plates"))
s1
# step 5.2  sediments:
s2<- stripplot(sedim_thick ~ variable,  data = MDFt, jitter.data = TRUE, pch = 20,
xlab = list(label="Tectonic Plates", cex= 0.60),
ylab = list(label="Sedimental Thickness", cex= 0.60),
main=doubleTitle("Mariana Trench","Sedimental Thickness in 25 Profiles by Tectonic Plates"))
s2
# step 5.3  minimal depths:
s3<- stripplot(Min ~ variable,  data = MDFt, jitter.data = TRUE, pch = 20,
xlab = list(label="Tectonic Plates", cex= 0.60),
ylab = list(label="Maximal Depth", cex= 0.60),
main=doubleTitle("Mariana Trench","Maximal Depth in 25 Profiles by Tectonic Plates"))
s3
# step 5.4 zones of the submarine volcanoes:
s4<- stripplot(igneous_volc ~ variable,  data = MDFt, jitter.data = TRUE, pch = 20,
xlab = list(label="Tectonic Plates", cex=0.60),
ylab = list(label="Igneous Volcanic Areas", cex= 0.60),
main=doubleTitle("Mariana Trench","Igneous Volcanic Zones Distribution in 25 Profiles by Tectonic Plates"))
s4
# collect all strip plots on one layout:
g<- grid.arrange(s1, s2, s3, s4, ncol = 2, top = grid::textGrob(label = "Statistics: R Programming. Data Source: QGIS", x=0.1, hjust=0, gp=gpar(fontfamily="serif",fontsize=8, fontface="bold")))
l <- as_ggplot(g) +
draw_plot_label(label = c("A", "B", "C", "D"), size = 10, x = c(0, 0.5, 0, 0.5), y = c(1, 1, 0.5, 0.5))
