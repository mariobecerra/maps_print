library(osmdata)
library(ggplot2)
library(here)

# Based on http://joshuamccrain.com/tutorials/maps/streets_tutorial.html

brussels_region = read.csv(here("data/brussels_region_box_coords.csv"))

font = "Monaco"

river_brussels = readRDS(here("out/river_brussels.rds"))
railway_brussels = readRDS(here("out/railway_brussels.rds"))
med_streets_brussels = readRDS(here("out/med_streets_brussels.rds"))
small_streets_brussels = readRDS(here("out/small_streets_brussels.rds"))
big_streets_brussels = readRDS(here("out/big_streets_brussels.rds"))



brussels_map = ggplot() +
  geom_sf(data = river_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "grey",
          size = 2.5,
          alpha = 0.6) +
  geom_sf(data = railway_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          linetype = "dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .7,
          alpha = .8) +
  geom_sf(data = med_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .4,
          alpha = 0.7) +
  geom_sf(data = small_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .1,
          alpha = 0.6) +
  coord_sf(xlim = brussels_region$lon,
           ylim = brussels_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#032B43",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "BRUSSELS", subtitle = "50.8476°N, 4.3572°E")



ggsave(filename = here("out/brussels_map.png"), 
       plot = brussels_map,
       width = 50, height = 55, dpi = 300,
       units = "cm")









brussels_map_2 = ggplot() +
  geom_sf(data = river_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "grey",
          size = 2.5,
          alpha = 0.6) +
  geom_sf(data = railway_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          linetype = "dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .7,
          alpha = .8) +
  geom_sf(data = med_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .4,
          alpha = 0.7) +
  geom_sf(data = small_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .1,
          alpha = 0.6) +
  geom_text(data = data.frame(
    long = 4.346683867688853,
    lat = 50.85128454860801,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "white",
    size = 8,
    alpha = 1
  ) +
  coord_sf(xlim = brussels_region$lon,
           ylim = brussels_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#032B43",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "BRUSSELS", subtitle = "50.8476°N, 4.3572°E")



ggsave(filename = here("out/brussels_map_2.png"), 
       plot = brussels_map_2,
       width = 50, height = 55, dpi = 300,
       units = "cm")






brussels_map_3 = ggplot() +
  geom_sf(data = river_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = 2.5,
          alpha = 0.9) +
  geom_sf(data = railway_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "grey",
          size = .6,
          linetype = "dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .7,
          alpha = .9) +
  geom_sf(data = med_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          alpha = 0.7) +
  geom_sf(data = small_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .2,
          alpha = 0.6) +
  geom_text(data = data.frame(
    long = 4.346683867688853,
    lat = 50.85128454860801,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "white",
    size = 8,
    alpha = 1
  ) +
  coord_sf(xlim = brussels_region$lon,
           ylim = brussels_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#032B43",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "BRUSSELS", subtitle = "50.8476°N, 4.3572°E")



ggsave(filename = here("out/brussels_map_3.png"), 
       plot = brussels_map_3,
       width = 50, height = 55, dpi = 300,
       units = "cm")
