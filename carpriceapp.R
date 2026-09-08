#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
# ============================================================
# USED CAR PRICE PREDICTION - SHINY APP
# ============================================================

# Install packages if needed
# Run this ONCE if you have not installed them:
# install.packages(c("shiny", "readr", "dplyr", "randomForest"))

# Load packages
library(shiny)
library(readr)
library(dplyr)
library(randomForest)

# ============================================================
# 1. READ DATASET
# ============================================================

cardata <- read_csv("C:/Users/shiva/Downloads/cardata.csv")

# ============================================================
# 2. CLEAN DATA
# ============================================================

# Convert categorical columns to factors
cardata$Fuel_Type <- as.factor(cardata$Fuel_Type)
cardata$Seller_Type <- as.factor(cardata$Seller_Type)
cardata$Transmission <- as.factor(cardata$Transmission)

# Remove missing values
cardata <- na.omit(cardata)

# ============================================================
# 3. SELECT VARIABLES FOR MODEL
# ============================================================

model_data <- cardata %>%
  select(
    Selling_Price,
    Present_Price,
    Kms_Driven,
    Year,
    Fuel_Type,
    Seller_Type,
    Transmission,
    Owner
  )

# ============================================================
# 4. RANDOM FOREST MODEL
# ============================================================

set.seed(123)

rf_model <- randomForest(
  Selling_Price ~
    Present_Price +
    Kms_Driven +
    Year +
    Fuel_Type +
    Seller_Type +
    Transmission +
    Owner,
  data = model_data,
  ntree = 500,
  importance = TRUE
)

# ============================================================
# 5. SHINY USER INTERFACE
# ============================================================

ui <- fluidPage(
  
  # Application title
  titlePanel("Used Car Price Prediction"),
  
  sidebarLayout(
    
    # --------------------------------------------------------
    # INPUTS
    # --------------------------------------------------------
    
    sidebarPanel(
      
      h3("Enter Car Details"),
      
      numericInput(
        inputId = "present_price",
        label = "Present Price:",
        value = 5,
        min = 0
      ),
      
      numericInput(
        inputId = "kms_driven",
        label = "Kilometers Driven:",
        value = 30000,
        min = 0
      ),
      
      numericInput(
        inputId = "year",
        label = "Year:",
        value = 2016,
        min = 2000,
        max = 2026
      ),
      
      selectInput(
        inputId = "fuel_type",
        label = "Fuel Type:",
        choices = levels(cardata$Fuel_Type),
        selected = levels(cardata$Fuel_Type)[1]
      ),
      
      selectInput(
        inputId = "seller_type",
        label = "Seller Type:",
        choices = levels(cardata$Seller_Type),
        selected = levels(cardata$Seller_Type)[1]
      ),
      
      selectInput(
        inputId = "transmission",
        label = "Transmission:",
        choices = levels(cardata$Transmission),
        selected = levels(cardata$Transmission)[1]
      ),
      
      numericInput(
        inputId = "owner",
        label = "Previous Owners:",
        value = 0,
        min = 0,
        max = 3,
        step = 1
      ),
      
      br(),
      
      actionButton(
        inputId = "predict",
        label = "Predict Selling Price"
      )
    ),
    
    # --------------------------------------------------------
    # OUTPUT
    # --------------------------------------------------------
    
    mainPanel(
      
      h2("Prediction Result"),
      
      br(),
      
      h3("Estimated Selling Price:"),
      
      h1(
        textOutput("prediction")
      ),
      
      br(),
      
      h3("Car Details"),
      
      tableOutput("car_details"),
      
      br(),
      
      h3("Model Information"),
      
      p(
        "The prediction is generated using a Random Forest
        machine learning model."
      )
    )
  )
)

# ============================================================
# 6. SHINY SERVER
# ============================================================

server <- function(input, output, session) {
  
  # ----------------------------------------------------------
  # PREDICTION
  # ----------------------------------------------------------
  
  prediction <- eventReactive(input$predict, {
    
    # Create new car data
    new_car <- data.frame(
      
      Present_Price = input$present_price,
      
      Kms_Driven = input$kms_driven,
      
      Year = input$year,
      
      Fuel_Type = factor(
        input$fuel_type,
        levels = levels(cardata$Fuel_Type)
      ),
      
      Seller_Type = factor(
        input$seller_type,
        levels = levels(cardata$Seller_Type)
      ),
      
      Transmission = factor(
        input$transmission,
        levels = levels(cardata$Transmission)
      ),
      
      Owner = input$owner
    )
    
    # Predict price
    predict(
      rf_model,
      newdata = new_car
    )
  })
  
  # ----------------------------------------------------------
  # DISPLAY PREDICTION
  # ----------------------------------------------------------
  
  output$prediction <- renderText({
    
    req(prediction())
    
    paste(
      "₹",
      round(prediction(), 2),
      "lakhs"
    )
  })
  
  # ----------------------------------------------------------
  # DISPLAY CAR DETAILS
  # ----------------------------------------------------------
  
  output$car_details <- renderTable({
    
    data.frame(
      Variable = c(
        "Present Price",
        "Kilometers Driven",
        "Year",
        "Fuel Type",
        "Seller Type",
        "Transmission",
        "Previous Owners"
      ),
      
      Value = c(
        input$present_price,
        input$kms_driven,
        input$year,
        input$fuel_type,
        input$seller_type,
        input$transmission,
        input$owner
      )
    )
  })
}

# ============================================================
# 7. RUN SHINY APPLICATION
# ============================================================

shinyApp(
  ui = ui,
  server = server
)
