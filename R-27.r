# Part-1. prepare data frame
# step-1. read in table with data. create initial data frame
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
Ml <- na.omit(MDepths)
row.has.na <- apply(Ml, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(Ml)
# step-2. merge columns by categories
MDTt = melt(setDT(Ml), measure = patterns("^profile"), value.name = c("depth"))
head(MDTt)

# Part-2. hexbin
# 1 variant, via library(hexbin)
x = as.factor(MDTt$variable)
y = MDTt$depth
hexbinplot(y ~ x, MDTt, aspect = 1,
trans = sqrt, inv = function(x) x^2)
x = MDF$profile
y = MDF$Min
hexbinplot(y ~ x, MDF, aspect = 1,
trans = sqrt, inv = function(x) x^2)
# 2 variant via function (plot bin)
bin <- hexbin(x, y)
plot(bin, style = "nested.lattice")
plot(bin, style = "nested.lattice")
# statistics on hex bin plot
hbi <- hexbin(y ~ x, xbins = 80, IDs= TRUE)
str(hbi)
tI <- table(hbi@cID)
stopifnot(names(tI) == hbi@cell,
tI  == hbi@count)
