data {
  int<lower=0> N; // number of observations
  vector[N] HDI; // predictor 1
  vector[N] G; // predictor 2 (Gun ownership %)
  vector[N] V; // outcome (Democratic %)
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real<lower=0> sigma;
}

model {
  alpha ~ normal(45, 10); // Prior for intercept
  beta_HDI ~ normal(0, 0.5); // Prior for HDI coefficient
  beta_G ~ normal(0, 0.5); // Prior for Gun Ownership coefficient
  sigma ~ normal(5, 1); // Prior for standard deviation

  // Likelihood
  V ~ normal(alpha + beta_HDI * HDI + beta_G * G, sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n], sigma);
}
