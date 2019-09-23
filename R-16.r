# Part-1. Prepare data frame.
# step-1. read in table with data. create initial data frame. clean up from от NA
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. merge categories by groups into classes (here: tectonics, depths, angles)
MDFt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDFt)
# step-3 create short data frame from 3 values (value - length of the 'flower' petal within the diagram)
data<- data.frame(
id = MDFt$profile, # numbers as factor value, i.e. just as sequence 1:25
individual = paste("Profile", seq(1,25), sep=""),
group = MDFt$variable, # here: 4 tectonic plates
value = MDFt$tectonics) # here: value of the sediment thickness layer (length of the petal of circle)
levels(MDFt$variable) = c("Philippine" , "Pacific", "Mariana", "Caroline") # implicitly rename tectonic plates to be shown on the axis X

# Order data:
data = data %>% arrange(group, value)
# step-4 create empty column to add some space at the end of each group
empty_bar=3
to_add = data.frame( matrix(NA, empty_bar*nlevels(data$group), ncol(data)))
colnames(to_add) = colnames(data)
to_add$group=rep(levels(data$group), each=empty_bar)
data=rbind(data, to_add)
data=data %>% arrange(group)
data$id=seq(1, nrow(data))

# Part-2.
# step-5 create tables for each petal getting the names from the data frame and the y position of each label
label_data = data
number_of_bar=nrow(label_data) # шаг-4 подсчитываем углы calculate the ANGLE of the labels
angle = 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust<-ifelse(angle < -90, 1, 0) # distribute labels on right and left
label_data$angle<-ifelse(angle < -90, angle+180, angle) # flip tables to make them readable

# Part-3 Draw the circle
# step-6. prepare a data frame for the base lines
base_data=data %>%
group_by(group) %>%
summarize(start=min(id), end=max(id) - empty_bar) %>%
rowwise() %>%
mutate(title=mean(c(start, end)))
# step-7. prepare a data frame for grid (scales)
grid_data = base_data
grid_data$end = grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
grid_data$start = grid_data$start - 1
grid_data=grid_data[-1,]
# step-8.
p <- ggplot(data, aes(x = as.factor(id), y = value, fill = group)) +
geom_bar(aes(x = as.factor(id), y = value, fill = group), stat="identity", alpha=0.5) +
#    scale_fill_distiller(palette = "Set1") +
scale_fill_manual(values = c("purple", "deeppink", "blue", "cyan")) +
# step-9. Add a val=100/75/50/25 lines to make sure barplots are over it.
# here: draw come ticks of scale in the empty spaces between the petals from 25 to 100, further up to 500 by 100.
geom_segment(data=grid_data, aes(x = end, y = 500, xend = start, yend = 500), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 400, xend = start, yend = 400), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 300, xend = start, yend = 300), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 200, xend = start, yend = 200), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 100, xend = start, yend = 100), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 80, xend = start, yend = 80), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 60, xend = start, yend = 60), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 40, xend = start, yend = 40), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
geom_segment(data=grid_data, aes(x = end, y = 20, xend = start, yend = 20), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
# step-10. add annotations of the scale ticks in one of the bars showing the value of each 100/75/50/25 lines
annotate("text", x = rep(max(data$id),9), y = c(20, 40, 60, 80, 100, 200, 300, 400, 500), label = c("20", "40", "60", "80", "100", "200", "300", "400", "500") , color="grey", size = 2 , angle=0, fontface="bold", hjust=1) +
ylim(-200,550) + # ylim here 2 diameters of the circle - outer and inner
# here: ylim = 550, because all values of the tectonics do not overstep 550 (i.e. outer circle)
# value -50 - diamcircleeter of the inner circle.
#theme_minimal() +
theme(
legend.position = "none",
axis.text = element_blank(),
axis.title = element_blank(),
plot.title = element_text(margin = margin(t = 0, r = 0, b = 0, l = 0), size = 10, face = "bold"),
plot.margin = unit(rep(-1,4), "cm")) +
coord_polar() +
geom_text(data = label_data, aes(x = id, y = value+10, label = individual, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=2.0, angle= label_data$angle, inherit.aes = FALSE ) +
# Add base line information
geom_segment(data = base_data, aes(x = start, y = -5, xend = end, yend = -5), colour = "black", alpha=0.8, size=0.6 , inherit.aes = FALSE )  +
geom_text(data = base_data, aes(x = title, y = -18, label = group), hjust=c(1,1,0,0), colour = "black", alpha=0.8, size=3, fontface="bold", inherit.aes = FALSE)
p
