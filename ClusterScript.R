# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(RSocrata) # For pulling the data straight off OpenData
require(Cairo)
require(ggplot2)
require(ggmap)
require(geosphere)
require(dplyr)

options(stringsAsFactors = FALSE)
GeoData = read.csv(file = "fibreloc.csv", header = TRUE)
MapBackground = get_map(location = c(172.639,-43.525), zoom = 7, scale = "auto", maptype = "roadmap", source =  "google")

Geo.Dist = function(df){
  d <- function(i, LatLongVector){
    distance <- rep(0, nrow(LatLongVector))
    distance[i:nrow(LatLongVector)] <- distHaversine(LatLongVector[i:nrow(LatLongVector), 1:2], LatLongVector[i,1:2])
    return(distance)
  }
  DistanceMatrix = do.call(cbind,lapply(1:nrow(df), d, df))
  return(DistanceMatrix)
}