data {
  int<lower=0> N;
  vector[N] HDI;
  vector[N] G;
  vector[N] U;
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
  alpha ~ normal(45, 8); // Prior for intercept, slightly narrower
  beta_HDI ~ normal(0, 0.2); // Narrower prior for HDI coefficient
  beta_G ~ normal(0, 0.2); // Narrower prior for Gun Ownership coefficient
  beta_U ~ normal(0, 0.2); // Narrower prior for Unemployment coefficient
  beta_HDI2 ~ normal(0, 0.08); // Narrower prior for HDI^2 coefficient
  beta_G2 ~ normal(0, 0.08); // Narrower prior for Gun Ownership^2 coefficient
  beta_U2 ~ normal(0, 0.08); // Narrower prior for Unemployment^2 coefficient
  beta_HDI3 ~ normal(0, 0.03); // Narrower prior for HDI^3 coefficient
  beta_G3 ~ normal(0, 0.03); // Narrower prior for Gun Ownership^3 coefficient
  beta_U3 ~ normal(0, 0.03); // Narrower prior for Unemployment^3 coefficient
  sigma ~ normal(5, 0.4); // Narrower prior for standard deviation
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n] + beta_U * U[n] 
                          + beta_HDI2 * square(HDI[n]) + beta_G2 * square(G[n]) + beta_U2 * square(U[n])
                          + beta_HDI3 * pow(HDI[n], 3) + beta_G3 * pow(G[n], 3) + beta_U3 * pow(U[n], 3), sigma);
}
