# Part-1. prepare data frame
# step-1. read in table with data. create initial data frame
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
head(MDF)
# step-2. Merge identical columns into a category
MDTt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDTt)
# Part-2. Compute ANOVA
# step-3. Compute one-way ANOVA test using function aov(): to know if there is any significant difference between the average values of angles in the 4 tectonic plates. The function summary.aov(): to summarize the analysis of variance model.
# step-4. Compute the analysis of variance
res.aov <- aov(tectonics ~ variable, data = MDTt)
summary(res.aov) # Summary of the analysis
#  Interpret the result of one-way ANOVA tests:  As the p-value is less than the significance level 0.05, we can conclude that there are significant differences between the groups highlighted with “*" in the model summary.
# step-5. Tukey multiple pairwise-comparisons. As the ANOVA test is significant, we can compute Tukey HSD (Tukey Honest Significant Differences, R function: TukeyHSD()) for performing multiple pairwise-comparison between the means of groups. The function TukeyHD() takes the fitted ANOVA as an argument.
TukeyHSD(res.aov)
# diff: difference between means of the two groups
# lwr, upr: the lower and the upper end point of the confidence interval at 95% (default)
# p adj: p-value after adjustment for the multiple comparisons.
# It can be seen from the output, that only the difference between plate Mariana and plate Pacific is significant (=24.12) with an adjusted p-value of 0.8601221.
# step-6. 2 variant via library(multcomp) Pairewise t-test. The function pairewise.t.test() can be also used to calculate pairwise comparisons between group levels with corrections for multiple testing:
pairwise.t.test(MDTt$tectonics, MDTt$variable, p.adjust.method = "BH")
# step-7. Plot Homogeneity of variances
plot(res.aov, 1)
# step-8. Bartlett’s test or Levene’s test to check the homogeneity of variances. Levene’s test is less sensitive to departures from normal distribution. The function leveneTest() [in car package] :
library(car)
leveneTest(tectonics ~ variable, data = MDTt)
# step-9. Welch one-way test. Welch one-way test does not require that assumption have been implemented in the function oneway.test(). ANOVA test with no assumption of equal variances
oneway.test(tectonics ~ variable, data = MDTt)
# step-10. Shapiro test
aov_residuals <- residuals(object = res.aov )
shapiro.test(x = aov_residuals )
# step-11. non-parametric alternative to one-way ANOVA is Kruskal-Wallis rank sum test,
kruskal.test(tectonics ~ variable, data = MDTt)
