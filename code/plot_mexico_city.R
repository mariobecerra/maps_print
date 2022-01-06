library(osmdata)
library(dplyr)
library(ggplot2)
library(rgdal)
library(here)




# municipios_shp <- readOGR("~/Dropbox/Mario/Work/Datos/Shapefiles/Municipios_2013/",
#                           layer = "Municipios_2013") %>%
#   spTransform(CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
# 
# alcaldias_cdmx = subset(municipios_shp, CVE_ENT == "09")



# states_shp <- readOGR("~/Dropbox/Mario/Work/Datos/Shapefiles/Entidades_2010_5A/",
#                       layer = "Entidades_2010_5A") %>%
#   spTransform(CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
# 
# cdmx_shp = subset(states_shp, CVE_ENT == "09")

# Shapefile for Mexico City
cdmx_shp = readRDS(here("data/mexico_city_shapefile.rds"))



cdmx_region_coords = read.csv(here("data/mexico_city_box_coords.csv"))

river_cdmx_filename = here("out/river_cdmx.rds")
railway_cdmx_filename = here("out/railway_cdmx.rds")
med_streets_cdmx_filename = here("out/med_streets_cdmx.rds")
small_streets_cdmx_filename = here("out/small_streets_cdmx.rds")
big_streets_cdmx_filename = here("out/big_streets_cdmx.rds")
green_areas_cdmx_filename = here("out/green_areas_cdmx.rds")


opq_cdmx = opq(c(
  min(cdmx_region_coords$lon), 
  min(cdmx_region_coords$lat), 
  max(cdmx_region_coords$lon), 
  max(cdmx_region_coords$lat)))


