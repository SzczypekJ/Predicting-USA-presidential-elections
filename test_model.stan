data {
  int<lower=0> N; // number of observations
  vector[N] HDI; // predictor 1
  vector[N] G; // predictor 2 (Gun ownership %)
  vector[N] U; // predictor 3 (Unemployment %)
  vector[N] V; // outcome (Democratic %)
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real beta_U;
  real<lower=0> sigma;
}

model {
  alpha ~ normal(45, 20); // Prior for intercept
  beta_HDI ~ normal(0, 5); // Prior for HDI coefficient
  beta_G ~ normal(0, 5); // Prior for Gun Ownership coefficient
  sigma ~ normal(5, 2); // Prior for standard deviation

  // Likelihood
  V ~ normal(alpha + beta_HDI * HDI + beta_G * G + beta_U * U, sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N) {
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
  }
}
