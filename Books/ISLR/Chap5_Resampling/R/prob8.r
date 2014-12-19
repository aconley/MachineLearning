# Cross validation on simulated data
library(boot)

x <- rnorm(100)
y <- x - 2 * x^2 + rnorm(100)
simdata <- data.frame(x=x, y=y)

npoly <- 5
for (i in 1:npoly) {
  glm.fit <- glm(y ~ poly(x, i), data=simdata)
  cv.err = cv.glm(simdata, glm.fit)$delta[1]
  cat("Cross validation error for order: ",i," is: ", cv.err, "\n")
}
