data {
  int<lower=0> N;
  vector[N] HDI;
  vector[N] G;
  vector[N] U;
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real beta_U;
  real<lower=0> sigma;
}

model {
  alpha ~ normal(45, 10);
  beta_HDI ~ normal(0, 0.3);
  beta_G ~ normal(0, 0.3);
  beta_U ~ normal(0, 0.3);
  sigma ~ normal(5, 0.7);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
}
