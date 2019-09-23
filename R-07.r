# Part 1: generate data.frame
# step-1. read in table.
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # check up if there are any NA
sum(row.has.na) # sum up NA, should be: [1] 0
head(MDF) # look up data frame
# Part 2. Generae and draw correlogram
#  step-3. Generae correogram matrix from the MDF dataframe using Pearson method as all data are normally distributed. Because the data are excessive, use only half of them, the other becomes NA. Сreate correlation matrix using Pearson, as all variables are normally distributed.
thecor<-round(cor(MDF[,sort(c("profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "profile9", "profile10","profile11", "profile12", "profile13", "profile14", "profile15", "profile16", "profile17", "profile18", "profile19", "profile20","profile21", "profile22", "profile23", "profile24", "profile25"))], method="pearson", use="pairwise.complete.obs"),2)
thecor[lower.tri(thecor)]<- NA
thecor
# step-4. merge columns "profile" of the matrix using function melt from the library reshape2. Delete NA values //
library(reshape2)
thecor<-melt(thecor)
thecor$Var1<-as.character(thecor$Var1)
thecor$Var2<-as.character(thecor$Var2)
thecor<-na.omit(thecor)
head(thecor)
#  step-5. draw correlogram using function geom_tile
Correlogramm_Mariana <- ggplot(thecor, aes(Var2, Var1)) +
geom_tile(data=thecor, aes(fill=value), color="white") +
scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1,1), name = "Correlation\n(Pearson)") +
coord_equal() +
labs(title="Mariana Trench, Profiles Nr.1-25.", subtitle = "Correlogram of Correlation Matrix",
caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS") +
theme(
plot.margin = margin(5, 10, 20, 5),
plot.title = element_text(family = "Kai", face = "bold", size = 12), # for Chinese font use Kai
plot.subtitle = element_text(family = "Hei", face = "bold", size = 10), # for Chinese font use Hei
plot.caption = element_text(face = 2, size = 6),
panel.background=ggplot2::element_rect(fill = "white"),
legend.justification = "bottom", legend.position = "bottom",
legend.box.just = "right",
legend.direction = "horizontal",
legend.box = "horizontal",
legend.box.background = element_rect(colour = "honeydew4",size=0.2),
legend.background = element_rect(fill = "white"),
legend.key.width = unit(1,"cm"), legend.key.height = unit(.5,"cm"),
legend.spacing.x = unit(.2,"cm"),legend.spacing.y = unit(.1,"cm"),
legend.text = element_text(colour="black", size=6, face=1),
legend.title = element_text(colour="black", size=6, face=1),
strip.text.x = element_text(colour = "white", size=6, face=1),
panel.grid.major = element_line("gray24", size = 0.1, linetype = "solid"),
panel.grid.minor = element_line("gray24", size = 0.1, linetype = "dotted"),
axis.text.x = element_text(face = 3, color = "gray24", size = 6, angle = 45),
axis.text.y = element_text(face = 3, color = "gray24", size = 6, angle = 15),
axis.ticks.length=unit(.1,"cm"),
axis.line = element_line(size = .3, colour = "grey80"),
axis.title.y = element_text(margin = margin(t = 20, r = .3), face = 2, size = 8),
axis.title.x = element_text(face = 2, size = 8, margin = margin(t = .2))) +
guides(col = guide_legend(nrow = 1, ncol = 6, byrow = TRUE)) # improve design of the legend.
Correlogramm_Mariana
ggsave("Correlogramm_Mariana.pdf", device = cairo_pdf, fallback_resolution = 300)
