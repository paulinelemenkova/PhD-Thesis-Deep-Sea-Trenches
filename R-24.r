# Part-1. prepare data frame
# step-1. read-in table with data. create initial data frame. clean data frame from the NA values
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
Ml <- na.omit(MDepths)
row.has.na <- apply(Ml, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(Ml)
# step-2. merge several columns into one using (melt) function
MDTt = melt(setDT(Ml), measure = patterns("^profile"), value.name = c("depth"))
head(MDTt)

# Part-2. create animation: how the bathymetric depths change by profiles 1:25.
# step-3
theme_set(theme_bw())  # pre-set the bw theme.
Observations<- MDTt$observ
Depth<- MDTt$depth
Profiles<- MDTt$variable
# step-4: 1 variant - single-color, by one method
g <- ggplot(MDTt, aes(x = Observations, y = Depth, frame = Profiles)) +
geom_point() +
geom_smooth(aes(group = Profiles), method = "loess", show.legend = TRUE)
gganimate(g, "Animation-blue-1-method.gif", interval=1.0)
# step-5: 2 variant - four colors, with 4 methods
g <- ggplot(MDTt, aes(x = Observations, y = Depth, frame = Profiles, color = "Observation points")) +
geom_point() +
geom_smooth(aes(group = Profiles, x = Observations, y = Depth, colour = "Loess method"), method = loess, se = TRUE, span = .4, size=.2, linetype = "solid", show.legend =  TRUE) +
geom_smooth(aes(group = Profiles, x = Observations, y = Depth, colour = "Glm method"), method = glm, se = TRUE, span = .4, size=.2, linetype = "dotted", show.legend = TRUE) +
geom_smooth(aes(group = Profiles, x = Observations, y = Depth, colour = "Lm method"), method = lm, se = TRUE, size=.2, linetype = "solid", show.legend = TRUE) +
geom_quantile(aes(group = Profiles, x = Observations, y = Depth, colour = "Quantiles"), size=.2, linetype = "solid", show.legend = TRUE) +
scale_color_manual(name = "Regression Analysis \nLegend:", values = c("Observation points" = "seagreen", "Loess method" = "red", "Glm method" = "orange", "Lm method" = "blue", "Quantiles" = "purple"))
# step-5: now run animation
gganimate(g, "Animation-color-4-methods.gif", interval=1.0)
