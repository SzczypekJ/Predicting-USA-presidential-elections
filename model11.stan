data {
  int<lower=0> N;
  vector[N] HDI;
  vector[N] V;
}
parameters {
  real alpha;
  real beta_HDI;
  real beta_HDI2;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(47, 10);
  beta_HDI ~ normal(0, 1);
  beta_HDI2 ~ normal(0, 0.1);
  sigma ~ normal(1, 0.5);
  V ~ normal(alpha + beta_HDI * HDI + beta_HDI2 * square(HDI), sigma);
}
generated quantities {
  vector[N] log_lik;
  vector[N] y_rep;
  for (n in 1:N) {
    log_lik[n] = normal_lpdf(V[n] | alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]), sigma);
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]), sigma);
  }
}
