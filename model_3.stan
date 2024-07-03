data {
  int<lower=0> N;
  vector[N] HDI;
  vector[N] G;
  vector[N] U;
  vector[N] y;
}
parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real beta_U;
  real<lower=0> sigma;
}
model {
  y ~ normal(alpha + beta_HDI * HDI + beta_G * G + beta_U * U, sigma);
}
generated quantities {
  vector[N] log_lik;
  for (n in 1:N) {
    log_lik[n] = normal_lpdf(y[n] | alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
  }
}
