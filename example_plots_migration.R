
# On first run install packages, after this you don't need to do this.
install.packages(c("mapdata", "graphics", "maps", "mapdata", "RColorBrewer"))

# Set working directory - *** Change this to where you have the data and R files ****
setwd("my_data_location")                 
# E.g. setwd("D:/Dropbox/R_projects/lbbg_gps")   #Must use / not \
                 
# Load GPS data
load("example_data.Rdata")

# see what data looks like
head(m1)

# Save the map to a pdf file, other options include PNG and WMF
pdf("map_example.pdf")

# Run function 'map.track' on our data
map.track(col.points = "PuRd", long = m1$longitude[f],
          lat = m1$latitude,
          mov.param = (m1$inst_ground_speed/ max(m1$inst_ground_speed)),
          asc = "TRUE")

# Close 'graphics device' - i.e. finish writing to file (pdf above).
dev.off()