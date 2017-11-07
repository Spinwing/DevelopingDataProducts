#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  stockData <- reactive({
    read.csv("StockIndexCorrelation.csv")
  })

  output$tblOutput <- DT::renderDataTable({
    filter(stockData(), IDX>=input$period[1], IDX<=input$period[2])
  })

  output$plot <- renderPlot({
    # selects data based on inputs
    myData <- filter(stockData(), IDX>=input$period[1], IDX<=input$period[2])
    p <- ggplot(myData, aes(IDX))
    p <- p + geom_line(aes(y=DJI, colour = "DJI"))

    if (input$stockIdx == "DAX") {
      p <- p + geom_line(aes(y=DAX, colour = "DAX"))
      p <- p + ggtitle(paste("DJI vs", "DAX"))
    } else if (input$stockIdx == "FTSE") {
      p <- p + geom_line(aes(y=FTSE, colour = "FTSE"))
      p <- p + ggtitle(paste("DJI vs", "FTSE"))
    } else if (input$stockIdx == "N225") {
      p <- p + geom_line(aes(y=N225, colour = "N225"))
      p <- p + ggtitle(paste("DJI vs", "N225"))
    }
    print(p)
  })

  output$correlation <- renderText({
    myData <- filter(stockData(), IDX>=input$period[1], IDX<=input$period[2])
    if (input$stockIdx == "DAX") {
      c <- cor(myData$DJI, myData$DAX)
    } else if (input$stockIdx == "FTSE") {
      c <- cor(myData$DJI, myData$FTSE)
    } else if (input$stockIdx == "N225") {
      c <- cor(myData$DJI, myData$N225)
    }

    paste("Correlation for observed period: ", c)
  })

})
