# Load required libraries
library(rstan)
library(parallel)

num_cores <- parallel::detectCores()
print(num_cores)
options(mc.cores = num_cores)
# Data
x <- c(1, 2, 3, 4, 5)  # Predictor variable
y <- c(3, 5, 7, 9, 11)  # Response variable
N <- length(x)          # Number of observations

# Stan model
stan_code <- "
data {
  int<lower=0> N;          // Number of observations
  vector[N] x;             // Predictor variable
  vector[N] y;             // Response variable
}
parameters {
  real alpha;              // Intercept
  real beta;               // Slope
  real<lower=0> sigma;     // Error standard deviation
}
model {
  // Priors
  alpha ~ normal(0, 10);   // Normal prior for intercept
  beta ~ normal(0, 10);    // Normal prior for slope
  sigma ~ exponential(1);  // Exponential prior for error standard deviation

  // Likelihood
  y ~ normal(alpha + beta * x, sigma);  // Gaussian likelihood
}
"

# Compile Stan model
ptm <- proc.time()
model <- stan_model(model_code = stan_code, verbose=FALSE)
elapsed_time <- proc.time() - ptm
cat("Build time:", elapsed_time, "\n")
# Prepare data list
data_list <- list(N = N, x = x, y = y)

# Fit the model
ptm <- proc.time()
fit <- sampling(model, data = data_list, iter = 2000, warmup = 1000, chains = 8)
elapsed_time <- proc.time() - ptm
cat("Run time:", elapsed_time, "\n")
# Print summary
print(fit)
