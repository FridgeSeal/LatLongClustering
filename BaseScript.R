# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(RSocrata) # For pulling the data straight off OpenData
require(Cairo)
require(ggplot2)
require(ggmap)
options(stringsAsFactors = FALSE)
GeoData = read.socrata(url = "https://opendata.socrata.com/resource/txu4-fsic.csv?$select=city,facility_id,latitude,longitude")
CairoWin()
MapBackground = get_map(location = c(-98.35,39.5), zoom = 4, scale = 2, maptype = "roadmap", source =  "google")
ggmap(MapBackground) + geom_point(data = GeoData, aes(x = Longitude, y = Latitude, colour = Facility.ID), size = 0.01)