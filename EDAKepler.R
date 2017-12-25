## EDA file for Exoplanet Analysis 

library(ggplot2)

## Read in the data 
exoData = read.csv(file="exoTrain.csv", header=TRUE, sep=",")

## Visualize light fluctuation for one star 

# Single vector for time -- Note that we must unlist the data to obtain a true vector 
exo.time = unlist(c(exoData[2,]))

# Single vector for time stamps
time.stamp = c(1:3198)

# Turn into a small dataframe (exactly one row)
exo.single.star = data.frame(time.stamp, exo.time)

# Graph a single star's light fluctuation
ggplot() + geom_line(aes(y = exo.time, x = time.stamp),colour = "green", 
                     data = exo.single.star, stat="identity") + 
  ylab("Light flux") + 
  xlab("Time stamp") + 
  ggtitle("Light fluctuation of star no. 1")

