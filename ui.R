#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Major Market Indexes Returns Correlation Vs DJI"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       sliderInput("period",
                   "Period to observe:",
                   min = 1,
                   max = 2507,
                   value = c(500,1500)),
       hr(),
       radioButtons("stockIdx", "Compute correlation vs:", c("DAX", "FTSE", "N225"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("plot"),
                 verbatimTextOutput("correlation", placeholder = TRUE)
        ),
        tabPanel("Table", tableOutput("tblOutput")),
        tabPanel("Help", helpText("Drag the slider 'Period to observe' to define the period of your interest.\nSelect the appropriate index for comparison against the DJI from the list of proposed indexes."))
      )
    )
  )
))
