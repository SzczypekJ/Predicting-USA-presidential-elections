data {
  int<lower=0> N; // number of observations
  vector[N] HDI; // predictor 1 (HDI)
  vector[N] G; // predictor 2 (Gun ownership %)
  vector[N] U; // predictor 3 (Unemployment %)
  vector[N] y; // outcome variable
}

parameters {
  real alpha; // intercept
  real beta_HDI; // coefficient for HDI
  real beta_G; // coefficient for Gun ownership %
  real beta_U; // coefficient for Unemployment %
  real<lower=0> sigma; // standard deviation of the error term
}

model {
  // Priors
  alpha ~ normal(47, 10); // Prior for intercept centered at mean Democratic %
  beta_HDI ~ normal(0, 1); // Prior for HDI coefficient
  beta_G ~ normal(0, 0.01); // Prior for Gun Ownership coefficient
  beta_U ~ normal(0, 0.01); // Prior for Unemployment coefficient
  sigma ~ normal(1, 0.5); // Prior for standard deviation

  // Likelihood
  y ~ normal(alpha + beta_HDI * HDI + beta_G * G + beta_U * U, sigma);
}

generated quantities {
  vector[N] y_rep; // replicated data for posterior predictive checks
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
}
