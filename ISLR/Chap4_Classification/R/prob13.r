library(ISLR)
library(class)
library(MASS)

medcrim <- median(Boston$crim)
nsub <- length(Boston$crim)
hicrim <- rep(0, nsub)
hicrim[Boston$crim > medcrim] = 1

ntrain <- round(nsub * 2 / 3)
ntest <- nsub - ntrain
train <- sort(sample(1:nsub, ntrain))
test <- (1:nsub)[-train]
Boston.train <- Boston[train,]
Boston.test <- Boston[test,]
hicrim.train <- hicrim[train]
hicrim.test <- hicrim[test]


cat("\nLogistic Prediction Model\n")
log.fit <- glm(hicrim.train ~ nox + age + rad + medv, data=Boston.train)
log.prob <- predict(log.fit, Boston.test, type="response")
log.pred <- rep(0, ntest)
log.pred[log.prob >= 0.50] = 1
print(table(log.pred, hicrim.test))
print(mean(log.pred == hicrim.test))
readline("Press <Enter> to Continue")

cat("\nLDA\n")
lda.fit <- lda(hicrim.train ~ zn + indus + chas + nox + rm + age + dis
	+ rad + tax + ptratio + black + lstat + medv, data=Boston.train)
lda.pred <- predict(lda.fit, Boston.test)
print(table(lda.pred$class, hicrim.test))
print(mean(lda.pred$class == hicrim.test))
readline("Press <Enter> to Continue")

cat("\nQDA\n")
qda.fit <- qda(hicrim.train ~ zn + indus + chas + nox + rm + age + dis
	+ rad + tax + ptratio + black + lstat + medv, data=Boston.train)
qda.pred <- predict(qda.fit, Boston.test)
print(table(qda.pred$class, hicrim.test))
print(mean(qda.pred$class == hicrim.test))
readline("Press <Enter> to Continue")
