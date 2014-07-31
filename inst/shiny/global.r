library(shiny)
library(noncensus)
library(leaflet)
library(dplyr)

data(county_polygons)

county_data <- readRDS("data/data.rds")
extra_data <- readRDS("data/extras.rds")
fillColors <- extra_data$colors
leg_txt <- extra_data$legend
fill_name <- extra_data$old[1]
if(length(extra_data$old) > 1){
  cat_name <- extra_data$old[2]
  county_cats <- levels(factor(county_data$cat))
}
tile <- extra_data$bg_tile
if (is.na(tile)) tile <- NULL
attr <- extra_data$bg_attr
if (is.na(attr)) attr <- NULL

comp_two <- merge(county_polygons, county_data, by = "fips", all.x = T)
comp_two <- comp_two %>% arrange(group, order)

map_height <- ifelse(is.null(county_data$cat), "100%", 500)
