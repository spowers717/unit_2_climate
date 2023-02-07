# SEP
# 2023-02-07
# defining functions and global temperatures


# user-defined functions

x = c(1,2,3)

# allow user to switch between arithmetic and geometric means
# creating a default perimeter with arithmetic=TRUE 
# If-else statement, prod= product
avg = function(x, arithmetic=TRUE){
  n = length(x)
  result = ifelse(arithmetic, sum(x)/n, prod(x)^(1/n)) # if arithmetic is false calculate the geometric mean
  return(result)
}

dat = c(1,3,5,7)
avg(dat) # 4
mean(dat) # 4
avg(dat, arithmetic = TRUE) # 4
avg(dat, arithmetic = FALSE) # 3.2 geometric mean
avg(arithmetic = FALSE, x= dat) # 3.2 change order
avg(FALSE, dat) # did not name the perimeters returns 0 0 0 0
avg(dat, FALSE) # did not name perimeters, but put it in the correct order = 3.2

# idiot proofing our avg function
avg = function(x, arithmetic=TRUE){
  if(!is.numeric(x)){
    stop("x must be numeric")
  }
  n = length(x)
  result = ifelse(arithmetic, sum(x)/n, prod(x)^(1/n)) 
  return(result)
}

dat = c(1,3,5,7)
avg(dat, FALSE)
avg(FALSE, dat)


letter = function(grade){
  if(grade >=90){
    return("A")
  } else if (grade>=80){
    return("B")
  } else if(grade>=70){
    return("C")
  } else if (grade>=60){
    return("D")
  }else{
    return("F")
  }
}

letter(67)



# temp_anomaly = read.table("data/global_temp_data_1880-2022.txt", skip=5, sep="", header = FALSE, col.names = c("Year", "No_Smoothing", "Lowess_5"))
url = 'https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt'

temp_anomaly = read.delim(url, 
                          skip=5, 
                          sep="", 
                          header=FALSE, 
                          col.names = c("Year", "No_Smoothing", "Lowess_5"))
class(temp_anomaly)

head(temp_anomaly)


temp1998 = temp_anomaly$No_Smoothing[temp_anomaly$Year==1998]
temp2012 = temp_anomaly$No_Smoothing[temp_anomaly$Year==2012]


plot(No_Smoothing ~ Year, data = temp_anomaly, type = "b", ylab = "Global Temp Anomaly") +
  lines(Lowess_5 ~ Year, data = temp_anomaly, col= "red", lwd=2) + 
  abline(v=1998, lty = "dashed") +
  abline(v=2012, lty = "dashed") +
  lines(c(temp1998, temp2012)~ c (1998, 2012), col ="blue", lwd = 2.5) # draw a line between these two points


calc_rolling_avg = function(data, moving_window=5){
  result= rep(NA, length(data))
  for(i in seq(from= moving_window , to=length(data) )){
    result[i] = mean(data[seq(from=(i-moving_window + 1) , to=i )])
  }
  return(result) }

temp_anomaly$avg_5_yr = calc_rolling_avg(data= temp_anomaly$No_Smoothing, moving_window=5)
temp_anomaly$avg_10_yr = calc_rolling_avg(data= temp_anomaly$No_Smoothing, moving_window=10)

plot(No_Smoothing ~ Year, data = temp_anomaly, type = "b", ylab = "Global Temp Anomaly") +
  lines(avg_5_yr ~ Year, data = temp_anomaly, col= "red", lwd=2) +
  lines(avg_10_yr ~ Year, data = temp_anomaly, col= "blue", lwd=2) 









