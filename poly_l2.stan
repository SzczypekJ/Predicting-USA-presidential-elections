data {
  int<lower=0> N; // liczba obserwacji
  vector[N] HDI; // predyktor 1
  vector[N] G; // predyktor 2 (procent posiadania broni)
  vector[N] U; // predyktor 3 (procent bezrobocia)
  vector[N] V; // wynik (procent głosów na demokratów)
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real beta_U;
  real beta_HDI2;
  real beta_G2;
  real beta_U2;
  real beta_HDI3;
  real beta_G3;
  real beta_U3;
  real<lower=0> sigma;
  real<lower=0> lambda; // regularization parameter
}

model {
  // Priorytety
  alpha ~ normal(0.470, 0.1088); // Priorytet dla wyrazu wolnego
  beta_HDI ~ normal(0.901, 0.025); // Priorytet dla HDI
  beta_HDI2 ~ normal(0.901, 0.01); // Priorytet dla HDI^2
  beta_HDI3 ~ normal(0.901, 0.001); // Priorytet dla HDI^3
  beta_G ~ normal(0.416, 0.148); // Priorytet dla posiadania broni
  beta_G2 ~ normal(0.416, 0.01); // Priorytet dla posiadania broni^2
  beta_G3 ~ normal(0.416, 0.001); // Priorytet dla posiadania broni^3
  beta_U ~ normal(0.057, 0.018); // Priorytet dla bezrobocia
  beta_U2 ~ normal(0.057, 0.01); // Priorytet dla bezrobocia^2
  beta_U3 ~ normal(0.057, 0.001); // Priorytet dla bezrobocia^3
  sigma ~ normal(0, 0.5); // Priorytet dla sigma
  lambda ~ normal(0, 1); // Priorytet dla parametru regularizacji

  // Funkcja kosztu z regularyzacją L2
  target += normal_lpdf(V | alpha + beta_HDI * HDI + beta_G * G + beta_U * U
                            + beta_HDI2 * square(HDI) + beta_G2 * square(G) + beta_U2 * square(U)
                            + beta_HDI3 * pow(HDI, 3) + beta_G3 * pow(G, 3) + beta_U3 * pow(U, 3), sigma);
  
  // Regularizacja L2
  target += -lambda * (square(beta_HDI) + square(beta_G) + square(beta_U)
                       + square(beta_HDI2) + square(beta_G2) + square(beta_U2)
                       + square(beta_HDI3) + square(beta_G3) + square(beta_U3));
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n]
                          + beta_HDI2 * square(HDI[n]) + beta_G2 * square(G[n]) + beta_U2 * square(U[n])
                          + beta_HDI3 * pow(HDI[n], 3) + beta_G3 * pow(G[n], 3) + beta_U3 * pow(U[n], 3), sigma);
}
