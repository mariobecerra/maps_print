library(osmdata)
library(ggplot2)
library(here)

# Based on http://joshuamccrain.com/tutorials/maps/streets_tutorial.html

leuven_region = read.csv(here("data/leuven_region_box_coords.csv"))

brussels_region = read.csv(here("data/brussels_region_box_coords.csv"))




opq_leuven = opq(c(
  min(leuven_region$lon), 
  min(leuven_region$lat), 
  max(leuven_region$lon), 
  max(leuven_region$lat)))


big_streets_leuven <- opq_leuven %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
  osmdata_sf()



med_streets_leuven <- opq_leuven %>%
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
  osmdata_sf()


small_streets_leuven <- opq_leuven %>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway"
                  )) %>%
  osmdata_sf()


river_leuven <- opq_leuven %>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

railway_leuven <- opq_leuven %>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()












opq_brussels = opq(c(
  min(brussels_region$lon), 
  min(brussels_region$lat), 
  max(brussels_region$lon), 
  max(brussels_region$lat)))


big_streets_brussels <- opq_brussels %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
  osmdata_sf()



med_streets_brussels <- opq_brussels %>%
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
  osmdata_sf()


small_streets_brussels <- opq_brussels %>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway"
                  )) %>%
  osmdata_sf()


river_brussels <- opq_brussels %>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

railway_brussels <- opq_brussels %>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()




saveRDS(river_leuven, here("out/river_leuven.rds"))
saveRDS(railway_leuven, here("out/railway_leuven.rds"))
saveRDS(med_streets_leuven, here("out/med_streets_leuven.rds"))
saveRDS(small_streets_leuven, here("out/small_streets_leuven.rds"))
saveRDS(big_streets_leuven, here("out/big_streets_leuven.rds"))

saveRDS(river_brussels, here("out/river_brussels.rds"))
saveRDS(railway_brussels, here("out/railway_brussels.rds"))
saveRDS(med_streets_brussels, here("out/med_streets_brussels.rds"))
saveRDS(small_streets_brussels, here("out/small_streets_brussels.rds"))
saveRDS(big_streets_brussels, here("out/big_streets_brussels.rds"))

