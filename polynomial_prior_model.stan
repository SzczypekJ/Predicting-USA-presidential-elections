data {
  int<lower=0> N; // liczba obserwacji
  vector[N] HDI; // predyktor 1
  vector[N] G; // predyktor 2 (procent posiadania broni)
  vector[N] U; // predyktor 3 (procent bezrobocia)
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_HDI2;
  real beta_HDI3;
  real beta_G;
  real beta_G2;
  real beta_G3;
  real beta_U;
  real beta_U2;
  real beta_U3;
  real<lower=0> sigma;
}

model {
  // Priors
  alpha ~ normal(47, 10); 
  beta_HDI ~ normal(0, 1);
  beta_HDI2 ~ normal(0, 0.2);
  beta_HDI3 ~ normal(0, 0.02);
  beta_G ~ normal(0, 0.002);
  beta_G2 ~ normal(0, 0.0002);
  beta_G3 ~ normal(0, 0.00002);
  beta_U ~ normal(0, 0.002);
  beta_U2 ~ normal(0, 0.0002);
  beta_U3 ~ normal(0, 0.00002);
  sigma ~ normal(1, 0.5);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]) + beta_HDI3 * pow(HDI[n], 3) +
                          beta_G * G[n] + beta_G2 * square(G[n]) + beta_G3 * pow(G[n], 3) +
                          beta_U * U[n] + beta_U2 * square(U[n]) + beta_U3 * pow(U[n], 3), sigma);
}