if(file.exists(big_streets_cdmx_filename)){
  big_streets_cdmx = readRDS(big_streets_cdmx_filename)
} else{
  big_streets_cdmx <- opq_cdmx %>%
    add_osm_feature(key = "highway", 
                    value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
    osmdata_sf()
  
  saveRDS(big_streets_cdmx, big_streets_cdmx_filename)
  
}


if(file.exists(med_streets_cdmx_filename)){
  med_streets_cdmx = readRDS(med_streets_cdmx_filename)
} else{
  med_streets_cdmx <- opq_cdmx %>%
    add_osm_feature(key = "highway", 
                    value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
    osmdata_sf()
  
  saveRDS(med_streets_cdmx, med_streets_cdmx_filename)
}


if(file.exists(small_streets_cdmx_filename)){
  small_streets_cdmx = readRDS(small_streets_cdmx_filename)
} else{
  small_streets_cdmx <- opq_cdmx %>%
    add_osm_feature(key = "highway", 
                    value = c("residential", "living_street",
                              "unclassified",
                              "service", "footway"
                    )) %>%
    osmdata_sf()
  
  saveRDS(small_streets_cdmx, small_streets_cdmx_filename)
}



if(file.exists(green_areas_cdmx_filename)){
  green_areas_cdmx = readRDS(green_areas_cdmx_filename)
} else{
  green_areas_cdmx <- opq_cdmx %>%
    add_osm_feature(key = "leisure", 
                    value = c("dog_park", "garden", "golfcourse", "nature_reserve", "park", "playground")) %>%
    osmdata_sf()
  
  saveRDS(green_areas_cdmx, green_areas_cdmx_filename)
}



# if(file.exists(river_cdmx_filename)){
#   river_cdmx = readRDS(river_cdmx_filename)
# } else{
#   river_cdmx <- opq_cdmx %>%
#     add_osm_feature(key = "waterway", value = "river") %>%
#     osmdata_sf()
#   
#   saveRDS(river_cdmx, river_cdmx_filename)
# }
# 
# 
# 
# if(file.exists(railway_cdmx_filename)){
#   railway_cdmx = readRDS(railway_cdmx_filename)
# } else{
#   
#   railway_cdmx <- opq_cdmx %>%
#     add_osm_feature(key = "railway", value="rail") %>%
#     osmdata_sf()
#   
#   saveRDS(railway_cdmx, railway_cdmx_filename)
# }






cdmx_map_1 = ggplot() +
  geom_polygon(
    data = cdmx_shp,
    inherit.aes = FALSE,
    aes(x = long, y = lat, group = group),
    fill = "black",
    color = "grey",
    size = 0.1) +
  geom_sf(data = green_areas_cdmx$osm_polygons,
          inherit.aes = FALSE,
          color = "dark green",
          fill = "dark green",
          size = 0.6,
          alpha = 0.8) +
  geom_sf(data = big_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.9,
          alpha = 0.8) +
  geom_sf(data = med_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.7,
          alpha = 0.7) +
  geom_text(data = data.frame(
    long = -99.111235, 
    lat = 19.295702,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "red",
    size = 8,
    alpha = 1
  ) +
  coord_sf(xlim = cdmx_region_coords$lon,
           ylim = cdmx_region_coords$lat,
           expand = FALSE) +
  theme_void() + 
  theme(panel.background = element_rect(fill = "#3e3a3a",
                                        size = 0.5, linetype = "solid")) 


ggsave(filename = here("out/cdmx_map_1.png"), 
       plot = cdmx_map_1,
       width = 50, height = 58, dpi = 300,
       units = "cm")








cdmx_map_2 = ggplot() +
  geom_polygon(
    data = cdmx_shp,
    inherit.aes = FALSE,
    aes(x = long, y = lat, group = group),
    fill = "black",
    color = "grey",
    size = 0.1) +
  geom_sf(data = big_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.9,
          alpha = 0.8) +
  geom_sf(data = med_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.7,
          alpha = 0.7) +
  geom_sf(data = small_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.6,
          alpha = 0.6) +
  # geom_point(data = data.frame(
  #   long = -99.111235, 
  #   lat = 19.295702),
  #   aes(x = long, y = lat),
  #   inherit.aes = FALSE,
  #   color = "white",
  #   size = 9,
  #   alpha = 1
  # ) +
  geom_text(data = data.frame(
    long = -99.111235, 
    lat = 19.295702,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "red",
    size = 8,
    alpha = 1
  ) +
  coord_sf(xlim = cdmx_region_coords$lon,
           ylim = cdmx_region_coords$lat,
           expand = FALSE) +
  theme_void() + 
  theme(panel.background = element_rect(fill = "#3e3a3a",
                                        size = 0.5, linetype = "solid")) 


ggsave(filename = here("out/cdmx_map_2.png"), 
       plot = cdmx_map_2,
       width = 50, height = 58, dpi = 300,
       units = "cm")







cdmx_map_3 = ggplot() +
  geom_polygon(
    data = cdmx_shp,
    inherit.aes = FALSE,
    aes(x = long, y = lat, group = group),
    fill = "black",
    color = "grey",
    size = 0.1) +
  geom_sf(data = big_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.9,
          alpha = 0.8) +
  geom_sf(data = med_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.7,
          alpha = 0.7) +
  # geom_sf(data = small_streets_cdmx$osm_lines,
  #         inherit.aes = FALSE,
  #         color = "white",
  #         size = 0.6,
  #         alpha = 0.6) +
  geom_text(data = data.frame(
    long = -99.111235, 
    lat = 19.295702,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "red",
    size = 8,
    alpha = 1
  ) +
  coord_sf(xlim = cdmx_region_coords$lon,
           ylim = cdmx_region_coords$lat,
           expand = FALSE) +
  theme_void() + 
  theme(panel.background = element_rect(fill = "#3e3a3a",
                                        size = 0.5, linetype = "solid")) 


ggsave(filename = here("out/cdmx_map_3.png"), 
       plot = cdmx_map_3,
       width = 50, height = 58, dpi = 300,
       units = "cm")













cdmx_map_4 = ggplot() +
  geom_polygon(
    data = cdmx_shp,
    inherit.aes = FALSE,
    aes(x = long, y = lat, group = group),
    fill = "black",
    color = "grey",
    size = 0.1) +
  geom_sf(data = big_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.7,
          alpha = 0.8) +
  geom_sf(data = med_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.4,
          alpha = 0.7) +
  geom_sf(data = small_streets_cdmx$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 0.2,
          alpha = 0.4) +
  geom_text(data = data.frame(
    long = -99.111235, 
    lat = 19.295702,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "red",
    size = 8,
    alpha = 1
  ) +
  coord_sf(xlim = cdmx_region_coords$lon,
           ylim = cdmx_region_coords$lat,
           expand = FALSE) +
  theme_void() + 
  theme(panel.background = element_rect(fill = "#3e3a3a",
                                        size = 0.5, linetype = "solid")) 


ggsave(filename = here("out/cdmx_map_4.png"), 
       plot = cdmx_map_4,
       width = 50, height = 58, dpi = 300,
       units = "cm")