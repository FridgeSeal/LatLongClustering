# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(Cairo)
require(ggplot2)
require(ggmap)
require(geosphere)
require(dplyr)
require(DescTools)

options(stringsAsFactors = FALSE)

GeoData = read.csv(file = "fibreloc.csv", header = TRUE)
GeoCentres = read.csv(file = "ClusterCentres.csv", header = TRUE)
MapBackground = get_map(location = c(174.7633,-36.8485), zoom = 5, scale = "auto", maptype = "roadmap", source =  "google")
BlankList = vector(mode = "numeric",15)
GetClosest = function(templist, baseset, tempvector, a, b){ #a = 3,4 b = 2, 3
  for(i in 1:15){
    templist[i] = Closest(as.vector(baseset[,a]), tempvector[i,b])
  }
  return(templist)
}

NewCentres = as.matrix(data.frame(GetClosest(BlankList, GeoData, GeoCentres, 3, 2), GetClosest(BlankList, GeoData, GeoCentres, 4, 3)))
colnames(NewCentres) = c("Longitude", "Latitude")
Cluster = kmeans(x = as.matrix(GeoData[,3:4]), centers = NewCentres)
GeoData$Cluster = Cluster$cluster
write.table(GeoData, file = "GeoData.csv", sep = ",", row.names = FALSE)
write.table(Cluster$centers, file = "Cluster_Centres.csv", sep = ",", row.names = FALSE)
Cluster1 = subset(GeoData, Cluster == 1, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster2 = subset(GeoData, Cluster == 2, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster3 = subset(GeoData, Cluster == 3, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster4 = subset(GeoData, Cluster == 4, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster5 = subset(GeoData, Cluster == 5, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster6 = subset(GeoData, Cluster == 6, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster7 = subset(GeoData, Cluster == 7, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster8 = subset(GeoData, Cluster == 8, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster9 = subset(GeoData, Cluster == 9, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster10 = subset(GeoData, Cluster == 10, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster11 = subset(GeoData, Cluster == 11, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster12 = subset(GeoData, Cluster == 12, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster13 = subset(GeoData, Cluster == 13, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster14 = subset(GeoData, Cluster == 14, select = c(ID, Status, GPS_X, GPS_Y, Cluster))
Cluster15 = subset(GeoData, Cluster == 15, select = c(ID, Status, GPS_X, GPS_Y, Cluster))