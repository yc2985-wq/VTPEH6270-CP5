# VTPEH 6270 - Check Point 05
# Script: Simulation
# Author: Yifei Chen
# Description: This script simulates the relationship between smoking status 
# and diabetes under different sample sizes and effect sizes.

# =========================
# 1. Load packages
# =========================
library(tidyverse)

# =========================
# 2. Set seed for reproducibility
# =========================
set.seed(123)

# =========================
# 3. Define simulation function
# =========================
simulate_data <- function(n, prob_smoke = 0.3, prob_diabetes = 0.1, effect = 1.5) {
  
  smoking <- rbinom(n, 1, prob_smoke)
  
  diabetes_prob <- prob_diabetes + smoking * (effect - 1) * prob_diabetes
  diabetes <- rbinom(n, 1, diabetes_prob)
  
  data.frame(smoking, diabetes)
}

# =========================
# 4. Run simulation
# =========================
sim_data <- simulate_data(n = 1000)

# =========================
# 5. Analyze simulated data
# =========================
table(sim_data$smoking, sim_data$diabetes)

prop.table(table(sim_data$smoking, sim_data$diabetes), 1)

# =========================
# 6. Visualization
# =========================
ggplot(sim_data, aes(x = factor(smoking), fill = factor(diabetes))) +
  geom_bar(position = "fill") +
  labs(
    title = "Simulated Diabetes by Smoking Status",
    x = "Smoking (0 = No, 1 = Yes)",
    y = "Proportion"
  ) +
  theme_minimal()

# =========================
# 7. Interpretation
# =========================
# The simulation shows how increasing effect size changes the relationship 
# between smoking and diabetes prevalence.
