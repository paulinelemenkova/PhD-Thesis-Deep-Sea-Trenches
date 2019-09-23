# BoxPlot (or WhiskerPlot) using ggboxplot
# Part 1: data.frame
	# step-1. read in table, create data frame
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
	# step-2. clean NA
df <- na.omit(MDepths) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # проверяем, удалил ли все NA
sum(row.has.na) # sum up NA: [1] 0
head(df) #look up data frame
	# step-3. select profiles и depths)
MDepths_df <- data.frame(profiles = 1:25, depths = c(df$profile1, df$profile2, df$profile3, df$profile4, df$profile5, df$profile6, df$profile7, df$profile8, df$profile9, df$profile10, df$profile11, df$profile12, df$profile13, df$profile14, df$profile15, df$profile16, df$profile17, df$profile18, df$profile19, df$profile20, df$profile21, df$profile22, df$profile23, df$profile24, df$profile25))
# Part 2: boxplot ("whisker boxplot")
	# step-4. plot by MDepths_df.
p<- ggboxplot(
	MDepths_df, 
	title="马里亚纳海沟。剖面11。Mariana Trench, Profiles 1-25.", 
	subtitle = "统计图表。箱形图。Notched Boxplot for Data Groups by 25 Profiles with Outliers)",
	caption = "Statistics Processing and Graphs: \nR Programming. Data Source: QGIS",
	x = "profiles", 
	y = "depths", 
	width = 0.8, 
	notch = TRUE,
	fill = "profiles",	
	linetype = 1, size = .1,
	outlier.colour = "grey44",
	palette = c("magma"),
	orientation = "horizontal"
	) 
p
   	# step-5 add theme
boxplot_Mariana<- p + 
	theme(
    plot.title = element_text(family = "Kai", face = "bold", size = 12),
	plot.subtitle = element_text(family = "Hei", face = "bold", size = 8),
	plot.caption = element_text(face = 2, size = 6),
    panel.background=ggplot2::element_rect(fill = "white"),
    legend.justification = c(.85, .1), 
    legend.position = c(.85, .1),
    legend.box.just = "right", legend.margin = margin(6, 6, 6, 6),
    legend.direction = "vertical",
    legend.background = element_rect(fill = "white"),
    legend.key.width = unit(.3,"cm"),
    legend.key.height = unit(.3,"cm"), legend.spacing = unit(.3,"cm"),
    legend.box.background = element_rect(colour = "honeydew4",size=0.2),
    legend.text = element_text(family = "Arial", colour="black", size=6, face=1),
    legend.title = element_text(family = "Arial", colour="black", size=6, face=1),
    strip.text.x = element_text(colour = "white"),
    panel.grid.major = element_line("gray24", size = 0.1, linetype = "dotted"),
    panel.grid.minor = element_line("gray24", size = 0.1, linetype = "dotted"),
    axis.text.x = element_text(family = "Arial", face = 3, color = "gray24",size = 6, angle = 15),
    axis.text.y = element_text(family = "Arial", face = 3, color = "gray24",size = 6, angle = 90),
    axis.ticks.length=unit(.1,"cm"),
    axis.line = element_line(size = .3, colour = "grey80"),
    axis.title.y = element_text(margin = margin(t = 20, r = .3), family = "Times New Roman", face = 2, size = 8),
    axis.title.x = element_text(family = "Times New Roman", face = 2, size = 8,margin = margin(t = .2)))
boxplot_Mariana
