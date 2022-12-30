# run.R

library(shiny)
library(dplyr)
library(leaflet)
library(DT)

port <- Sys.getenv('PORT')
shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)