library(ISLR)

cat("\nScatter plot of all relationships\n")
pairs(Auto)
readline("Press <Enter> to Continue")

cat("\nCorrelation of variables\n")
noname <- subset(Auto, select=-c(name))
cor(noname)

cat("\nMultiple linear regression on Autos\n")
lm.fit = lm(mpg ~ . - name, data=Auto)
print(summary(lm.fit))
par(mfrow=c(2, 2))
plot(lm.fit)
readline("Press <Enter> to Continue")

cat("\nTrying some interaction terms\n")
lm.fiti = lm(mpg ~ . - name + cylinders:horsepower + 
	cylinders:displacement + displacement:horsepower + 
	weight:displacement + year:cylinders + year:horsepower, data=Auto)
par(mfrow=c(2,2))
print(summary(lm.fiti))
readline("Press <Enter> to Continue")

