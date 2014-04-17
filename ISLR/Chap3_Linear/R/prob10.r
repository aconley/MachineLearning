library(ISLR)

cat("\nRegress Sales onto Price, Urban, and US\n")
lm.fit = lm(Sales ~ Price + Urban + US, data=Carseats)
print(summary(lm.fit))
par(mfrow=c(2, 2))
plot(lm.fit)
readline("Press <Enter> to Continue")

cat("\nRemoving unimportant Urban variable\n")
lm.fit_noU = lm(Sales ~ Price + US, data=Carseats)
print(summary(lm.fit_noU))
par(mfrow=c(2, 2))
plot(lm.fit_noU)
cat("\nParameter confidence intervals\n")
print(confint(lm.fit_noU))
readline("Press <Enter> to Continue")

