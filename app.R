#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(terra)
#library(ggplot2)
#library(sf)
#library(geodata)
#library(plotly)


#ukr <- gadm(country="UKR", level=1, path=getwd())
#ukrplaces <- osm(country="UKR", "places", path=tempdir())

ukr <- readRDS("gadm41_UKR_1_pk.rds")
#ukrplaces <- st_read("UKR_places.gpkg")
ukrfood <- read.csv('wfp_food_prices_ukr.csv',sep =',',header = T,encoding = 'UTF-8')

vegfr <- ukrfood[ukrfood$date == '2022-08-15' & ukrfood$category == 'vegetables and fruits',]

#ukr_sf <- st_as_sf(ukr)
#ukrplaces_sf <- st_as_sf(ukrplaces)

#dk_map <- st_cast(ukr_sf, "MULTIPOLYGON")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Ukraine places"),

    sidebarLayout(
    # Sidebar with a slider input for number of bins 
    sidebarPanel(h3("Карта України"),
    selectInput(inputId = 'typeofplace',label = 'select type of place',
                choices = list("обласний центр"='city',"місто"='town',"село"='village',"хутір"='hamlet'),selected = 'city')),

        mainPanel('Карта України',
           plotOutput("distPlot")
        )
    )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      
      plot(ukr)
     # ggplot(data = ukr) + geom_sf() + 
        #geom_point(data = vegfr, aes(x = longitude, y = latitude, fill = market), size = 3, 
                     #shape = 16, color ='blue') 
            #geom_sf(data = ukrplaces_sf[ukrplaces_sf$place == input$typeofplace,], color = 'red')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
