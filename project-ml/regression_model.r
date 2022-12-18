install.packages("mlbench")

# train KNN model
library(mlbench)
library(caret)
library(dplyr)

# K-Nearest Neighbors
data("BostonHousing")
View(BostonHousing)

#Regression Problem
# Data clean ?

mean(complete.cases(BostonHousing))  ##equal = 1 (clean)

#split data
split_data <- train_test_split(BostonHousing, 0.8)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

nrow(train_data); nrow(test_data)

#train model
set.seed(99)
ctrl <- trainControl(
  method = "repeatedcv",
  number = 5, #k=5
  repeats =5,
  verboseIter= TRUE #print log
  
)

#grid search
grid <- data.frame(k = c(3,7,9))   ##select k value by myself  -> ถ้าเลือก k น้อยมีค่า rmse ต่ำและเหมาะกับ train ได้ดี แต่ overfit ถ้าเพิ่มค่า k มีโอกาศที่จะ better model

knn_model <- train(
      medv~ nox + lstat + rm + indus,
      data = train_data,
      method = "knn",
      trControl = ctrl,
      #tuneLength =5 #no of k
      tuneGrid = grid
      )
plot(knn_model)

# score + evaluate model
p <- predict(knn_model,
             newdata = test_data)

RMSE(p, test_data$medv)

#train error = 5.53
#test error = 5.21
#good fit (mildly overfit)

#feature importance (which field is the most important)
varImp(knn_model) 

##quality of model depends on X which caused y indeed

# save model
saveRDS(knn_model, "knnModel.RDS")

# read model
model <- readRDS("knnModel.RDS")
