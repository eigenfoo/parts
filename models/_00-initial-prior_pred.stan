data {
  int<lower=0> N;     // Number of iterations
}

generated quantities {
  // Parameters
  real<lower=0> lambda = fabs(normal_rng(0, 10));

  // Simulate data
  int prior_pred_friday_parts[N];
  int prior_pred_non_friday_parts[N];

  for (n in 1:N) {
    prior_pred_friday_parts[n] = poisson_rng(lambda);
  }
  for (n in 1:N) {
    prior_pred_friday_parts[n] = poisson_rng(2*lambda);
  }
}
