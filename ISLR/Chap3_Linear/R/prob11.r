set.seed(1)
x = rnorm(100)
y = 2 * x + rnorm(100)

cat("\nRegress y onto x with no intercept\n\n")
lm.fit_noint = lm(y ~ x+0)
print(summary(lm.fit_noint))
readline("Press <Enter> to Continue")

cat("\nRegress x onto y with no intercept\n\n")
lm.fit_noint_rev = lm(x ~ y+0)
print(summary(lm.fit_noint_rev))
readline("Press <Enter> to Continue")

par(mfrow=c(1,2))
plot(x, y, xlab="x", ylab="y")
abline(lm.fit_noint)
plot(y, x, xlab="y", ylab="x")
abline(lm.fit_noint_rev)
readline("Press <Enter> to Continue")



