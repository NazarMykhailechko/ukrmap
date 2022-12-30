# init.R
#
# Example R code to install packages if not already installed
#

options(encoding = "UTF-8")

my_packages = c("shiny","dplyr","leaflet","DT", "terra", "raster", "rgdal")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}
invisible(sapply(my_packages, install_if_missing))