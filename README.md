# VTPEH 6270 – Check Point 05

GitHub repository for VTPEH 6270 Check Point 05

## Project Title

Association Between Smoking Status and Diabetes Among Adults in New York State

## Author

Yifei Chen
Cornell University – Master of Public Health (MPH)

## Contact

[yc2985@cornell.edu]
---

## Research Question

Is current smoking status associated with self-reported diabetes among adults in the 2023 New York State BRFSS survey?

---

## Background

Individual behaviors and lifestyle factors are closely linked to health outcomes. Smoking is a known risk factor for many chronic diseases. Understanding its relationship with diabetes prevalence can help inform public health interventions and prevention strategies.

---

## Data Source

This project uses data from the **Behavioral Risk Factor Surveillance System (BRFSS) 2023**, collected by the CDC and the New York State Department of Health.

* Population: Non-institutionalized adults (18+)
* Location: New York State
* Year: 2023
* Link: https://health.data.ny.gov/d/tk4g-wdfe

---

## Repository Structure

* `data/` → raw and processed data files
* `scripts/` → R scripts for analysis
* `output/` → figures and results

---

## Methods

### Data Processing

The dataset was cleaned and filtered to include relevant variables for smoking status and diabetes. Missing values were handled appropriately.

### Visualization

Bar plots were created to compare diabetes prevalence between current smokers and non-smokers.

### Statistical Analysis

A chi-square test and logistic regression model were used to evaluate the association between smoking status and diabetes.

---

## Key Findings

Descriptive results show a slightly higher prevalence of diabetes among current smokers compared to non-smokers. However, statistical tests (chi-square and logistic regression) indicate that this association is **not statistically significant** (p > 0.05).

---

## Shiny App

https://nkk101.shinyapps.io/brfss_smoking_diabetes/

---

## Reproducibility

All analyses can be reproduced by running the scripts in the repository.

* Run `analysis.R` for the final analysis
* Required R packages: tidyverse, dplyr, ggplot2, broom

---

## AI Tool Disclosure

This project used ChatGPT (OpenAI) to assist with code organization, documentation, and repository structuring.


## References
CDC Behavioral Risk Factor Surveillance System (BRFSS)  
New York State Department of Health
