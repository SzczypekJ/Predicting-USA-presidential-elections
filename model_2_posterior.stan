data {
  int<lower=0> N; // number of observations
  vector[N] HDI; // predictor 1
  vector[N] G; // predictor 2 (Gun ownership %)
  vector[N] U; // predictor 3 (Unemployment %)
  vector[N] V; // outcome (Democratic %)
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
}

model {
  alpha ~ normal(45, 10); // Prior for intercept
  beta_HDI ~ normal(0, 0.3); // Prior for HDI coefficient
  beta_G ~ normal(0, 0.3); // Prior for Gun Ownership coefficient
  beta_U ~ normal(0, 0.3); // Prior for Unemployment coefficient
  beta_HDI2 ~ normal(0, 0.1); // Prior for HDI^2 coefficient
  beta_G2 ~ normal(0, 0.1); // Prior for Gun Ownership^2 coefficient
  beta_U2 ~ normal(0, 0.1); // Prior for Unemployment^2 coefficient
  beta_HDI3 ~ normal(0, 0.05); // Prior for HDI^3 coefficient
  beta_G3 ~ normal(0, 0.05); // Prior for Gun Ownership^3 coefficient
  beta_U3 ~ normal(0, 0.05); // Prior for Unemployment^3 coefficient
  sigma ~ normal(5, 0.5); // Prior for standard deviation

  // Likelihood
  V ~ normal(alpha + beta_HDI * HDI + beta_G * G + beta_U * U 
             + beta_HDI2 * square(HDI) + beta_G2 * square(G) + beta_U2 * square(U)
             + beta_HDI3 * pow(HDI, 3) + beta_G3 * pow(G, 3) + beta_U3 * pow(U, 3), sigma);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N) {
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n] 
                          + beta_HDI2 * square(HDI[n]) + beta_G2 * square(G[n]) + beta_U2 * square(U[n])
                          + beta_HDI3 * pow(HDI[n], 3) + beta_G3 * pow(G[n], 3) + beta_U3 * pow(U[n], 3), sigma);
  }
}
