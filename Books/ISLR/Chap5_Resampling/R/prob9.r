# Bootstrapping on Boston
library(MASS)
library(boot)

# Get estimate of population mean of medv
mu_hat <- mean(Boston$medv)
se_muhat <- sd(Boston$medv) / sqrt(dim(Boston)[1])
cat("Medv population mean: ", mu_hat, " +- ",se_muhat,"\n")

# Now bootstrap
medv.mn = function(data, index) {return(mean(data$medv[index]))}
bootres <- boot(Boston, medv.mn, R=1000)
boot_se_muhat <- sd(bootres$t)
qs <- quantile(bootres$t, probs=c(0.025, 0.975))
cat(" Bootstrap se ", boot_se_muhat,"\n")
cat(" Bootstrap 95% interval ", qs[1]," - ", qs[2],"\n")

# Do the same thing for the median; ignoring the problem,
#  compute the 95% conf interval rather than the standard error
mu_med <- median(Boston$medv)
medv.med = function(data, index) {return(median(data$medv[index]))}
bootres_med <- boot(Boston, medv.med, R=1000)
qs.med <- quantile(bootres_med$t, probs=c(0.025, 0.975))
cat("Medv median: ",mu_med,"\n")
cat(" Bootstrap 95% interval ", qs.med[1]," - ", qs.med[2],"\n")

# Now estimate the 10% medv
mu_ten = quantile(Boston$medv, probs=0.1)
medv.ten = function(data, index) {return(quantile(data$medv[index], probs=0.1))}
bootres_ten = boot(Boston, medv.ten, R=1000)
qs.ten <- quantile(bootres_ten$t, probs=c(0.025, 0.975))
cat("Medv 10%: ",mu_ten,"\n")
cat(" Bootstrap 95% interval ", qs.ten[1]," - ", qs.ten[2],"\n")

