
<!---
  ```{r data-pic8, echo = FALSE, out.width='100%', class = "text-image", fig.cap = "Site Map"}

knitr::include_graphics("images/cdm/CSIEM_Site_Map_v1.png")

```
--->
  

  ```{r echo=FALSE, message=FALSE, warning=FALSE}
library(leaflet)
library(leafem)
library(magrittr)
library(leaflet.extras)
library(htmlwidgets)
library(fontawesome)
library(sf)

dataset <- read.csv("maps/csiem_data/Obs/obs_maps.csv")

tfv <- sf::st_read("maps/csiem_data/Models/tfv_cockburn.geojson",quiet = TRUE)
plt <- sf::st_read("maps/csiem_data/Models/plotting_regions.geojson",quiet = TRUE)

dataset$colour <- NA
dataset$agencyLegend <- NA

colours <- c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854", "#ffd92f", "#e5c494", "#b3b3b3")
agency <- unique(dataset$Agency.ID)

for(i in 1:length(agency)){
  dataset[dataset[["Agency.ID"]]==agency[i],10] <- colours[i]
  dataset[dataset[["Agency.ID"]]==agency[i],11] <- paste0(agency[i], " <div style='position: relative; display: inline-block' class='circle'>",fa(name="circle", fill=colours[i]),"</div>")
}

leaflet::leaflet() %>%
  leaflet::addPolygons(
    data = tfv,
    group = "TUFLOW-FV",
    color = "#e41a1c",
    fillColor = "#e41a1c",
    opacity = 0.7,
    fillOpacity = 0.7,
    weight = 0,
    label = "CSIEM Model Extent"
  ) %>%
  leaflet::addPolygons(
    data = plt,
    group = "REGIONS",
    color = "#8da0cb",
    fillColor = "#8da0cb",
    opacity = 0.7,
    fillOpacity = 0.7,
    weight = 0,
    #label = plt$Name
    label = "Assessment Regions"
  ) %>%
  leaflet::addCircleMarkers(
    data = dataset,
    lat = dataset$Lat,
    lng = dataset$Lon,
    fillColor = dataset$colour,
    group = dataset$agencyLegend,
    color = "black",
    opacity = 0.2,
    fillOpacity = 1,
    radius = 4,
    weight = 1,
    label = dataset$Program,
    popup = paste(
      paste0("<b>",dataset$Agency,"</b>"),
      "<br>",
      "Program: ", dataset$Program,
      "<br>",
      "Data Classification: ", dataset$Data.Classification,
      "<br>",
      "Station ID: ", dataset$Station.ID
    )
  ) %>%
  leaflet::addLayersControl(
    baseGroups = c("None", "TUFLOW-FV", "REGIONS"),
    overlayGroups = dataset$agencyLegend,
    options = leaflet::layersControlOptions(collapsed = FALSE)
  ) %>%
  leafem::addLogo(
    img = "aed.png", # This image needs to be in /docs
    src = "remote",
    position = "bottomleft",
    width = 120,
    height = 47.76,
    offset.x = 10
  ) %>%
  leaflet::setView(
    lng = 115.72447,
    lat = -32.20063,
    zoom = 11
  ) %>%
  leaflet.extras::addFullscreenControl() %>%
  leaflet::addProviderTiles(providers$CartoDB.Positron) %>%
  htmlwidgets::onRender("
        function() {
            $('.leaflet-control-layers-overlays').prepend('<label style=\"text-align:center\"><b>Agencies</b></label>');
            $('.leaflet-control-layers-list').prepend('<label style=\"text-align:center\"><b>Model<br>Boundaries</b></label>');
        }
    ") %>%
  htmlwidgets::onRender("
    function(el, x) {
      this.on('baselayerchange', function(e) {
        e.layer.bringToBack();
      })
    }
  ")


```
