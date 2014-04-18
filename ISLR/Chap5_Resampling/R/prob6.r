## Bootstrap coefficient errors

library(ISLR)
library(boot)

# Get standard param uncert estimates
log.fit <- glm(default ~ income + balance, data=Default, 
                 family=binomial)
coeff_unc.glm = summary(log.fit)$coefficients[,2]

cat("Standard uncertainty estimates: ", coeff_unc.glm, "\n")

# Now bootstrap
boot.fn = function(data, index) {
  log.fit <- glm(default ~ income + balance, data=data, 
                 family=binomial, subset=index)
  return(coef(log.fit))
}
boot.results <- boot(Default, boot.fn, R=100)
print(boot.results)


