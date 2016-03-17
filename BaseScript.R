# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(RSocrata) # For pulling the data straight off OpenData
options(stringsAsFactors = FALSE)
data = read.socrata(url = "https://opendata.socrata.com/resource/txu4-fsic.csv?$select=facility_id,latitude,longitude")
