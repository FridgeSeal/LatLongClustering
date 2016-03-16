# Basic R script to cluster/group some lat-longs about some predefined point and radius
require(RSocrata) # For pulling the data straight off OpenData 
data = read.socrata(url = "https://opendata.socrata.com/resource/txu4-fsic.json")
