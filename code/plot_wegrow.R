library(osmdata)
library(dplyr)
library(ggplot2)
library(here)


wegrow_region = read.csv(here("data/wegrow_region_box_coords.csv"))


river_wegrow_filename = here("out/wegrow_river.rds")
# railway_wegrow_filename = here("out/wegrow_railway.rds")
med_streets_wegrow_filename = here("out/wegrow_med_streets.rds")
small_streets_wegrow_filename = here("out/wegrow_small_streets.rds")
big_streets_wegrow_filename = here("out/wegrow_big_streets.rds")

opq_wegrow = opq(c(
  min(wegrow_region$lon), 
  min(wegrow_region$lat), 
  max(wegrow_region$lon), 
  max(wegrow_region$lat)))


if(file.exists(big_streets_wegrow_filename)){
  big_streets_wegrow = readRDS(big_streets_wegrow_filename)
} else{
  big_streets_wegrow <- opq_wegrow %>%
    add_osm_feature(key = "highway", 
                    value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
    osmdata_sf()
  
  saveRDS(big_streets_wegrow, big_streets_wegrow_filename)
  
}


if(file.exists(med_streets_wegrow_filename)){
  med_streets_wegrow = readRDS(med_streets_wegrow_filename)
} else{
  med_streets_wegrow <- opq_wegrow %>%
    add_osm_feature(key = "highway", 
                    value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
    osmdata_sf()
  
  saveRDS(med_streets_wegrow, med_streets_wegrow_filename)
}


if(file.exists(small_streets_wegrow_filename)){
  small_streets_wegrow = readRDS(small_streets_wegrow_filename)
} else{
  small_streets_wegrow <- opq_wegrow %>%
    add_osm_feature(key = "highway", 
                    value = c("residential", "living_street",
                              "unclassified",
                              "service", "footway"
                    )) %>%
    osmdata_sf()
  
  saveRDS(small_streets_wegrow, small_streets_wegrow_filename)
}


if(file.exists(river_wegrow_filename)){
  river_wegrow = readRDS(river_wegrow_filename)
} else{
  river_wegrow <- opq_wegrow %>%
    add_osm_feature(key = "waterway", value = "river") %>%
    osmdata_sf()
  
  saveRDS(river_wegrow, river_wegrow_filename)
}



# if(file.exists(railway_wegrow_filename)){
#   railway_wegrow = readRDS(railway_wegrow_filename)
# } else{
#   
#   railway_wegrow <- opq_wegrow %>%
#     add_osm_feature(key = "railway", value="rail") %>%
#     osmdata_sf()
#   
#   saveRDS(railway_wegrow, railway_wegrow_filename)
# }










wegrow_map_1 = ggplot() +
  geom_sf(data = river_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "steel blue",
          size = 4,
          alpha = 1) +
  # geom_sf(data = railway_wegrow$osm_lines,
  #         inherit.aes = FALSE,
  #         color = "grey",
  #         size = .9,
  #         linetype = "dotdash",
  #         alpha = 0.9) +
  geom_sf(data = big_streets_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  coord_sf(xlim = wegrow_region$lon,
           ylim = wegrow_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(panel.background = element_rect(fill = "black",
                                        size = 0.5, linetype = "solid"))


ggsave(filename = here("out/wegrow_map_1.png"), 
       plot = wegrow_map_1,
       width = 50, height = 58, dpi = 300,
       units = "cm")















wegrow_map_2 = ggplot() +
  geom_sf(data = river_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "steel blue",
          size = 4,
          alpha = 0.6) +
  geom_sf(data = big_streets_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "#990000",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "#990000",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_wegrow$osm_lines,
          inherit.aes = FALSE,
          color = "#990000",
          size = 1,
          alpha = 1) +
  geom_point(data = data.frame(
    long = 22.011024,
    lat = 52.401794), 
    aes(x = long, y = lat),
    inherit.aes = FALSE,
    color = "#5c0000",
    # shape = "square",
    size = 9,
    alpha = 1
  ) +
  coord_sf(xlim = wegrow_region$lon,
           ylim = wegrow_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(panel.background = element_rect(fill = "white",
                                        size = 0.5, linetype = "solid"))






ggsave(filename = here("out/wegrow_map_2.png"), 
       plot = wegrow_map_2,
       width = 50, height = 58, dpi = 300,
       units = "cm")
