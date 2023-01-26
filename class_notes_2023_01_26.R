# SEP 2023-01-26
# logical, boolean, if/else

# these notes go with Boolean Logic Unit 2 and if else

vec = c(1, 0, 2, 1)
vec
vec[c(TRUE, FALSE, TRUE, FALSE)]

# practice logical operators

1>2 #false
1> c(0, 1, 2) # true false true
c(1,2,3)> c(3,2,1) #false false true have to be even sized vectors
c(1,2,3) == c(3,2,1) # false true false
1 %in% c(1,2,3) # true
c(1,3,5,7) %in% c(1,2,3) # true true false false (is 1,3,5, or 7 inside 1,2,3)

world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans
world_oceans$avg_depth_m > 4000 #which oceans are greater than 4000m 
# how can we grab these oceans that are greater than 4000m?
#subsets
deep_oceans = world_oceans[world_oceans$avg_depth_m > 4000, ] #beyond the comma is which column so [4000, 1 ] would give me just the first column of the ocean names
deep_oceans #subset of just the two oceans that meet my criteria
sum(world_oceans$avg_depth_m > 4000) # coercies true and falses into 1s and 0s and adds them up

#imprecise numerics
1+2 == 3 
0.1 + 0.2 == 0.3 # does not equal like it should, decimals are converted into binary forms and the binary for is not exactly 0.1 or 0.2 
0.3 - (0.1 + 0.2) # not zero 
# rewrite test
my_error = 0.0001
abs(0.3-(0.1 +0.2)) > my_error # is it greater than my error, no it is a very small number


# Boolean operators 
# several tests you want to answer at once, combines conditions
x = 5
x
x > 3 & x <15 # and 
x < 3 | x > 15 # or 
x < 10 & x %in%c(1,2,3) # and false
x < 10 | x %in%c(1,2,3) # or true

# subset
world_oceans[world_oceans$avg_depth_m > 4000 & world_oceans$area_km2 < 50e6,]
# both conditions are true
world_oceans[world_oceans$avg_depth_m > 4000 | world_oceans$area_km2 < 50e6,]
# either condition true for each 

z = c(TRUE, FALSE, FALSE)
z
any(z) # true
all(z) # false

# handling missing data 
NA == NA # instead of returning true it returns an NA 
is.na(NA)
vec = c(0, 1, 2, NA, 4)
is.na(vec) # tells you where with trues and false's
any( is.na(vec)) # are any of the conditions true is NA in the vector
!is.na(vec)


#######################################################
#. starting if/else statements
#######################################################

num = -2 

if(num < 0){
  num = num*-1
}

num
#changed num to equal 2 


num = 2 

if(num < 0){
  num = num*-1
}

num
# num stayed as 2


num = -2 

if(num < 0){
  print("Oh no, num is negative")
  num = num*-1
  print("don't worry, I made it positive")
}

num

if(num > 0){
  print("Oh no, num is negative")
  num = num*-1
  print("don't worry, I made it positive")
}

num
# if the condtions are true then it prints it


num = 100

if(num < 98.4){
  print("Not a fever")}
if(num > 99.5){ print("low fever")}
if(num > 102.1){print("high fever")}


#adding else

grade = 44

if(grade >= 60){
  print("you pass")
} else{
  print("you fail")
}


a= 87
b=87
if(a>b){print("A won")
}else if(a<b){print("B won")
    } else{print("A&B tied")}


#ifelse()

a = 7

ifelse(a!=0, 1/a, NA)

a = c(1, 0, 5, 7)

reciprocals = ifelse(a!=0, 1/a, NA)

cbind(a, reciprocals)











