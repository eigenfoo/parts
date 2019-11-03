parameters {
  real<lower=0> lambda;
}

model {
  // Prior
  lambda ~ normal(0, 10)
}

generated quantities{
  // Prior predictive distribution
  vector[N] prior_pred_friday_parts;
  vector[N] prior_pred_non_friday_parts;
  for (n in 1:N) {
    prior_pred_friday_parts[n] = poisson_rng(lambda);
  }
  for (m in 1:M) {
    prior_pred_friday_parts[m] = poisson_rng(2*lambda);
  }
}
