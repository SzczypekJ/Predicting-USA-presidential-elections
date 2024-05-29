data {
    int<lower=1> N;     // # samples
    vector[N] V;        // vector of votes 4 democrats
    vector[N] G;        // vector of gun ownership
    vector[N] HDI;      // vector of HDI values
}

parameters {
    real<lower=0> alpha;
    real<lower=0> beta_1;
    real<lower=0> beta_2;
    real<lower=0> sigma;
}

model {
    V ~ normal(alpha + beta_1*G + beta_2*HDI, sigma);
}

generated quantities {
    array[N] real V_pred = normal_rng(alpha + beta_1*G + beta_2*HDI, sigma);
}
