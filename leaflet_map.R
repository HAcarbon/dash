# leaflet maps

#### leaflet map prep 
office_icon = makeIcon("images/agridat.png","images/agridat.png", 50, 50)
dairy_icon = makeIcon("images/dairy.png", "images/dairy.png", 50, 50 )
robot_icon = makeIcon("images/robot.png","images/robot.png", 50, 50)
beef_icon = makeIcon("images/beef.png","images/beef.png", 50, 50)
sheep_icon = makeIcon("images/sheep.png","images/sheep.png", 50, 50)
pig_icon = makeIcon("images/pig.png","images/pig.png", 50, 50)
uni_icon = makeIcon("images/graduation-hat.png","images/graduation-hat.png",50,50)

dairy_data <- carbon_data %>%
  filter(lineitem_code == "DAIRY" & Year == latest_year) 


dairy_popup <- paste("<strong>Dairy Unit</strong>", "</br>", 
                     "Year:", latest_year, "</br>",
                     "Total CO<sub>2</sub>e :", my_comma(dairy_data$total_co2e_emissions_from_farming_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total direct carbon:", my_comma(dairy_data$co2_direct_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total indirect carbon:",my_comma(dairy_data$co2_indirect_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total methane:",my_comma(dairy_data$methane_total_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total nitrous oxide:", my_comma(dairy_data$nitrous_oxide_total_kgco2e/1000), "t CO<sub>2</sub>e")


beef_data <- carbon_data %>%
  filter(lineitem_code == "BEEF" & Year == latest_year) 


beef_popup <- paste("<strong>Beef Unit</strong>", "</br>", 
                    "Year:", latest_year, "</br>",
                    "Total CO<sub>2</sub>e :", my_comma(beef_data$total_co2e_emissions_from_farming_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                    "Total direct carbon:", my_comma(beef_data$co2_direct_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                    "Total indirect carbon:",my_comma(beef_data$co2_indirect_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                    "Total methane:",my_comma(beef_data$methane_total_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                    "Total nitrous oxide:", my_comma(beef_data$nitrous_oxide_total_kgco2e/1000), "t CO<sub>2</sub>e")

sheep_data <- carbon_data %>%
  filter(lineitem_code == "SHEEP" & Year == latest_year) 


sheep_popup <- paste("<strong>Sheep Unit</strong>", "</br>", 
                     "Year:", latest_year, "</br>",
                     "Total CO<sub>2</sub>e :", my_comma(sheep_data$total_co2e_emissions_from_farming_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total direct carbon:", my_comma(sheep_data$co2_direct_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total indirect carbon:",my_comma(sheep_data$co2_indirect_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total methane:",my_comma(sheep_data$methane_total_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                     "Total nitrous oxide:", my_comma(sheep_data$nitrous_oxide_total_kgco2e/1000), "t CO<sub>2</sub>e")

pig_data <- carbon_data %>%
  filter(lineitem_code == "PIGS" & Year == latest_year) 


pig_popup <- paste("<strong>Pig Unit</strong>", "</br>", 
                   "Year:", latest_year, "</br>",
                   "Total CO<sub>2</sub>e :", my_comma(pig_data$total_co2e_emissions_from_farming_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                   "Total direct carbon:", my_comma(pig_data$co2_direct_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                   "Total indirect carbon:",my_comma(pig_data$co2_indirect_co2_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                   "Total methane:",my_comma(pig_data$methane_total_kgco2e/1000), "t CO<sub>2</sub>e", "</br>",
                   "Total nitrous oxide:", my_comma(pig_data$nitrous_oxide_total_kgco2e/1000), "t CO<sub>2</sub>e")


office_popup <- paste("Click the animal icons for info!")



carbon_map <- leaflet(carbon_data) %>%
  fitBounds(lng1 = -2.435130, lat1 = 52.779020, lng2 = -2.429167, lat2 = 52.781648 ) %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-2.427, lat=52.779, popup="Harper Adams University", icon = uni_icon) %>%
  addMarkers(lng=-2.434319, lat=52.780052, popup=dairy_popup, icon = dairy_icon ) %>%
  #addMarkers(lng=-2.432867, lat=52.780706, popup="Robot dairy unit", icon = robot_icon ) %>%
  addMarkers(lng=-2.430173, lat=52.779969, popup=pig_popup, icon = pig_icon) %>%
  addMarkers(lng=-2.430597, lat=52.780818, popup=sheep_popup, icon = sheep_icon) %>%
  addMarkers(lng=-2.430253, lat=52.780475, popup=beef_popup, icon = beef_icon) %>%
  
  addMarkers(lng=-2.432260, 
             lat=52.779504, 
             popup = office_popup, 
             icon = office_icon
  ) %>%
  
  
  # addMarkers(lng = -2.433879, lat = 52.780927, label = "Click on an icon for summary information", labelOptions = labelOptions(noHide = T)) %>%
  addScaleBar(position = "bottomright") 