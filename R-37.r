# step-1 load table with data. create data frame
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. variant-1: aspect class.
var <- MDF$aspect_class  # This is a categorical data. Here: 8 aspect classes
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows) # set up square 10*10
categ_table <- round(table(var) * ((nrows*nrows)/(length(var)))) # set up table with categorial values
categ_table
df$category <- factor(rep(names(categ_table), categ_table)) # names to be shown in a legend
# note: if sum(categ_table) is not 100 (i.e. nrows^2), it will need adjustment to make the sum to 100.
# step-3. Plot 'waffle' diagram
wa<- ggplot(df, aes(x = x, y = y, fill = category)) +
geom_tile(color = "black", size = 0.5) +
scale_x_continuous(expand = c(0, 0)) +
scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
scale_fill_brewer(palette = "Set3") +
labs(title="Waffle Chart: Mariana Trench", subtitle="Aspect class of the basement angle",
caption="Graphics: R Programming")  +
theme( plot.title = element_text(size = rel(1.2)),
axis.text = element_blank(),
axis.title = element_blank(),
axis.ticks = element_blank(),
legend.title = element_blank(),
legend.position = "right")
wa
# step-4. variant-2: slope steepness class. create table and load data.
var <- MDF$morph_class  #  the categorical data: slope steepness class
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows) # задаем квадрат 10*10
categ_table <- round(table(var) * ((nrows*nrows)/(length(var)))) # set up table with categorial values
categ_table
df$category <- factor(rep(names(categ_table), categ_table)) # names to be shown in a legend
# step-5. Plot waffle diagram by steepness
ws<- ggplot(df, aes(x = x, y = y, fill = category)) +
geom_tile(color = "black", size = 0.5) +
scale_x_continuous(expand = c(0, 0)) +
scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
scale_fill_brewer(palette = "Set3") +
labs(title="Waffle Chart: Mariana Trench", subtitle="Steepness angle class of the profiles 1:25",
caption="Graphics: R Programming")  +
theme( plot.title = element_text(size = rel(1.2)),
axis.text = element_blank(),
axis.title = element_blank(),
axis.ticks = element_blank(),
legend.title = element_blank(),
legend.position = "right")
ws
#step-6. combine both waffles on one plot
figure <-plot_grid(wa, ws, labels = c("1", "2"), ncol = 2, nrow = 1)
figure
