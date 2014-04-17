library(ISLR)

cat("\nLogistic Prediction Model fit to full data\n")
log.fit = glm(Direction~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
	      data=Weekly, family=binomial)
log.prob <- predict(log.fit, type="response")
log.pred <- rep("Down", 1089)
log.pred[log.prob >= 0.50] = "Up"
print(table(log.pred, Weekly$Direction))
print(mean(log.pred == Weekly$Direction))
readline("Press <Enter> to Continue")

cat("\nCross validating Logistic Regression using 2009, 2010\n")
train <- (Weekly$Year < 2009)
Weekly.train <- Weekly[train,]
Weekly.test <- Weekly[!train,]
ntrain <- sum(train)
nfit <- sum(!train) 
log.fit = glm(Direction~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
	      data=Weekly, family=binomial, subset=train)
log.prob <- predict(log.fit, Weekly.test, type="response")
log.pred = rep("Down", nfit)
log.pred[log.prob >= 0.50] = "Up"
print(table(log.pred, Weekly.test$Direction))
print(mean(log.pred == Weekly.test$Direction))
readline("Press <Enter> to Continue")

cat("\nCross validating LDA using 2009, 2010\n")
library(MASS)
lda.fit = lda(Direction~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
	      data=Weekly, family=binomial, subset=train)
lda.pred <- predict(lda.fit, Weekly.test)
table(lda.pred$class, Weekly.test$Direction)
print(mean(lda.pred$class == Weekly.test$Direction))
readline("Press <Enter> to Continue")

cat("\nCross validating QDA using 2009, 2010\n")
qda.fit = qda(Direction~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
	      data=Weekly, family=binomial, subset=train)
qda.pred <- predict(qda.fit, Weekly.test)
table(qda.pred$class, Weekly.test$Direction)
print(mean(qda.pred$class == Weekly.test$Direction))
readline("Press <Enter> to Continue")

cat("\nCross validating KNN (=1) using 2009, 2010\n")
library(class)
train.X = cbind(Weekly$Lag1, Weekly$Lag2, Weekly$Lag3, Weekly$Lag4,
	        Weekly$Lag5, Weekly$Volume)[train,]
train.Y = Weekly$Direction[train]
test.X = cbind(Weekly$Lag1, Weekly$Lag2, Weekly$Lag3, Weekly$Lag4,
	        Weekly$Lag5, Weekly$Volume)[!train,]
set.seed(12)
knn.pred = knn(train.X, test.X, train.Y, k=1)
print(table(knn.pred, Weekly.test$Direction))
print(mean(knn.pred == Weekly.test$Direction))
readline("Press <Enter> to Continue")

cat("\nCross validating KNN (=5) using 2009, 2010\n")
set.seed(12)
knn.pred = knn(train.X, test.X, train.Y, k=5)
print(table(knn.pred, Weekly.test$Direction))
print(mean(knn.pred == Weekly.test$Direction))
