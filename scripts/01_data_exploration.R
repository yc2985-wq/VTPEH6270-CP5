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
data <- read.csv("data/brfss_2023.csv")

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

# =========================
# 5. Select key variables
# =========================
# Example variable names – adjust if your dataset uses different names
data_clean <- data %>%
  select(smoking_status, diabetes) %>%
  drop_na()

# =========================
# 6. Descriptive statistics
# =========================
# Frequency tables
table(data_clean$smoking_status)
table(data_clean$diabetes)

# Cross-tabulation
table(data_clean$smoking_status, data_clean$diabetes)

# Proportions
prop.table(table(data_clean$smoking_status, data_clean$diabetes), 1)

# =========================
# 7. Visualization
# =========================
# Bar plot of diabetes by smoking status
ggplot(data_clean, aes(x = smoking_status, fill = diabetes)) +
  geom_bar(position = "fill") +
  labs(
    title = "Diabetes Prevalence by Smoking Status",
    x = "Smoking Status",
    y = "Proportion"
  ) +
  theme_minimal()

# =========================
# 8. Interpretation (optional note)
# =========================
# Preliminary observation:
# The proportion of diabetes appears higher among certain smoking groups,
# suggesting a potential association worth further investigation.
