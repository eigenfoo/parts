data {
  int<lower=0> N;     // Number of non-Friday lectures
  int<lower=0> M;     // Number of Friday lectures

  int<lower=0> non_friday_parts[N];
  int<lower=0> friday_parts[M];
}

parameters {
  real<lower=0> lambda;
}

model {
  // Prior
  lambda ~ normal(0, 10);

  // Likelihood (non-Friday lectures)
  for (n in 1:N) {
    non_friday_parts ~ poisson(lambda);
  }

  // Likelihood (Friday lectures)
  for (m in 1:M) {
    friday_parts ~ poisson(2*lambda);
  }
}

generated quantities {
  int<lower=0> post_pred_non_friday_parts[N];
  int<lower=0> post_pred_friday_parts[M];

  for (n in 1:N) {
    post_pred_non_friday_parts[n] = poisson_rng(lambda);
  }

  for (m in 1:M) {
    post_pred_friday_parts[m] = poisson_rng(2*lambda);
  }
}
