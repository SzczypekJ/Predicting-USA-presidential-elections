data {
  int<lower=0> N; // number of observations
  int<lower=0> K; // number of predictors
  int<lower=0> J; // number of unique states
  int<lower=1, upper=J> state[N]; // state index
  matrix[N, K] X; // predictor matrix
  vector[N] y; // outcome (Democratic %)
}

parameters {
  real alpha; // overall intercept
  vector[K] beta; // overall coefficients
  real<lower=0> sigma; // standard deviation
  vector[J] alpha_state; // state-specific intercepts
  matrix[J, K] beta_state; // state-specific coefficients
  real<lower=0> sigma_alpha; // standard deviation for state intercepts
  real<lower=0> sigma_beta; // standard deviation for state coefficients
}

model {
  // Priors
  alpha ~ normal(45, 20); // Prior for overall intercept
  beta ~ normal(0, 5); // Priors for overall coefficients
  sigma ~ normal(5, 2); // Prior for overall standard deviation

  alpha_state ~ normal(0, sigma_alpha); // Prior for state-specific intercepts
  for (j in 1:J)
    beta_state[j] ~ normal(0, sigma_beta); // Prior for state-specific coefficients
  
  // Likelihood
  for (n in 1:N)
    y[n] ~ normal(alpha + alpha_state[state[n]] + X[n] * (beta + beta_state[state[n]]), sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + alpha_state[state[n]] + X[n] * (beta + beta_state[state[n]]), sigma);
}
