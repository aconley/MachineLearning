library(ISLR)

cat("\nFit linear relation between mpg and horsepower\n")
lm.fit = lm(mpg ~ horsepower, data=Auto)
print(summary(lm.fit))

plot(Auto$horsepower, Auto$mpg, xlab="Horsepower", ylab="MPG")
abline(lm.fit)
readline("Press <Enter> to Continue")

cat("\nShowing fit diagnostic plots\n")
par(mfrow=c(2, 2))
plot(lm.fit)
readline("Press <Enter> to Continue")