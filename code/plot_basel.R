library(osmdata)
library(dplyr)
library(ggplot2)
library(here)


basel_region = read.csv(here("data/basel_region_box_coords.csv"))

font = "Monaco"

river_basel_filename = here("out/river_basel.rds")
railway_basel_filename = here("out/railway_basel.rds")
med_streets_basel_filename = here("out/med_streets_basel.rds")
small_streets_basel_filename = here("out/small_streets_basel.rds")
big_streets_basel_filename = here("out/big_streets_basel.rds")

opq_basel = opq(c(
  min(basel_region$lon), 
  min(basel_region$lat), 
  max(basel_region$lon), 
  max(basel_region$lat)))


if(file.exists(big_streets_basel_filename)){
  big_streets_basel = readRDS(big_streets_basel_filename)
} else{
  big_streets_basel <- opq_basel %>%
    add_osm_feature(key = "highway", 
                    value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
    osmdata_sf()
  
  saveRDS(big_streets_basel, big_streets_basel_filename)
  
}


if(file.exists(med_streets_basel_filename)){
  med_streets_basel = readRDS(med_streets_basel_filename)
} else{
  med_streets_basel <- opq_basel %>%
    add_osm_feature(key = "highway", 
                    value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
    osmdata_sf()
  
  saveRDS(med_streets_basel, med_streets_basel_filename)
}


if(file.exists(small_streets_basel_filename)){
  small_streets_basel = readRDS(small_streets_basel_filename)
} else{
  small_streets_basel <- opq_basel %>%
    add_osm_feature(key = "highway", 
                    value = c("residential", "living_street",
                              "unclassified",
                              "service", "footway"
                    )) %>%
    osmdata_sf()
  
  saveRDS(small_streets_basel, small_streets_basel_filename)
}


if(file.exists(river_basel_filename)){
  river_basel = readRDS(river_basel_filename)
} else{
  river_basel <- opq_basel %>%
    add_osm_feature(key = "waterway", value = "river") %>%
    osmdata_sf()
  
  saveRDS(river_basel, river_basel_filename)
}
  


if(file.exists(railway_basel_filename)){
  railway_basel = readRDS(railway_basel_filename)
} else{
  
  railway_basel <- opq_basel %>%
    add_osm_feature(key = "railway", value="rail") %>%
    osmdata_sf()
  
  saveRDS(railway_basel, railway_basel_filename)
}






basel_map1 = ggplot() +
  geom_sf(data = river_basel$osm_lines %>% 
            filter(name == "Rhein"),
          inherit.aes = FALSE,
          color = "steel blue",
          size = 13,
          alpha = 1) +
  geom_sf(data = river_basel$osm_lines %>% 
            filter(name != "Rhein"),
          inherit.aes = FALSE,
          color = "steel blue",
          size = 4,
          alpha = 1) +
  geom_sf(data = railway_basel$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .9,
          linetype = "dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_basel$osm_lines,
          inherit.aes = FALSE,
          color = "#610045",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_basel$osm_lines,
          inherit.aes = FALSE,
          color = "#610045",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_basel$osm_lines,
          inherit.aes = FALSE,
          color = "#610045",
          size = 1,
          alpha = 1) +
  geom_point(data = data.frame(
    long = 7.558076207405656,
    lat = 47.524302977276015), 
    aes(x = long, y = lat),
    inherit.aes = FALSE,
    color = "black",
    size = 9,
    alpha = 1
  ) +
  coord_sf(xlim = basel_region$lon,
           ylim = basel_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 70, face = "bold", vjust = 0.5, hjust = 0.5, family = font, color = "black"),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font, color = "black"),
        panel.background = element_rect(fill = "white",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "BASEL", subtitle = "47.5596°N, 7.5886°E")


ggsave(filename = here("out/basel_map_1.png"), 
       plot = basel_map1,
       width = 50, height = 58, dpi = 300,
       units = "cm")








basel_map2 = ggplot() +
  geom_sf(data = river_basel$osm_lines %>% 
            filter(name == "Rhein"),
          inherit.aes = FALSE,
          color = "steel blue",
          size = 13,
          alpha = 1) +
  geom_sf(data = river_basel$osm_lines %>% 
            filter(name != "Rhein"),
          inherit.aes = FALSE,
          color = "steel blue",
          size = 4,
          alpha = 1) +
  geom_sf(data = railway_basel$osm_lines,
          inherit.aes = FALSE,
          color = "grey",
          size = .9,
          linetype = "dotdash",
          alpha = 0.9) +
  geom_sf(data = big_streets_basel$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_basel$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_basel$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  geom_point(data = data.frame(
    long = 7.558076207405656,
    lat = 47.524302977276015), 
    aes(x = long, y = lat),
    inherit.aes = FALSE,
    color = "white",
    size = 9,
    alpha = 1
  ) +
  coord_sf(xlim = basel_region$lon,
           ylim = basel_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 70, face = "bold", vjust = 0.5, hjust = 0.5, family = font, color = "black"),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font, color = "black"),
        panel.background = element_rect(fill = "black",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "BASEL", subtitle = "47.5596°N, 7.5886°E")


ggsave(filename = here("out/basel_map_2.png"), 
       plot = basel_map2,
       width = 50, height = 58, dpi = 300,
       units = "cm")
