library(shiny)
library(tidyverse)
library(DT)

# Load data
brfss <- read.csv("brfss_small.csv", fileEncoding = "latin1")

# Clean data
data_clean <- brfss %>%
  filter(
    X_SMOKER3 %in% c(
      "Former smoker",
      "Never smoked",
      "Current smoker - now smokes every day",
      "Current smoker - now smokes some days"
    ),
    DIABETE4 %in% c(
      "Yes",
      "No",
      "No, pre-diabetes or borderline diabetes",
      "Yes, but female told only during pregnancy"
    )
  ) %>%
  mutate(
    smoking_status = X_SMOKER3,
    diabetes_status = case_when(
      DIABETE4 == "Yes" ~ "Diabetes",
      DIABETE4 == "No" ~ "No diabetes",
      DIABETE4 == "No, pre-diabetes or borderline diabetes" ~ "Prediabetes / borderline",
      DIABETE4 == "Yes, but female told only during pregnancy" ~ "Pregnancy-related diabetes",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(smoking_status), !is.na(diabetes_status))

ui <- fluidPage(
  tags$style(HTML("
    body { font-size: 18px; }
    h1, h2, h3 { font-weight: bold; }
    .well { background-color: #f7f7f7; }
  ")),
  
  titlePanel("Smoking Status and Diabetes Among Adults in New York State"),
  
  tabsetPanel(
    tabPanel(
      "Context",
      h3("Project Context"),
      p("This app explores the relationship between smoking status and self-reported diabetes using the BRFSS project dataset."),
      
      h3("Research Question"),
      p("How does self-reported diabetes status differ across smoking status groups?"),
      
      h3("Data Source"),
      p("Data source: BRFSS project dataset. A smaller processed dataset was used because the original BRFSS dataset was too large to upload directly to GitHub."),
      
      h3("Methods"),
      p("The app summarizes diabetes status by smoking status using frequency tables, proportions, and interactive bar plots."),
      
      h3("GitHub Repository"),
      tags$a(
        href = "https://github.com/yc2985-wq/VTPEH6270-CP5",
        "View project code on GitHub",
        target = "_blank"
      ),
      
      h3("AI Disclosure"),
      p("ChatGPT was used to assist with code organization, wording, and debugging. Final decisions about analysis and interpretation were completed by the author.")
    ),
    
    tabPanel(
      "Summary",
      h3("Summary Statistics by Smoking Status"),
      tableOutput("summary_table"),
      
      br(),
      h3("Dataset Check"),
      verbatimTextOutput("data_check")
    ),
    
    tabPanel(
      "Visualization",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "plot_type",
            "Choose plot type:",
            choices = c("Proportion plot", "Count plot")
          ),
          
          checkboxInput(
            "include_prediabetes",
            "Include prediabetes and pregnancy-related diabetes",
            value = TRUE
          )
        ),
        
        mainPanel(
          plotOutput("main_plot", height = "550px")
        )
      )
    ),
    
    tabPanel(
      "Interpretation",
      h3("Interpretation"),
      p("This app allows users to compare self-reported diabetes status across smoking status groups."),
      p("The proportion plot is useful for comparing the distribution of diabetes status within each smoking group. The count plot is useful for seeing the sample size in each group."),
      p("Because BRFSS is survey-based and this analysis is descriptive, the results should not be interpreted as proving causation."),
      p("These results can help identify patterns that may be useful for public health education, prevention programs, and future statistical analysis."),
      p("Note: This Shiny app includes additional categories such as prediabetes and pregnancy-related diabetes for exploratory purposes, while the final report uses a binary classification of diabetes versus no diabetes for statistical analysis.")
    )
  )
)

server <- function(input, output) {
  
  filtered_data <- reactive({
    if (input$include_prediabetes) {
      data_clean
    } else {
      data_clean %>%
        filter(diabetes_status %in% c("Diabetes", "No diabetes"))
    }
  })
  
  output$data_check <- renderPrint({
    cat("Total rows in original dataset:", nrow(brfss), "\n")
    cat("Rows used after cleaning:", nrow(data_clean), "\n")
    cat("Rows currently displayed:", nrow(filtered_data()), "\n")
    cat("Smoking variable used: X_SMOKER3\n")
    cat("Diabetes variable used: DIABETE4\n")
  })
  
  output$summary_table <- renderTable({
    filtered_data() %>%
      group_by(smoking_status, diabetes_status) %>%
      summarise(N = n(), .groups = "drop") %>%
      group_by(smoking_status) %>%
      mutate(Percent = round(N / sum(N) * 100, 1)) %>%
      arrange(smoking_status, diabetes_status)
  })
  
  output$main_plot <- renderPlot({
    if (input$plot_type == "Proportion plot") {
      ggplot(filtered_data(), aes(x = smoking_status, fill = diabetes_status)) +
        geom_bar(position = "fill") +
        labs(
          title = "Diabetes Status by Smoking Status",
          x = "Smoking Status",
          y = "Proportion",
          fill = "Diabetes Status"
        ) +
        theme_minimal(base_size = 18) +
        theme(
          axis.text.x = element_text(angle = 25, hjust = 1, size = 15),
          axis.text.y = element_text(size = 15),
          axis.title = element_text(size = 17),
          plot.title = element_text(size = 20, face = "bold"),
          legend.title = element_text(size = 16),
          legend.text = element_text(size = 15)
        )
    } else {
      ggplot(filtered_data(), aes(x = smoking_status, fill = diabetes_status)) +
        geom_bar(position = "dodge") +
        labs(
          title = "Number of Respondents by Smoking and Diabetes Status",
          x = "Smoking Status",
          y = "Number of Respondents",
          fill = "Diabetes Status"
        ) +
        theme_minimal(base_size = 18) +
        theme(
          axis.text.x = element_text(angle = 25, hjust = 1, size = 15),
          axis.text.y = element_text(size = 15),
          axis.title = element_text(size = 17),
          plot.title = element_text(size = 20, face = "bold"),
          legend.title = element_text(size = 16),
          legend.text = element_text(size = 15)
        )
    }
  })
}

shinyApp(ui = ui, server = server)