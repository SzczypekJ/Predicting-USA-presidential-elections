data {
  int<lower=0> N; // liczba obserwacji
  vector[N] HDI; // predyktor 1
  vector[N] G;  // predyktor 2 
  vector[N] U; // predyktor 3 (procent bezrobocia)
  vector[N] y; // wynik (procent głosów na demokratów)
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
  alpha ~ normal(47, 10);
  beta_HDI ~ normal(0, 1);
  beta_G ~ normal(0, 0.1);
  beta_U ~ normal(0, 0.1);
  sigma ~ normal(1, 0.5);

  // Likelihood
  y ~ normal(alpha + beta_HDI * HDI + beta_G * G + beta_U * U, sigma);
}

generated quantities {
  vector[N] log_lik;
  vector[N] y_rep;
  for (n in 1:N) {
    log_lik[n] = normal_lpdf(y[n] | alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n], sigma);
  }
}
