# ternaries
# Part 1: create data frame, delete NA values
# step-1. read in table with data.
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. merge columns
MDTt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDTt)
levels(MDTt$variable) = c("Philippine" , "Pacific", "Mariana", "Caroline")
Plates<- c("Philippine" , "Pacific", "Mariana", "Caroline")

# Part 2: draw ternary diagram for Mariana Trench
library(ggtern)
# step-3. variant-1. 4 tectonic plates
MDTer <- data.frame(
x = MDTt$igneous_volc,
y = MDTt$tectonics,
z = MDTt$slope_angle,
Value = MDTt$slope_angle,
Group = as.factor(MDTt$variable))
MT1<- ggtern(data= MDTer,aes(x,y,z,color = Group)) +
theme_rgbw() +
geom_point() +
#    geom_path() +
scale_color_manual(values = c("green" , "red", "orange", "blue")) +
labs(x="Igneous \nVolcanos",
y="Tectonics",
z="Slope \nAngle",
title="Mariana Trench",
subtitle="Ternary Diagram: Tectonic Plates") +
geom_Tline(Tintercept=.5,arrow=arrow(), colour='red') +
geom_Lline(Lintercept=.2, colour='magenta') +
geom_Rline(Rintercept=.1, colour='blue') +
geom_confidence_tern()
MT1
# step-4. variant-2. by morphology
levels(MDTt$morph_class) = c("Strong Slope", "Very Strong Slope", "Steep Slope", "Extreme Slope")
MDTM <- data.frame(
x = MDTt$Min,
y = MDTt$aspect_degree,
z = MDTt$slope_angle,
Value = MDTt$slope_angle,
Group = as.factor(MDTt$morph_class))
MT2<- ggtern(data= MDTM,aes(x,y,z,color=Group), show.legend=TRUE) +
theme_rgbw() +
geom_point() +
geom_path() +
labs(x="Max \nDepth",
y="Aspect Degree",
z="Slope\nAngle",
title="Mariana Trench",
subtitle="Ternary Diagram: Slope Morphology Class") +
geom_Tline(Tintercept=.5,arrow=arrow(), colour='red') +
geom_Lline(Lintercept=.2, colour='magenta') +
geom_Rline(Rintercept=.1, colour='blue') +
geom_confidence_tern() +
geom_Tisoprop(value=0.5) +
geom_Lisoprop(value=0.5) +
geom_Risoprop(value=0.5)
MT2
# step-5. variant-3 by slope aspect
MDTAs <- data.frame(
x = MDTt$slope_angle,
y = MDTt$aspect_degree,
z = MDTt$Min,
Value = MDTt$aspect_degree,
Group = as.factor(MDTt$aspect_class))
MT3<- ggtern(data = MDTAs,aes(x,y,z,color = Group)) +
theme_rgbw() +
geom_point() +
scale_color_manual(values = c("green", "red", "orange", "blue", "yellow" , "brown", "grey", "cyan")) +
labs(x="Slope \nAngle", size = 1,
y="Aspect \nDegree",
z="Max \nDepth",
title="Mariana Trench",
subtitle="Ternary Diagram: Aspect Class") +
geom_Tline(Tintercept=.5,arrow=arrow(), colour='red') +
geom_Lline(Lintercept=.2, colour='magenta') +
geom_Rline(Rintercept=.1, colour='blue') +
geom_confidence_tern() +
geom_Tisoprop(value=0.5) +
geom_Lisoprop(value=0.5) +
geom_Risoprop(value=0.5)
MT3
# step-6. plotting ternaries
plot<- grid.arrange(MT1, MT2, MT3, newpage = TRUE, nrow = 1, ncol = 3, top="Mariana Trench")
# step-7. variant-4. by sediment thickness layer
MD4 <- data.frame(
x = MDTt$igneous_volc,
y = MDTt$sedim_thick,
z = MDTt$slope_angle,
Value = MDTt$slope_angle)
MT4<- ggtern(data = MD4,aes(x,y,z), show.legend=TRUE) +
theme_rgbw() +
geom_point() +
#    geom_path(alpha = .5, lwd = 0.2) +
labs(x="Igneous \nVolcanos", size = 0.5,y="Sediment \nThickness",z="Slope \nAngle",
title="Mariana Trench",
subtitle="Ternary Diagram: Sediment Thickness") +
geom_Tline(Tintercept=.5,arrow=arrow(), colour='deeppink') +
geom_Lline(Lintercept=.2, colour='magenta') +
geom_Rline(Rintercept=.1, colour='springgreen') +
geom_confidence_tern() +
geom_smooth_tern(method = 'loess', size = .4, color = "yellow1") +
geom_mean_ellipse (size = .5, color = "cyan")
MT4
figure <-plot_grid(MT1, MT2, MT3, MT4, labels = c("1", "2", "3", "4"), ncol = 2, nrow = 2)
