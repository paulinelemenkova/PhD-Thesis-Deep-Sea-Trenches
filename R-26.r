# libraries: 'psych' (MAIN), 'factoextra', 'FactoMiner' ‘zip’, ‘openxlsx’, ‘carData’, ‘pbkrtest’, ‘rio’, ‘car’, ‘flashClust’, ‘leaps’, ‘scatterplot3d’, ‘FactoMineR’, ‘ca’, ‘igraph’
# Part 1 create data frame
# step-1. read in table, create data frame.
MDepths <- read.csv("MorphologyFA.csv", header=TRUE, sep = ",")
MDF<- na.omit(MDepths)
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na)
# Part 2 Exploratory Factor Analysis (EFA)
# step-2. Create Correlation Matrix
corMat <- cor(MDF)
corMat
# step-3. Factor Analysis (method: Principal Axis)
faM <- fa(corMat, nfactors = 2, rotate = "oblimin", scores = "regression", residuals = FALSE, SMC=TRUE, covar=FALSE, missing = FALSE,impute = "median", min.err = 0.001,  max.iter = 50,symmetric = TRUE, warnings = TRUE, fm = "pa", alpha = .1, p = .05, oblique.scores = FALSE, np.obs = NULL,  use = "pairwise", cor = "cor",  correct = .5, weight = NULL)
print(faM,sort=TRUE) # print the results from a factor analysis
plot(faM) # plot the loadings from a factor analysis
fa.plot(faM) # plot the loadings from a factor, principal components, or cluster analysis
# step-4. Parallel Factor Analysis compares the observed eigen values of a correlation matrix with those from random data
fa.parallel(corMat)
# step-5. Weighted Least Squares Factor Analysis
faWls <- step(corMat, nfactors = 2, rotate = "oblimin", scores = "regression", residuals = FALSE, SMC=TRUE, covar=FALSE, missing = FALSE,impute = "median", min.err = 0.001,  max.iter = 50,symmetric = TRUE, warnings = TRUE, fm = "wls", alpha = .1, p = .05, oblique.scores = FALSE, np.obs = NULL,  use = "pairwise", cor = "cor",  correct = .5, weight = NULL)
print(faWls,sort=TRUE) # print the results from a factor analysis
plot(faWls)
# step-6. Item Cluster Analysis: iclust
iclust(corMat)
ic <- iclust(corMat)
summary(ic)
# step-7. Hierarchical and bi-factor solutions using the omega function
om.h <- omega(corMat, n.obs=25, sl=FALSE)
om <- omega(corMat, n.obs=25)
# step-8. Alpha Factor Analysis
faMal <- fa(corMat, nfactors = 2, rotate = "oblimin", scores = "regression", residuals = FALSE, SMC=TRUE, covar=FALSE, missing = FALSE,impute = "median", min.err = 0.001,  max.iter = 50,symmetric = TRUE, warnings = TRUE, fm = "alpha", alpha = .1, p = .05, oblique.scores = FALSE, np.obs = NULL,  use = "pairwise", cor = "cor",  correct = .5, weight = NULL)
print(faM,sort=TRUE) # print the results from a factor analysis
plot(faMal)
