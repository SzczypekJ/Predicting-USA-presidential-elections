data {
  int<lower=0> N;
  vector[N] HDI;
  vector[N] G;
  vector[N] U;
  vector[N] V;
}
parameters {
  real alpha;
  real beta_HDI;
  real beta_HDI2;
  real beta_G;
  real beta_G2;
  real beta_U;
  real beta_U2;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(47, 10);
  beta_HDI ~ normal(0, 1);
  beta_HDI2 ~ normal(0, 0.1);
  beta_G ~ normal(0, 0.01);
  beta_G2 ~ normal(0, 0.001);
  beta_U ~ normal(0, 0.01);
  beta_U2 ~ normal(0, 0.001);
  sigma ~ normal(1, 0.5);
  V ~ normal(alpha + beta_HDI * HDI + beta_HDI2 * square(HDI) + beta_G * G + beta_G2 * square(G) + beta_U * U + beta_U2 * square(U), sigma);
}
generated quantities {
  vector[N] log_lik;
  vector[N] y_rep;
  for (n in 1:N) {
    log_lik[n] = normal_lpdf(V[n] | alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]) + beta_G * G[n] + beta_G2 * square(G[n]) + beta_U * U[n] + beta_U2 * square(U[n]), sigma);
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]) + beta_G * G[n] + beta_G2 * square(G[n]) + beta_U * U[n] + beta_U2 * square(U[n]), sigma);
  }
}
