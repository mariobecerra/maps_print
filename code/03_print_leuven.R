library(osmdata)
library(ggplot2)
library(dplyr)
library(showtext) # for custom fonts
library(here)

# Based on http://joshuamccrain.com/tutorials/maps/streets_tutorial.html

leuven_region = read.csv(here("data/leuven_region_box_coords.csv"))

font = "Monaco"

river_leuven = readRDS(here("out/river_leuven.rds"))
railway_leuven = readRDS(here("out/railway_leuven.rds"))
med_streets_leuven = readRDS(here("out/med_streets_leuven.rds"))
small_streets_leuven = readRDS(here("out/small_streets_leuven.rds"))
big_streets_leuven = readRDS(here("out/big_streets_leuven.rds"))






leuven_map_1 = ggplot() +
  geom_sf(data = river_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 2,
          alpha = 1) +
  geom_sf(data = railway_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          linetype="dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .7,
          alpha = .9) +
  geom_sf(data = med_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          alpha = 0.9) +
  geom_sf(data = small_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          alpha = .8) +
  coord_sf(xlim = leuven_region$lon,
           ylim = leuven_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#032B43",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "LEUVEN", subtitle = "50.8823°N, 4.7138°E")


ggsave(filename = here("out/leuven_map_1.png"), 
       plot = leuven_map_1,
       width = 50, height = 58, dpi = 300,
       units = "cm")







leuven_map_2 = ggplot() +
  geom_sf(data = river_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 4,
          alpha = 0.9) +
  geom_sf(data = railway_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          linetype="dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "azure2",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "azure2",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "azure2",
          size = 1,
          alpha = 1) +
  geom_text(data = data.frame(
    long = 4.687853582380545,
    lat = 50.86451711537329,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "white",
    size = 15,
    alpha = 1
  ) +
  coord_sf(xlim = leuven_region$lon,
           ylim = leuven_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#008b8b",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "LEUVEN", subtitle = "50.8823°N, 4.7138°E")

ggsave(filename = here("out/leuven_map_2.png"), 
       plot = leuven_map_2,
       width = 50, height = 58, dpi = 300,
       units = "cm")





leuven_map_3 = ggplot() +
  geom_sf(data = river_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "light blue",
          size = 4,
          alpha = 1) +
  geom_sf(data = railway_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          linetype="dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  geom_text(data = data.frame(
    long = 4.687853582380545,
    lat = 50.86451711537329,
    text = "x"), 
    aes(x = long, y = lat, label = text),
    inherit.aes = FALSE,
    color = "white",
    size = 15,
    alpha = 1
  ) +
  coord_sf(xlim = leuven_region$lon,
           ylim = leuven_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#008b8b",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "LEUVEN", subtitle = "50.8823°N, 4.7138°E")

ggsave(filename = here("out/leuven_map_3.png"), 
       plot = leuven_map_3,
       width = 50, height = 58, dpi = 300,
       units = "cm")









leuven_map_ijzerenmolenstraat1 = ggplot() +
  geom_sf(data = river_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 2,
          alpha = 1) +
  geom_sf(data = railway_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          linetype="dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .7,
          alpha = .9) +
  geom_sf(data = med_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          alpha = 0.9) +
  geom_sf(data = small_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = .5,
          alpha = .8) +
  # geom_sf(data = small_streets_leuven[["osm_lines"]] %>% 
  #           filter(name == "IJzerenmolenstraat"),
  #         inherit.aes = FALSE,
  #         color = "light grey",
  #         size = 2,
  #         alpha = 1) +
  geom_point(data = data.frame(
    long = 4.686294591749764,
    lat = 50.871628215262604), 
    aes(x = long, y = lat),
    inherit.aes = FALSE,
    color = "white",
    # shape = "square",
    size = 7,
    alpha = 1
  ) +
  coord_sf(xlim = leuven_region$lon,
           ylim = leuven_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 60, face="bold", vjust = 0.5, hjust = 0.5, family = font),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font),
        panel.background = element_rect(fill = "#032B43",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "LEUVEN", subtitle = "50.8823°N, 4.7138°E")


ggsave(filename = here("out/leuven_map_ijzerenmolenstraat1.png"), 
       plot = leuven_map_ijzerenmolenstraat1,
       width = 50, height = 58, dpi = 300,
       units = "cm")






leuven_map_ijzerenmolenstraat2 = ggplot() +
  geom_sf(data = river_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "steel blue",
          size = 4,
          alpha = 0.6) +
  geom_sf(data = railway_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .9,
          linetype = "dotdash",
          alpha = 1) +
  geom_sf(data = big_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "#990000",
          size = 1.2,
          alpha = 1) +
  geom_sf(data = med_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "#990000",
          size = 1,
          alpha = 1) +
  geom_sf(data = small_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "#990000",
          size = 1,
          alpha = 1) +
  geom_point(data = data.frame(
    long = 4.686294591749764,
    lat = 50.871628215262604), 
    aes(x = long, y = lat),
    inherit.aes = FALSE,
    color = "#5c0000",
    # shape = "square",
    size = 9,
    alpha = 1
  ) +
  coord_sf(xlim = leuven_region$lon,
           ylim = leuven_region$lat,
           expand = FALSE) +
  theme_void() + 
  theme(plot.title = element_text(size = 70, face = "bold", vjust = 0.5, hjust = 0.5, family = font, color = "#5c0000"),
        plot.subtitle = element_text(size = 40, hjust=.5, margin = margin(2, 0, 5, 0), family = font, color = "#5c0000"),
        panel.background = element_rect(fill = "white",
                                        size = 0.5, linetype = "solid")) +
  labs(title = "LEUVEN", subtitle = "50.8823°N, 4.7138°E")


ggsave(filename = here("out/leuven_map_ijzerenmolenstraat2.png"), 
       plot = leuven_map_ijzerenmolenstraat2,
       width = 50, height = 58, dpi = 300,
       units = "cm")
