data {
  int<lower=0> N; // number of observations
  vector[N] HDI; // predictor 1
  vector[N] G; // predictor 2 (Gun ownership %)
}

parameters {
  real alpha;
  real beta_HDI;
  real beta_G;
  real<lower=0> sigma;
}

generated quantities {
  vector[N] y_prior;
  for (n in 1:N)
    y_prior[n] = normal_rng(alpha + beta_HDI * HDI[n] + beta_G * G[n], sigma);
}
