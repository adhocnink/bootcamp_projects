library(caret)

model1 <- lm(mpg ~ hp+wt,
             data = mtcars)

model1

#caret train()
model2 <- train(mpg ~ hp+wt,
      data = mtcars,
      method = "lm")   ## ML Algorithm

model2$finalModel

## ML Basic pipeline

#1. prepare /split data
split_data <- train_test_split(mtcars)
train_data <- split_data[[1]]
test_data <- split_data[[2]]


#2. train model
model <- train(mpg ~ hp+wt,
               data = train_data,
               method = "lm")



#3 score model / prediction
p_mpg <- predict(model, newdata = test_data)


#4 evaluate model
error <- p_mpg - test_data$mpg
( test_rmse <- sqrt(mean(error**2)) )

## check whether it's overfitting or not from difference between test_rmse and rmse of model

#5 Save model
saveRDS(model, "linearReg_model.RDS")   //To apply to use for another data

---------------------------- create function --------------------------------

train_test_split <- function (data, train_size = 0.8) {
  
  set.seed(24)
  n <- nrow(data)
  id <- sample(1:n, size = n*train_size)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  
  return(list(train_data, test_data))
  
}


---------------------------To apply for new data with the same model-------------------
#Load Model
model <- readRDS("linearReg_model.RDS")

# Batch prediction (Apply to New Data)    
nov_data <- data.frame(                   ##sample data
  id = 1:3,
  hp = c(200,150,188),
  wt = c(2.5,1.9,3.2)
)

nov_prediction <- predict(model, newdata = nov_data)

# create a new dataset with prediction
nov_data$pred <- nov_prediction
write.csv(nov_data, "resultNov.csv", row.names = F)
