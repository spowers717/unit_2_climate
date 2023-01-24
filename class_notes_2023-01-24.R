# SEP
# 2023-01-24
# Ice mass loss over poles

ant_ice_loss = read.table(file="data/antarctica_mass_200204_202209.txt",
                          skip=31, sep="", header = FALSE, 
                          col.names = c("decimal_date", "mass_Gt", "signma_Gt"))
                          #csv sep with comma
typeof(ant_ice_loss)
class(ant_ice_loss)
dim(ant_ice_loss)

grn_ice_loss = read.table(file="data/greenland_mass_200204_202209.txt", skip=31, 
                          sep="", header = FALSE, 
                          col.names = c("decimal_date", "mass_Gt", "signma_Gt"))
head(grn_ice_loss)
tail(grn_ice_loss) #way to check if your data looks right
summary(grn_ice_loss)


#plot it!
min(grn_ice_loss$mass_Gt) #getting the ranges of your data 
max(grn_ice_loss$mass_Gt)
range(grn_ice_loss$mass_Gt) #copy and paste into ylim

plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_Gt, type= "l", 
     xlab = "Year", ylab = "Antartic ice loss (Gt)", ylim =range(grn_ice_loss$mass_Gt)) #type "l" means line

lines(mass_Gt~decimal_date, data = grn_ice_loss, col= "red") #relied on a window that was already open

# data draws a straight line between the two missions, the line did not actually flatten out 
# insert NA 
# Add data break between Grace missions 

data_break = data.frame(decimal_date = 2018.0, mass_Gt = NA, signma_Gt = NA)

# Insert data break into ice loss dataframes

ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)

# Check the data
dim(ant_ice_loss)
dim(ant_ice_loss_with_NA)
dim(grn_ice_loss_with_NA)

# use order function to reorder the data for the entire frame
order(ant_ice_loss_with_NA$decimal_date)
# reorder the rows to look like the order function with 214 in the middle
ant_ice_loss_with_NA = ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_date), ]

tail(ant_ice_loss_with_NA) #check to see if the 2018 row 214 has been placed correctly


grn_ice_loss_with_NA = grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_date), ]



plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type= "l", 
     xlab = "Year", ylab = "Antartic ice loss (Gt)", ylim =range(grn_ice_loss$mass_Gt)) +
lines(mass_Gt~decimal_date, data = grn_ice_loss_with_NA, col= "red")

# plus sign groups functions or you can select all

# Error Bars!
head(ant_ice_loss_with_NA)
plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type= "l", 
     xlab = "Year", ylab = "Antartic ice loss (Gt)", ylim =range(grn_ice_loss$mass_Gt))
lines((mass_Gt + 2*signma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, lty= "dashed")
lines((mass_Gt - 2*signma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, lty= "dashed")


#saving plot to hard drive
pdf("figures/ice_mass_trends.pdf", width=7, height=5)
plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type= "l", 
     xlab = "Year", ylab = "Antartic ice loss (Gt)", ylim =range(grn_ice_loss$mass_Gt))
lines((mass_Gt + 2*signma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, lty= "dashed")
lines((mass_Gt - 2*signma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, lty= "dashed")
dev.off()

# Bar plot of total ice loss
min(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE) 
max(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE)
#remove NA so it does not give you the na as the lowest number

tot_ice_loss_ant = min(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE) - max(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE)

tot_ice_loss_grn = min(grn_ice_loss_with_NA$mass_Gt, na.rm=TRUE) - max(grn_ice_loss_with_NA$mass_Gt, na.rm=TRUE)

barplot(height =-1* c(tot_ice_loss_ant, tot_ice_loss_grn), names.arg = c("Antarctica", "Greenland"))
#multiply by -1 to flip the graph
#name the bars 




