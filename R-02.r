# BoxPlot (or WhiskerPlot)
# Part 1: create data.frame
# step-1. read-in table. generate data frame.
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
# step-2. clean up data frame from NA values
MDepths <- na.omit(MDepths) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) # check up deleted NA
sum(row.has.na) # sum up NA values: [1] 0
head(MDepths) # look up cleaned data frame.

# Part 2: create "whisker boxplot"
# step-3. generate list of profiles (to be shon on axis X)
profile_names <- paste(c("profile"), seq(1:25), sep="") 
# step-4. generate box plot using arguments (here: 25 profiles)
p<- boxplot(MDepths$profile1, MDepths$profile2, MDepths$profile3, MDepths$profile4, MDepths$profile5, MDepths$profile6,MDepths$profile7, MDepths$profile8, MDepths$profile9, MDepths$profile10, MDepths$profile11, MDepths$profile12, MDepths$profile13, MDepths$profile14, MDepths$profile15, MDepths$profile16, MDepths$profile17, MDepths$profile18, MDepths$profile19, MDepths$profile20, MDepths$profile21, MDepths$profile22, MDepths$profile23, MDepths$profile24, MDepths$profile25,     
	main = "Mariana Trench Depths Boxplot", 
	outline = TRUE,
	outlier.color = "seagreen", outlier.shape = 8, outlier.size = 2,    
#	xlab = "Profiles",         
	ylab = "Depths",         
	las = 2,         
	col = viridis(25, alpha=.2),         
	names = profile_names)
p
