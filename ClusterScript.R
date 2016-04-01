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