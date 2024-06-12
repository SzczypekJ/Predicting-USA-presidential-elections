data {
    int<lower=1> N;     // number of samples
    vector[N] V;        // vector of votes for democrats
    vector[N] G;        // vector of gun ownership
    vector[N] HDI;      // vector of HDI values
}

parameters {
    real alpha;         // intercept
    real beta_1;        // coefficient for gun ownership
    real beta_2;        // coefficient for HDI
    real<lower=0> sigma; // standard deviation of the error term
}

model {
    // Priors
    alpha ~ normal(50, 10);      // Prior for intercept, centered around 50 with SD 10
    beta_1 ~ normal(0, 1);       // Prior for gun ownership coefficient, centered around 0 with SD 1
    beta_2 ~ normal(0, 1);       // Prior for HDI coefficient, centered around 0 with SD 1
    sigma ~ cauchy(0, 2);        // Prior for standard deviation, half-Cauchy distribution

    // Likelihood
    V ~ normal(alpha + beta_1 * G + beta_2 * HDI, sigma); // Model for votes
}

generated quantities {
    array[N] real V_pred; // Array to store predictions
    for (n in 1:N)
        V_pred[n] = normal_rng(alpha + beta_1 * G[n] + beta_2 * HDI[n], sigma); // Generate predictions
}
