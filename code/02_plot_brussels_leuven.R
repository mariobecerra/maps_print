library(osmdata)
library(ggplot2)
library(here)

# Based on http://joshuamccrain.com/tutorials/maps/streets_tutorial.html

leuven_region = read.csv(here("data/leuven_region_box_coords.csv"))
brussels_region = read.csv(here("data/brussels_region_box_coords.csv"))


river_leuven = readRDS(here("out/river_leuven.rds"))
railway_leuven = readRDS(here("out/railway_leuven.rds"))
med_streets_leuven = readRDS(here("out/med_streets_leuven.rds"))
small_streets_leuven = readRDS(here("out/small_streets_leuven.rds"))
big_streets_leuven = readRDS(here("out/big_streets_leuven.rds"))
river_brussels = readRDS(here("out/river_brussels.rds"))
railway_brussels = readRDS(here("out/railway_brussels.rds"))
med_streets_brussels = readRDS(here("out/med_streets_brussels.rds"))
small_streets_brussels = readRDS(here("out/small_streets_brussels.rds"))
big_streets_brussels = readRDS(here("out/big_streets_brussels.rds"))



ggplot() +
  geom_sf(data = river_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .8,
          alpha = 0.5) +
  geom_sf(data = railway_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          linetype="dotdash",
          alpha = 0.7) +
  geom_sf(data = med_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .5,
          alpha = 0.7) +
  geom_sf(data = small_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .7) +
  geom_sf(data = big_streets_leuven$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .7,
          alpha = .6) +
  coord_sf(xlim = leuven_region$lon,
           ylim = leuven_region$lat,
           expand = FALSE) +
  theme_void() + # get rid of background color, grid lines, etc.
  theme(plot.title = element_text(size = 15, face="bold", vjust = 1.5, hjust = 0.5)) +
  labs(title = "Leuven, Belgium")





ggplot() +
  geom_sf(data = river_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .8,
          alpha = 0.5) +
  geom_sf(data = railway_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          linetype="dotdash",
          alpha = 0.7) +
  geom_sf(data = med_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = 0.7) +
  geom_sf(data = small_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .7) +
  geom_sf(data = big_streets_brussels$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .6,
          alpha = .6) +
  coord_sf(xlim = brussels_region$lon,
           ylim = brussels_region$lat,
           expand = FALSE) +
  theme_void() + # get rid of background color, grid lines, etc.
  theme(plot.title = element_text(size = 15, face="bold", vjust = 1.5, hjust = 0.5)) +
  labs(title = "Brussels, Belgium")

