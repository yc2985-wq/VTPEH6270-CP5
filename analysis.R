# Analysis script for final report
# Reproduces all tables, figures, and statistical analyses
# Based on BRFSS data (smoking and diabetes)


# Data Cleaning
library(dplyr)
library(ggplot2)
library(scales)
library(broom)

brfss <- read.csv("data/brfss_small.csv", fileEncoding = "latin1")

analysis_data <- brfss %>%
  filter(
    X_SMOKER3 %in% c(
      "Former smoker",
      "Never smoked",
      "Current smoker - now smokes every day",
      "Current smoker - now smokes some days"
    ),
    DIABETE4 %in% c(
      "Yes",
      "No"
    )
  ) %>%
  mutate(
    smoking_group = case_when(
      X_SMOKER3 %in% c(
        "Current smoker - now smokes every day",
        "Current smoker - now smokes some days"
      ) ~ "Current smoker",
      X_SMOKER3 %in% c(
        "Former smoker",
        "Never smoked"
      ) ~ "Non-current smoker"
    ),
    diabetes_status = case_when(
      DIABETE4 == "Yes" ~ "Diabetes",
      DIABETE4 == "No" ~ "No diabetes"
    ),
    smoking_group = factor(smoking_group, levels = c("Non-current smoker", "Current smoker")),
    diabetes_status = factor(diabetes_status, levels = c("No diabetes", "Diabetes"))
  )

# Table
summary_table <- analysis_data %>%
  group_by(smoking_group, diabetes_status) %>%
  summarise(N = n(), .groups = "drop") %>%
  group_by(smoking_group) %>%
  mutate(Percent = round(N / sum(N) * 100, 1))

summary_table

# Proportion Plot
ggplot(analysis_data, aes(x = smoking_group, fill = diabetes_status)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = percent_format()) +
  labs(
    title = "Proportion of Self-Reported Diabetes by Smoking Status",
    x = "Smoking Status",
    y = "Proportion",
    fill = "Diabetes Status"
  ) +
  theme_minimal(base_size = 14)

# Count Plot
ggplot(analysis_data, aes(x = smoking_group, fill = diabetes_status)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Count of Self-Reported Diabetes by Smoking Status",
    x = "Smoking Status",
    y = "Number of Respondents",
    fill = "Diabetes Status"
  ) +
  theme_minimal(base_size = 14)

# chi-square
diabetes_table <- table(
  analysis_data$smoking_group,
  analysis_data$diabetes_status
)

diabetes_table

chi_result <- chisq.test(diabetes_table)
chi_result

# Logistic Regression
analysis_data <- analysis_data %>%
  mutate(
    diabetes_binary = ifelse(diabetes_status == "Diabetes", 1, 0)
  )

logit_model <- glm(
  diabetes_binary ~ smoking_group,
  data = analysis_data,
  family = binomial
)

summary(logit_model)

logit_results <- tidy(logit_model, exponentiate = TRUE, conf.int = TRUE)

logit_results


chi_result$expected
