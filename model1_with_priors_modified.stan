data {
    int<lower=1> N;     // # samples
    int<lower=1> N_complete; // # samples with complete data
    int<lower=1> N_missing;  // # samples with missing data (District of Columbia)
    vector[N_complete] V_complete; // vector of votes for democrats with complete data
    vector[N_missing] V_missing;   // vector of votes for democrats with missing data
    vector[N_complete] G;        // vector of gun ownership (only complete data)
    vector[N] HDI;      // vector of HDI values (complete and missing data)
}

parameters {
    real alpha;
    real beta_1;
    real beta_2;
    real<lower=0> sigma;
}

model {
    alpha ~ normal(50, 10);
    beta_1 ~ normal(0, 1);
    beta_2 ~ normal(0, 1);
    sigma ~ cauchy(0, 2);

    V_complete ~ normal(alpha + beta_1 * G + beta_2 * HDI[1:N_complete], sigma);
    V_missing ~ normal(alpha + beta_2 * HDI[(N_complete + 1):N], sigma); // Without beta_1 * G for missing data
}

generated quantities {
    array[N] real V_pred;
    for (n in 1:N_complete) {
        V_pred[n] = normal_rng(alpha + beta_1 * G[n] + beta_2 * HDI[n], sigma);
    }
    for (n in (N_complete + 1):N) {
        V_pred[n] = normal_rng(alpha + beta_2 * HDI[n], sigma);
    }
}
