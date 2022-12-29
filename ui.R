library(shiny)
library(ggplot2)
library(sf)
library(pacman)
library(raster)
library(geodata)
library(plotly)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Ukraine places"),
  
  # Sidebar with a slider input for number of bins 
  
  selectInput(inputId = 'typeofplace',label = 'select type of place',
              choices = list('city','town','village','hamlet'),selected = 'city'),
  
  mainPanel(
    plotlyOutput("distPlot")
  )
)


# Run the application 
#shinyApp(ui = ui, server = server)