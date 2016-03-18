# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(RSocrata) # For pulling the data straight off OpenData
require(Cairo)
require(ggplot2)
require(ggmap)
require(dbscan)
options(stringsAsFactors = FALSE)
GeoData = read.socrata(url = "https://opendata.socrata.com/resource/txu4-fsic.csv?$select=longitude,latitude")
CairoWin()
MapBackground = get_map(location = c(-98.35,39.5), zoom = 4, scale = 2, maptype = "roadmap", source =  "google")
GeoClust = dbscan(GeoData, eps = 0.3, minPts = 4)
GeoData$Cluster = matrix(unlist(GeoClust$cluster), ncol = 1, byrow = TRUE)
View(GeoData)
ggmap(MapBackground) + geom_point(data = GeoData, aes(x = Longitude, y = Latitude, colour = Cluster), size = 0.01) +scale_colour_gradientn(colours = rainbow(40))
# kNNdistplot() Figure out a better way to plot this so we can line up the values and actually get a readable result
tempsubset = subset(GeoData, GeoData$Cluster > 0, select=c(Longitude, Latitude, Cluster)) # Subset to remove unclustered points
0 %in% tempsubset$Cluster # Neat way to check if an element exists in a list obvs dont need to do this due to previous line but it's here as a note
ggmap(MapBackground) + geom_point(data = tempsubset, aes(x = Longitude, y = Latitude, colour = Cluster), size = 0.001) +scale_colour_gradientn(colours = rainbow(40)) # Plot without unclustered points