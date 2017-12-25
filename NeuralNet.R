## File designed to fit a Neural Network on Exo-planet data

# Read in the data 
exoData = read.csv(file="exoTrain.csv", header=TRUE, sep=",")
exoTestData = read.csv(file = "exoTest.csv", header=TRUE, sep=",")

# Scale (min - max method) the training data for use in the neural network 
max = apply(exoData , 2 , max)
min = apply(exoData, 2 , min)
scaledExo = as.data.frame(scale(exoData, center = min, scale = max - min))

# Apply same scaling to testing data
max = apply(exoTestData , 2 , max)
min = apply(exoTestData, 2 , min)
scaledTest = as.data.frame(scale(exoTestData, center = min, scale = max - min))

# Acquire Neural Net Packages 
library(neuralnet)

## Fitting the neural network

# Prepare a comprehensive formula for the network 
n <- names(exoData)
f <- as.formula(paste("LABEL~", paste(n[!n %in% c("LABEL")], collapse = " + ")))
# -- This has over 3000 entries so leaing only as an option for those with higher computing 
# -- power. 

set.seed(2)

# Fit the network -- These variables of fluctuation were chosen randomly 
NN = neuralnet(LABEL ~ FLUX.1 + FLUX.100 + FLUX.1000 + FLUX.2000 + FLUX.3000, data= scaledExo, hidden = 2 , linear.output = T )

# Plot the neural network
plot(NN)

# Check predictive quality of the model 
predict_testNN = compute(NN, scaledTest[,c(1:5)])
predict_testNN = (predict_testNN$net.result * (max(exoData$LABEL) - min(exoData$LABEL))) + min(exoData$LABEL)

plot(scaledTest$LABEL, predict_testNN, col='blue', pch=16, ylab = "predicted rating NN", xlab = "real rating")

abline(0,1)

# Calculate Root Mean Square Error (RMSE)
RMSE.NN = (sum((scaledTest$LABEL - predict_testNN)^2) / nrow(scaledTest)) ^ 0.5
