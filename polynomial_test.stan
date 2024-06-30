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
  // Priorytety
  alpha ~ normal(0.470, 0.1088); // Priorytet dla wyrazu wolnego
  beta_HDI ~ normal(0.901, 0.025); // Priorytet dla współczynnika HDI
  beta_HDI2 ~ normal(0, 0.01); // Mniejszy priorytet dla współczynnika HDI^2
  beta_HDI3 ~ normal(0, 0.001); // Jeszcze mniejszy priorytet dla współczynnika HDI^3
  beta_G ~ normal(0.416, 0.148); // Priorytet dla współczynnika posiadania broni
  beta_G2 ~ normal(0, 0.01); // Mniejszy priorytet dla współczynnika posiadania broni^2
  beta_G3 ~ normal(0, 0.001); // Jeszcze mniejszy priorytet dla współczynnika posiadania broni^3
  beta_U ~ normal(0.057, 0.018); // Priorytet dla współczynnika bezrobocia
  beta_U2 ~ normal(0, 0.01); // Mniejszy priorytet dla współczynnika bezrobocia^2
  beta_U3 ~ normal(0, 0.001); // Jeszcze mniejszy priorytet dla współczynnika bezrobocia^3
  sigma ~ normal(0, 0.5); // Priorytet dla odchylenia standardowego (można rozważyć półnormalny lub eksponencjalny)

  // Wiarygodność
  V ~ normal(alpha + beta_HDI * HDI + beta_HDI2 * square(HDI) + beta_HDI3 * pow(HDI, 3) +
             beta_G * G + beta_G2 * square(G) + beta_G3 * pow(G, 3) +
             beta_U * U + beta_U2 * square(U) + beta_U3 * pow(U, 3), sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_HDI2 * square(HDI[n]) + beta_HDI3 * pow(HDI[n], 3) +
                          beta_G * G[n] + beta_G2 * square(G[n]) + beta_G3 * pow(G[n], 3) +
                          beta_U * U[n] + beta_U2 * square(U[n]) + beta_U3 * pow(U[n], 3), sigma);
}
