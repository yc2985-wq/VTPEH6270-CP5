# VTPEH 6270 – Check Point 05
GitHub repository for VTPEH 6270 Check Point 05

## Project Title
Association Between Smoking Status and Diabetes Among Adults in New York State

## Author
Yifei Chen  
Cornell University – Master of Public Health (MPH)

## Contact
yc2985@cornell.edu

---

## Research Question
Is current smoking status associated with self-reported diabetes among adults in the 2023 New York State BRFSS survey?

---

## Background
Individual behaviors and lifestyle factors are closely linked to health outcomes. Smoking is a known risk factor for many chronic diseases. Understanding its relationship with diabetes prevalence can help inform public health interventions and prevention strategies.

---

## Data Source
This project uses data from the **Behavioral Risk Factor Surveillance System (BRFSS) 2023**, collected by the CDC and the New York State Department of Health.

- Population: Non-institutionalized adults (18+)
- Location: New York State
- Year: 2023  
- Link: https://health.data.ny.gov/d/tk4g-wdfe

---

## Repository Structure

- `data/` → raw and processed data files  
- `scripts/` → R scripts for analysis and simulation  
- `output/` → figures and reports  

---

## Methods

### Data Exploration
The dataset was cleaned and explored using R. Missing values were handled, and key variables were selected for analysis.

### Visualization
Bar plots were created to compare diabetes prevalence across smoking status groups.

### Simulation
A simulation framework was developed to model the relationship between smoking and diabetes under different:

- Effect sizes  
- Sample sizes  
- Noise levels  

This allows assessment of how statistical power varies under different scenarios.

---

## Key Findings
Preliminary analysis suggests that the prevalence of diabetes is higher among smokers compared to non-smokers, indicating a possible positive association.

---

## Reproducibility
All analyses can be reproduced by running the scripts in the `scripts/` folder. Required R packages include:

- tidyverse  
- dplyr  
- ggplot2  

Note: The original dataset was large and was processed into a smaller subset for analysis. 
In the scripts, the dataset name changes from "brfss" to "data" to reflect this cleaned and reduced dataset used for downstream analysis.
---

## AI Tool Disclosure
This project used ChatGPT (OpenAI) to assist with code organization, documentation, and repository structuring.

---

## References
CDC Behavioral Risk Factor Surveillance System (BRFSS)  
New York State Department of Health
