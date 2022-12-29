#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(sf)
library(pacman)
library(raster)
library(geodata)
library(plotly)

ukr <- gadm(country="UKR", level=1, path=getwd())
ukrplaces <- osm(country="UKR", "places", path=tempdir())

ukr_sf <- st_as_sf(ukr)
ukrplaces_sf <- st_as_sf(ukrplaces)

dk_map <- sf::st_cast(ukr_sf, "MULTIPOLYGON")

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

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlotly({
      ggplotly(ggplot(data = dk_map) + geom_sf() + 
                 geom_sf(data = ukrplaces_sf[ukrplaces_sf$place == input$typeofplace,]),width = 800,height = 600)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
