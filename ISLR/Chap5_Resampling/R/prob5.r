library(ISLR)

nsamp <- length(Default$default)
ntrain <- nsamp / 2
ntest <- nsamp - ntrain
train <- sample(nsamp, ntrain)

## Fit on training set, test on sample
##   Write as a function
valid.err = function(data) {
  nsamp <- length(data$default)
  ntrain <- nsamp / 2
  ntest <- nsamp - ntrain
  train <- sample(nsamp, ntrain)
  log.fit <- glm(default ~ income + balance, data=data, 
                 family=binomial, subset=train)
  log.prob <- predict(log.fit, data[-train,], type="response")
  log.pred <- rep("No", ntest)
  log.pred[log.prob >= 0.5] = "Yes"
  test.err <- mean(log.pred != data[-train,]$default)
  return(test.err)
}

cat("\nLogistic fit on default using income and balance\n")
cat("Repeating 20 times\n")
err.value = rep(0.0, 20)
for (i in 1:20) {
  err.value[i] = valid.err(Default)
}
cat("Individual values: ", err.value, "\n")
cat("Mean training err: ", mean(err.value), " SD: ", sd(err.value), "\n")

#####################################
cat("\nLogistic fit on default using income and balance and student\n")
valid.err_wstudent = function(data) {
  nsamp <- length(data$default)
  ntrain <- nsamp / 2
  ntest <- nsamp - ntrain
  train <- sample(nsamp, ntrain)
  log.fit <- glm(default ~ income + balance + student, data=data, 
                 family=binomial, subset=train)
  log.prob <- predict(log.fit, data[-train,], type="response")
  log.pred <- rep("No", ntest)
  log.pred[log.prob >= 0.5] = "Yes"
  test.err <- mean(log.pred != data[-train,]$default)
  return(test.err)
}
for (i in 1:20) {
  err.value[i] = valid.err(Default)
}
cat("Individual values: ", err.value, "\n")
cat("Mean training err: ", mean(err.value), " SD: ", sd(err.value), "\n")

