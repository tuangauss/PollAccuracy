# prototype
state = "California"
path = paste("C://Users/hp/Desktop/personal study/data science/projects/poll_by_state/", state, ".csv", sep = "")
data = read.csv(path, header=T)

## we only need 2 columns, samplesize(N) and Trump_voters(X)
smalldata <- data[,c("samplesize","Trump_voters")]
smalldata


### the question is, find the posterior distribution of p given value of X

log_lik = function(th){
  result = 0
  for (i in 1:nrow(smalldata)){
    n <- smalldata[i,"samplesize"]
    x <- smalldata[i,"Trump_voters"]
    result = result + dbinom(x,n,th,log=TRUE)
    return (result)
  }
}

### use beta distribution for prior
log_prior = function (th){
  ### use parameter of beta as .5 and .5 to gives more weight at p =.5
  log(dbeta(th, .5 , .5))  
}

post = function (th){
  log_prior(th)+log_lik(th)
}

### perform Metropolis Hasting
nit = 100000
results = matrix(0,nrow = nit, ncol = 1)

# we start at the mean of the probability of all the polls
th = mean(data[,"rawpoll_trump"])/100
results [1,1] = .5
for (it in 2:nit){
  # proose a candidae by add a sample from a Gaussian distribution
  cand = th + rnorm(1,0,.001)
  if (0<cand && cand <1){
    ratio = 10^(post(cand)/post(th))
    if (runif(1,0,1)<ratio){
      th = cand
    }    
  }
  results [it,] = th
}

p = results[,1]
hist(p)