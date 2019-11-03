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

  for (n in 1:N) {
    non_friday_parts ~ poisson(lambda);
  }

  for (m in 1:M) {
    friday_parts ~ poisson(2*lambda);
  }
}

generated quantities {
  // Posterior predictive
}
