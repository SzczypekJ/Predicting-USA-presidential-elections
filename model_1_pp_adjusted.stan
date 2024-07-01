
data {
  int<lower=0> N; // number of observations
  vector[N] HDI; // predictor 1 (HDI)
  vector[N] G; // predictor 2 (Gun ownership %)
  vector[N] U; // predictor 3 (Unemployment %)
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real beta_U;
  real<lower=0> sigma;
}

model {
  // Priors
  alpha ~ normal(0.47, 0.05); // Prior for intercept centered at mean Democratic %
  beta_HDI ~ normal(0.9, 0.015); // Prior for HDI coefficient
  beta_G ~ normal(0.4, 0.02); // Prior for Gun Ownership coefficient
  beta_U ~ normal(0.06, 0.005); // Prior for Unemployment coefficient
  sigma ~ normal(0.07, 0.005); // Prior for standard deviation
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
}
