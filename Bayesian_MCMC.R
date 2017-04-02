bigdata = read.csv("/election_data/electoral_votes.csv", header=T)

State<- bigdata[,"State"]
Trump <- numeric (length(State))
for (i in 1:length(State)){
  state = State[i]
  ## create paths to csv files by concatenatings strings
  path = paste("poll_by_state/", state, ".csv", sep = "")
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
  
  # log posterior is proportional to the sum of log_prior and log_lik
  post = function (th){
    log_prior(th)+log_lik(th)
  }
  
  ### perform Metropolis Hasting
  nit = 100000
  results = matrix(0,nrow = nit, ncol = 1)
  
  ## start at the mean of probability from all polls "th"
  ## th is registered as the first result
  th = mean(data[,"rawpoll_trump"])/100
  results [1,1] = th
  for (it in 2:nit){
    # proose a candidae by add a sample from a Gaussian distribution
    cand = th + rnorm(1,0,.001)
    if (0<cand && cand <1){
      # since we take the log-likelihood, we need to take exponential back
      ratio = exp(post(cand)/post(th))
      if (runif(1,0,1)<ratio){
        th = cand
      }    
    }
    results [it,] = th
  }
  ## we collect the mean of all iterations
  p = results[,1]
  Trump [i] = mean(p)
  ## the process is long, printing the progress to keep yourself entertained
  message = paste ("Done ", State[i], "," , length (State) -i , " states to go", sep = "")
  print (message)
}

# write the probabilities into a csv file, ready to use by Python
df = data.frame(State, Trump)
write.csv(df,"election_data/bayesian_data.csv")
