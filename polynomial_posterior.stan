data {
  int<lower=0> N; // liczba obserwacji
  vector[N] HDI; // predyktor 1
  vector[N] G;  // predyktor 2 
  vector[N] U; // predyktor 3 (procent bezrobocia)
  vector[N] V; // wynik (procent głosów na demokratów)
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
  // Priors
  alpha ~ normal(47, 10);
  beta_HDI ~ normal(0, 1);
  beta_HDI2 ~ normal(0, 0.1);
  beta_G ~ normal(0, 0.01);   // Zmniejszone odchylenie standardowe dla beta_G
  beta_G2 ~ normal(0, 0.001); // Zmniejszone odchylenie standardowe dla beta_G2
  beta_U ~ normal(0, 0.01);   // Zmniejszone odchylenie standardowe dla beta_U
  beta_U2 ~ normal(0, 0.001); // Zmniejszone odchylenie standardowe dla beta_U2
  sigma ~ normal(1, 0.5);

  // Likelihood
  V ~ normal(alpha + beta_HDI * HDI + beta_HDI2 * square(HDI) +
             beta_G * G + beta_G2 * square(G) +
             beta_U * U + beta_U2 * square(U), sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]) +
                          beta_G * G[n] + beta_G2 * square(G[n]) +
                          beta_U * U[n] + beta_U2 * square(U[n]), sigma);
}
