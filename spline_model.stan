data {
  int<lower=0> N; // liczba obserwacji
  vector[N] HDI; // predyktor 1
  vector[N] G; // predyktor 2 (procent posiadania broni)
  vector[N] U; // predyktor 3 (procent bezrobocia)
  vector[N] V; // wynik (procent głosów na demokratów)
  int<lower=1> K; // liczba węzłów splajnu B
  matrix[N, K] B_HDI; // macierz splajnu B dla HDI
  matrix[N, K] B_G; // macierz splajnu B dla posiadania broni
  matrix[N, K] B_U; // macierz splajnu B dla bezrobocia
}

parameters {
  real alpha;
  vector[K] beta_HDI;
  vector[K] beta_G;
  vector[K] beta_U;
  real<lower=0> sigma;
}

model {
  // Priorytety
  alpha ~ normal(0.470, 0.1088); // Priorytet dla wyrazu wolnego
  beta_HDI ~ normal(0, 1); // Priorytet dla współczynników splajnu B dla HDI
  beta_G ~ normal(0, 1); // Priorytet dla współczynników splajnu B dla posiadania broni
  beta_U ~ normal(0, 1); // Priorytet dla współczynników splajnu B dla bezrobocia
  sigma ~ normal(0, 1); // Priorytet dla odchylenia standardowego

  // Wiarygodność
  V ~ normal(alpha + B_HDI * beta_HDI + B_G * beta_G + B_U * beta_U, sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + B_HDI[n] * beta_HDI + B_G[n] * beta_G + B_U[n] * beta_U, sigma);
}
