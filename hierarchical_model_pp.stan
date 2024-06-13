data {
  int<lower=0> N;
  int<lower=1> J;
  int<lower=1,upper=J> state[N];
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
  vector[J] alpha_state;
  real<lower=0> sigma_state;
}

model {
  alpha ~ normal(50, 10);
  beta_HDI ~ normal(0, 0.5);
  beta_G ~ normal(0, 0.5);
  beta_U ~ normal(0, 0.5);
  sigma ~ normal(5, 1);
  alpha_state ~ normal(0, sigma_state);
  sigma_state ~ normal(0, 5);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + alpha_state[state[n]] + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
}
