# VTPEH 6270 - Check Point 05
# Script: Data Exploration
# Author: Yifei Chen
# Description: This script performs data cleaning and exploratory analysis 
# to examine the relationship between smoking status and diabetes 
# using BRFSS 2023 data.

# =========================
# 1. Load required packages
# =========================
library(tidyverse)

# =========================
# 2. Load dataset
# =========================
# NOTE: Update file name if needed
brfss <- read.csv("data/brfss_small.csv")
# NOTE:
# The original dataset (brfss) was large and could not be uploaded directly to GitHub.
# A cleaned and reduced subset was created and stored as 'data' for analysis.
# This explains the change in dataset name from 'brfss' to 'data'.
# =========================
# 3. Inspect dataset
# =========================
glimpse(data)
summary(data)

# =========================
# 4. Handle missing values
# =========================
# Count missing values in each column
colSums(is.na(data))

# ============================
# 5. Select key variables
# ============================

data_clean <- data %>%
  select(X_SMOKER3, DIABETE4) %>%
  drop_na()

# ============================
# 6. Descriptive statistics
# ============================

table(data_clean$X_SMOKER3)
table(data_clean$DIABETE4)

table(data_clean$X_SMOKER3, data_clean$DIABETE4)

prop.table(table(data_clean$X_SMOKER3, data_clean$DIABETE4), 1)

# ============================
# 7. Visualization
# ============================

ggplot(data_clean, aes(x = X_SMOKER3, fill = DIABETE4)) +
  geom_bar(position = "fill") +
  labs(
    title = "Diabetes Prevalence by Smoking Status",
    x = "Smoking Status",
    y = "Proportion"
  ) +
  theme_minimal()

# ============================
# 8. Interpretation (optional note)
# ============================

# Preliminary observation:
# The proportion of diabetes appears higher among certain smoking groups,
# suggesting a potential association worth further investigation.

