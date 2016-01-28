# This function draw a map from GPS data

#THIS FOLLOWING PART IS TO DRAW A MAP WITH THE POINTS.
map.track <- function(col.points = "PuBuGn", long, lat, mov.param, asc = TRUE){
  #col.points, give the colour pallete for the colour to be used for GPS points. See 'function brewer.pal in package 'RColorBrewer' for details. Acceptable arguments are: Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu Reds YlGn YlGnBu YlOrBr YlOrRd
  #long and lat, the longitude and latitude of points.
  #mov.param, the movement paramater to plot. Must be numeric vector. 
  #asc, colour with darker colour for high value or low values?                      
  
  #Required packages for maps                     
  require(graphics)
  require(maps)
  require(mapdata)
  #Package to make colour palates
  require(RColorBrewer)

  #Make a colour scale with 100 shades.
  col.graph <-    colorRampPalette(brewer.pal(9,col.points))(100)
  
  
  #Determine range/ bounding for x and y axis. Here we choose the range of values for which the points represent plus some margin either side of this.
  long.bound    <- range(long)
  long.bound[1] <- long.bound[1] -  (0.35 * abs(long.bound[2]-long.bound[1]))
  long.bound[2] <- long.bound[2] +  (0.25 * abs(long.bound[2]-long.bound[1]))
  
  lat.bound <-  range(lat)
  lat.bound[1] <- lat.bound[1] -  (0.25 * abs(lat.bound[2]-lat.bound[1]))
  lat.bound[2] <- lat.bound[2] +  (0.25 * abs(lat.bound[2]-lat.bound[1]))
  
  #Draw background map
  map(database = "worldHires", regions = ".", fill = TRUE,
      col = "grey",bg = "white",bty="7", xlim = long.bound,
      ylim = lat.bound, boundary = FALSE)
#   ?map
  
  #Add GPS points to map, coloured by previously determined colour scale.
  if(asc == TRUE){                      
    points(long, lat, col = col.graph[100-abs(floor(mov.param*100))], cex = 0.4)
  } else points(long,lat,col = col.graph[abs(floor(mov.param*100))], cex = 0.4)
  
  # Add lines between GPS points, using same colour scheme as for points
  n <- length(long)
  if(asc == TRUE){
  segments(long[-1], lat[-1],
           long[1:n-1], lat[1:n-1],
           col = col.graph[100-abs(floor(mov.param*100))], lwd = 2)}else{
             segments(long[-1], lat[-1],
                      long[1:n-1], lat[1:n-1],
                      col = col.graph[abs(floor(mov.param*100))], lwd = 2)
           }
  
  
  #Add a border to the map.
  box()
  
  #Add axis and labels
  axis(side=(1),las=1)
  axis(side=(2),las=1)
  
  #Add a scale bar
  map.scale(ratio = FALSE,relwidth = 0.4, cex = 0.4)
}