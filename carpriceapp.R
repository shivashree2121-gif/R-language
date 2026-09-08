library(shiny)
library(randomForest)
library(tidyverse)
library(readr)

# Load data
cardata <- read_csv("C:/Users/shiva/Downloads/cardata.csv")

# Convert categorical variables
cardata$Fuel_Type <- as.factor(cardata$Fuel_Type)
cardata$Seller_Type <- as.factor(cardata$Seller_Type)
cardata$Transmission <- as.factor(cardata$Transmission)

# Model data
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
  ) %>%
  drop_na()

# Train model
set.seed(123)

rf_model <- randomForest(
  Selling_Price ~ .,
  data = model_data,
  ntree = 500
)

# UI
ui <- fluidPage(
  
  titlePanel("Used Car Price Prediction"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      numericInput(
        "present_price",
        "Present Price:",
        value = 5,
        min = 0
      ),
      
      numericInput(
        "kms",
        "Kilometers Driven:",
        value = 30000,
        min = 0
      ),
      
      numericInput(
        "year",
        "Year:",
        value = 2016,
        min = 2000,
        max = 2026
      ),
      
      selectInput(
        "fuel",
        "Fuel Type:",
        choices = levels(cardata$Fuel_Type)
      ),
      
      selectInput(
        "seller",
        "Seller Type:",
        choices = levels(cardata$Seller_Type)
      ),
      
      selectInput(
        "transmission",
        "Transmission:",
        choices = levels(cardata$Transmission)
      ),
      
      numericInput(
        "owner",
        "Number of Previous Owners:",
        value = 0,
        min = 0,
        max = 3
      ),
      
      actionButton(
        "predict",
        "Predict Price"
      )
    ),
    
    mainPanel(
      
      h2("Predicted Selling Price"),
      
      textOutput("prediction")
      
    )
  )
)

# Server
server <- function(input, output) {
  
  prediction <- eventReactive(input$predict, {
    
    new_car <- data.frame(
      
      Present_Price = input$present_price,
      
      Kms_Driven = input$kms,
      
      Year = input$year,
      
      Fuel_Type = factor(
        input$fuel,
        levels = levels(cardata$Fuel_Type)
      ),
      
      Seller_Type = factor(
        input$seller,
        levels = levels(cardata$Seller_Type)
      ),
      
      Transmission = factor(
        input$transmission,
        levels = levels(cardata$Transmission)
      ),
      
      Owner = input$owner
    )
    
    predict(
      rf_model,
      newdata = new_car
    )
  })
  
  output$prediction <- renderText({
    
    paste(
      "Estimated Selling Price:",
      round(prediction(), 2)
    )
    
  })
}

shinyApp(ui = ui, server = server)#
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
