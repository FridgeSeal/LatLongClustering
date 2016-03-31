# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(RSocrata) # For pulling the data straight off OpenData
require(Cairo)
require(ggplot2)
require(ggmap)
require(geosphere)
require(dplyr)

options(stringsAsFactors = FALSE)
GeoData = read.csv(file = "fibreloc.csv", header = TRUE)
SampleGeo = sample_n(GeoData, 200000)
CairoWin()
MapBackground = get_map(location = c(172.639,-43.525), zoom = 7, scale = "auto", maptype = "roadmap", source =  "google")
#GeoClust = dbscan(GeoData, eps = 0.3, minPts = 4)
#GeoData$Cluster = matrix(unlist(GeoClust$cluster), ncol = 1, byrow = TRUE)
View(GeoData)
ggmap(MapBackground)
ggmap(MapBackground) + geom_point(data = GeoData, aes(x = GPS_X, y = GPS_Y, colour = Status), size = 0.01)
#ggmap(MapBackground) + geom_point(data = GeoData, aes(x = Longitude, y = Latitude, colour = Cluster), size = 0.01) +scale_colour_gradientn(colours = rainbow(40))
tempsubset = subset(GeoData, GeoData$Cluster > 0, select=c(Longitude, Latitude, Cluster)) # Subset to remove unclustered points
0 %in% tempsubset$Cluster # Neat way to check if an element exists in a list obvs dont need to do this due to previous line but it's here as a note
ggmap(MapBackground) + geom_point(data = tempsubset, aes(x = Longitude, y = Latitude, colour = Cluster), size = 0.001) +scale_colour_gradientn(colours = rainbow(40)) # Plot without unclustered points
dist.matrix = distm(GeoData, fun = distHaversine)

GeoSubset = subset(GeoData, select = c(GPS_X,GPS_Y))
# ClusterSet = kcca(GeoSubset, 15,dist = "distHaversine")
ClusterSet2 = kmeans(x = GeoSubset, centers = 15)
GeoSubset$Cluster = ClusterSet2$cluster