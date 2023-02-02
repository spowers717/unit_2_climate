# SEP
# 2023-02-02
# Finish loops & arctic sea ice

library("lubridate")

# While Loops

x=1
while (x>0) {
  x=x+1
}
x
# did not give it a chance to escape and so the loop ran continuously

x=10
while (x>0) {
  x=x-1
  print(x)
}
# kept subtracting until x became zero

# fishing game

total_catch_lb = 0
n_fish = 0
while (total_catch_lb < 50) {
  n_fish = n_fish + 1
  new_fish_weight = rnorm(n= 1, mean= 2, sd= 1)
  total_catch_lb = total_catch_lb + new_fish_weight
}
# mean= average fish weight is 2 
n_fish #21 
total_catch_lb #51.32, throw back the 21st fish 

# ARCTIC SEA ICE EXTENT

url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'
arctic_ice = read.delim(url, 
                        skip=2, 
                        sep=",", 
                        header=FALSE, 
                        col.names = c("Year", "Month", "Day", 
                                      "Extent", "Missing", "Source_Data"))
head(arctic_ice)
tail(arctic_ice)

arctic_ice$date = make_date(year = arctic_ice$Year, 
                            month = arctic_ice$Month, 
                            day = arctic_ice$Day) # new column 
head(arctic_ice$date)

plot(Extent~date, data = arctic_ice, type= "l", ylab = "Arctic Sea Ice Extent (x10^6 km^2)")

# creating annual average

tail(arctic_ice)
arctic_ice_averages = data.frame(Year=seq(min(arctic_ice$Year)+1, 
                                          max(arctic_ice$Year)-1), 
                                 extent_annual_avg=NA, 
                                 extent_5yr_avg=NA)
head(arctic_ice_averages)
mean(arctic_ice$Extent[arctic_ice$Year == 1979])

seq(dim(arctic_ice_averages)[1])

for (i in seq(from= 1, to=dim(arctic_ice_averages)[1])) 
  {
  arctic_ice_averages$extent_annual_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year == arctic_ice_averages$Year[i]])
}

head(arctic_ice_averages)
tail(arctic_ice_averages)

plot(extent_annual_avg  ~ Year, data = arctic_ice_averages, type= "l")

# 5 yr average ice extent
dim(arctic_ice_averages)[1]-2

#to final row minus 2

for (i in seq(from=3, to=dim(arctic_ice_averages)[1]-2)) {
  years = seq(from=arctic_ice_averages$Year[i]-2, to=arctic_ice_averages$Year[i]+2)
  arctic_ice_averages$extent_5yr_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year %in% years])
}

head(arctic_ice_averages)
tail(arctic_ice_averages)


plot(extent_annual_avg  ~ Year, data = arctic_ice_averages, type= "l", col= "blue") +
lines(x=arctic_ice_averages$Year, y=arctic_ice_averages$extent_5yr_avg, col= "red")


arctic_ice_averages$date = make_date(year = arctic_ice_averages$Year, month = 7, day = 1)
head(arctic_ice_averages)

plot(Extent~date, data = arctic_ice, type= "l", ylab = "Arctic Sea Ice Extent (x10^6 km^2)") +
lines(extent_annual_avg  ~ date, data = arctic_ice_averages, type= "l", col= "blue") +
  lines(x=arctic_ice_averages$date, y=arctic_ice_averages$extent_5yr_avg, col= "red")










