set.seed(3)
x = rnorm(100)
eps = 0.25 * rnorm(100)
y = -1 + 0.5 * x + eps

lm.fit = lm(y ~ x)
lm.fit_quad = lm(y ~ x + I(x^2))

plot(x, y)
abline(lm.fit, col='blue', lty=1)
abline(-1, 0.5, col='red', lty=2)
xx <- seq(-3, 3, length.out=100)
lines(xx, predict(lm.fit_quad, data.frame(x=xx)), lty=3, col='green')
txt <- c("Least Squares Linear", "Least Squares Quadratic", "Population")
legend(-2.0, 0, lty=c(1, 3, 2), txt, col=c("blue", "green", "red"))
