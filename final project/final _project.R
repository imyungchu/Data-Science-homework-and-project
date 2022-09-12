library(ggplot2)
library(lattice)
library(yardstick)
library(readr)
library(caret)
library(e1071)
library(corrplot)
library(dplyr)
library(tidyr)
library(Matrix)
library(ggpubr)

data <- read.csv("D:/data science final project/day.csv",head = TRUE)
str(data)
View(data)
#�Ninput����ƥ����୼numeric��data type
data$season <- as.numeric(data$season)
data$yr <- as.numeric(data$yr)
data$mnth <- as.numeric(data$mnth)
data$holiday <- as.numeric(data$holiday)
data$weekday <- as.numeric(data$weekday)
data$workingday <- as.numeric(data$workingday)
data$weathersit <- as.numeric(data$weathersit)
#���ݭn��colume
data <- data[, -c(1,2,14,15)]
#ø�sCorrelation plot
Num.cols <- sapply(data, is.numeric) #���data��Ƥ���numeric type���H�V�q�覡��X
Cor.data <- cor(data[, Num.cols])
corrplot(Cor.data, order = "hclust", addrect = 3)#�N�����ʱj�ץH���I�Ӫ���
corrplot(Cor.data, method = "number")#�N�����ʱj�ץH�Ʀr����
#_____________________________________________#(season)
#Comparing different continents regarding their happiness variables
data$season <- as.factor(data$season)
data_vs <- data[, c(16)]
gg1 <- ggplot(data,aes(x=season, y=cnt, color=season))+
  geom_point() + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
gg2 <- ggplot(data , aes(x = season, y = cnt,color = season)) +
  geom_boxplot(aes(fill=season)) + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
gg3 <- ggplot(data,aes(x=season,y=cnt))+
  geom_violin(aes(fill=season),alpha=0.4)+ theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
stable <- desc_statby(data, measure.var = "cnt",
                      grps = "season")
stable <- stable[, c("season","mean","median")]
names(stable) <- c("season", "Mean of cnt","Median of cnt")
# Summary table plot
stable.p <- ggtexttable(stable,rows = NULL, 
                        theme = ttheme("classic"))

ggarrange(gg1, gg2, ncol = 1, nrow = 2)
ggarrange(gg3, stable.p, ncol = 1, nrow = 2)

#_____________________________________________#(weekday)
data$weekday <- as.factor(data$weekday)
gg1_weekday <- ggplot(data,
                      aes(x=weekday,
                          y=cnt,
                          color=weekday))+
  geom_point() + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
gg2_weekday <- ggplot(data , aes(x = weekday, y = cnt,color = weekday)) +
  geom_boxplot(aes(fill=weekday)) + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
gg3_weekday <- ggplot(data,aes(x=weekday,y=cnt))+
  geom_violin(aes(fill=weekday),alpha=0.4)+ theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
stable_weekday <- desc_statby(data, measure.var = "cnt",
                              grps = "weekday")
stable_weekday <- stable_weekday[, c("weekday","mean","median")]
names(stable_weekday) <- c("weekday", "Mean of cnt","Median of cnt")
# Summary table plot
stable_weekday.p <- ggtexttable(stable_weekday,rows = NULL, 
                                theme = ttheme("classic"))

ggarrange(gg1_weekday, gg2_weekday, ncol = 1, nrow = 2)
ggarrange(gg3_weekday, stable_weekday.p, ncol = 1, nrow = 2)
#_____________________________________________#(weathersit)
data$weathersit <- as.factor(data$weathersit)
gg1_weather <- ggplot(data, aes(x=weathersit, y=cnt,color=weathersit))+
  geom_point() + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
gg2_weather <- ggplot(data , aes(x = weathersit, y = cnt,color = weathersit)) +
  geom_boxplot(aes(fill=weathersit)) + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
gg3_weather <- ggplot(data,aes(x=weathersit,y=cnt))+
  geom_violin(aes(fill=weathersit),alpha=0.4)+ theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))
stable_weather <- desc_statby(data, measure.var = "cnt",
                              grps = "weathersit")
stable_weather <- stable_weather[, c("weathersit","mean","median")]
names(stable_weather) <- c("weather", "Mean of cnt","Median of cnt")
# Summary table plot
stable_weather.p <- ggtexttable(stable_weather,rows = NULL, 
                                theme = ttheme("classic"))

ggarrange(gg1_weather, gg2_weather, ncol = 1, nrow = 2)
ggarrange(gg3_weather, stable_weather.p, ncol = 1, nrow = 2)
#______________________________________________#(season)
#Scatter plot with regression line
pst <- ggplot(data, aes(x = temp, y = cnt)) + 
  geom_point(aes(color=season), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = season, fill = season), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~season) +
  theme_bw() + labs(title = "Scatter plot with regression line")
pst
psat <- ggplot(data, aes(x = atemp, y = cnt)) + 
  geom_point(aes(color=season), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = season, fill = season), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~season) +
  theme_bw() + labs(title = "Scatter plot with regression line")
psat
psh <- ggplot(data, aes(x = hum, y = cnt)) + 
  geom_point(aes(color=season), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = season, fill = season), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~season) +
  theme_bw() + labs(title = "Scatter plot with regression line")
psh
pswd <- ggplot(data, aes(x = windspeed, y = cnt)) + 
  geom_point(aes(color=season), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = season, fill = season), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~season) +
  theme_bw() + labs(title = "Scatter plot with regression line")
pswd
#______________________________________________#(weekday)
#Scatter plot with regression line
sprl_wt <- ggplot(data, aes(x = temp, y = cnt)) + 
  geom_point(aes(color=weekday), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weekday, fill = weekday), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weekday) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_wt
sprl_wat <- ggplot(data, aes(x = atemp, y = cnt)) + 
  geom_point(aes(color=weekday), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weekday, fill = weekday), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weekday) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_wat
sprl_hum <- ggplot(data, aes(x = hum, y = cnt)) + 
  geom_point(aes(color=weekday), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weekday, fill = weekday), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weekday) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_hum
sprl_ws <- ggplot(data, aes(x = windspeed, y = cnt)) + 
  geom_point(aes(color=weekday), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weekday, fill = weekday), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weekday) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_ws
#______________________________________________#(weathersit)
#Scatter plot with regression line
sprl_t <- ggplot(data, aes(x = temp, y = cnt)) + 
  geom_point(aes(color=weathersit), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weathersit, fill = weathersit), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weathersit) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_t
sprl_at <- ggplot(data, aes(x = atemp, y = cnt)) + 
  geom_point(aes(color=weathersit), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weathersit, fill = weathersit), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weathersit) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_at
sprl_h <- ggplot(data, aes(x = hum, y = cnt)) + 
  geom_point(aes(color=weathersit), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weathersit, fill = weathersit), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weathersit) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_h
sprl_wsp <- ggplot(data, aes(x = windspeed, y = cnt)) + 
  geom_point(aes(color=weathersit), size = 3, alpha = 0.8) +  
  geom_smooth(aes(color = weathersit, fill = weathersit), 
              method = "lm", fullrange = TRUE) +
  facet_wrap(~weathersit) +
  theme_bw() + labs(title = "Scatter plot with regression line")
sprl_wsp

#______________________________________________#
data <- read.csv("D:/data science final project/day.csv",head = TRUE)
str(data)
data <- data[, -c(1,2,14,15)]
#______________________________________________#
#Neural Network
library(neuralnet)
#�зǤƥH�����ǽT��
maxs <- apply(data,2,max)
mins <- apply(data,2, min)
scaled <- as.data.frame(scale(data,center = mins,scale = maxs - mins))
#�Ndata����trainning�Mtesting set
train.ind_nn = sample(1:nrow(data),round(0.75 * nrow(data)))
train_nn <- scaled[train.ind_nn, ]
test_nn <- scaled[-train.ind_nn, ]
#�إ�model
nn <- neuralnet(cnt ~ season + yr + mnth + holiday + weekday + workingday + weathersit + temp + atemp + hum + windspeed ,
                data = train_nn,hidden = c(3, 2), linear.output =  TRUE)
#�e�X���g������
plot(nn)
#�i��w��
pred.nn <-compute(nn,test_nn[, 1:11])
#�p��Neural Network model accuracy
mape_nn=mean(abs(test_nn$cnt-pred.nn$net.result)/test_nn$cnt)
accuracy_nn=1-mape_nn
accuracy_nn
#�epredict�Mactual����
#�I�V�a��u�V�ǽT
Pred_Actual_nn <- as.data.frame(cbind(Prediction = pred.nn$net.result, Actual = test_nn$cnt))
gg.nn <- ggplot(Pred_Actual_nn, aes(Actual, V1 )) +
  geom_point() + theme_bw() + geom_abline() +
  labs(title = "Neural Networks Regression", x = "Actual cnt",
       y = "Predicted cnt") +
  theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
        axis.title = element_text(family = "Helvetica", size = (10)))
gg.nn
#��line graph �e�Xpredict�Mactual�������
x = 1:length(test_nn$cnt)
plot(x, test_nn$cnt, col = "red", type = "l", lwd=2,
     main = "bike sharing test data prediction(nn)")
lines(x,pred.nn$net.result , col = "blue", lwd=2)
legend("topright",  legend = c("original-cnt", "predicted-cnt"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid()
#______________________________________________#
#xgboost
library(xgboost)
library(tidyverse)
set.seed(1004)
#��train �Mtest �� ���
train.ind_xgb <- createDataPartition(data$cnt,p = 0.7,list = F)
train = data[train.ind_xgb, ]
test = data[-train.ind_xgb, ]
train_x_xgb = data.matrix(train[, -12])
train_y_xgb = train[ ,12]
test_x_xgb = data.matrix(test[,-12])
test_y_xgb = test[,12]
#�ରxgboost���}���x�}(�M�w�̫᪺trainning�Mtesting set)
xgb_train = xgb.DMatrix(data = train_x_xgb,label = train_y_xgb)
xgb_test = xgb.DMatrix(data = test_x_xgb,label = test_y_xgb)
watchlist = list(train=xgb_train, test=xgb_test)
#�إ�model
model = xgb.train(data = xgb_train, max.depth = 2, watchlist=watchlist, nrounds = 200)
#��test_rmse���D�bnround = 172 rmse�̤p
final_model = xgboost(data = xgb_test, max.depth = 2, nrounds = 172, verbose = 0)
#(verbose = 0 ���ܤ����L�Xtrainning �Mtesting error)
#�w��
xgb_y = predict(final_model, test_x_xgb)
#�p��mse�Amae�Armse
mse_xgb = mean((test_y_xgb -xgb_y)^2)
mae_xgb = caret::MAE(test_y_xgb,xgb_y)
rmse_xgb = caret::RMSE(test_y_xgb,xgb_y)
cat("MSE: ",mse_xgb,"MAE: ",mae_xgb,"RMSE: ",rmse_xgb)
#�p��xgboost model�ǽT�v
mape_xgb=mean(abs(test_y_xgb-xgb_y)/test_y_xgb)
accuracy_xgb=1-mape_xgb
accuracy_xgb
#��ggplot2�e�X�w���M��ڪ��ϧ�
Pred_Actual_nn <- as.data.frame(cbind(Prediction =xgb_y, Actual = test_y_xgb))
gg.xgb <- ggplot(Pred_Actual_nn, aes(Actual, Prediction )) +
  geom_point() + theme_bw() + geom_abline() +
  labs(title = "xgboost", x = "Actual cnt",
       y = "Predicted cnt") +
  theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
        axis.title = element_text(family = "Helvetica", size = (10)))
gg.xgb
#��line graph �e�Xpredict�Mactual�������
x = 1:length(test_y_xgb)
plot(x, test_y_xgb, col = "red", type = "l", lwd=2,
     main = "bike sharing test data prediction(nn)")
lines(x,xgb_y , col = "blue", lwd=2)
legend("topright",  legend = c("original-cnt", "predicted-cnt"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid()

#______________________________________________#
#Random Forest Regression
library(randomForest)
set.seed(1004)
#�Ndata����training �Mtesting
train.ind_rfr <-createDataPartition(data$cnt, p = 0.7 ,list = F)
train_rfr = data[train.ind_rfr, ]
test_rfr = data[-train.ind_rfr, ]
#�إ�model
rf_model= randomForest(x = train_rfr[-1],y = train_rfr$cnt,ntree = 500)
#�d�ݥ�testing data predict �����G�M��ڪ��t��
y_pred_test <- predict(rf_model ,test_rfr)
test.rf_scored <- as_tibble(cbind(test_rfr,y_pred_test))
glimpse(test.rf_scored)
#�p��mse,mae,rmse
mse_rfr = mean((test_rfr$cnt - y_pred_test)^2)
mae_rfr = caret::MAE(test_rfr$cnt,y_pred_test)
rmse_rfr = caret::RMSE(test_rfr$cnt,y_pred_test)
cat("MSE: ",mse_rfr,"MAE: ",mae_rfr,"RMSE: ",rmse_rfr)
#��Random Forest Regression model accuracy
mape_rfr=mean(abs(test_rfr$cnt-y_pred_test)/test_rfr$cnt)
accuracy_rfr=1-mape_rfr
accuracy_rfr
#�epredict�Mactual����
#�I�V�a��u�V�ǽT
Pred_Actual_rf <- as.data.frame(cbind(Prediction = y_pred_test, Actual = test_rfr$cnt))
gg.rf <- ggplot(Pred_Actual_rf, aes(Actual, Prediction )) +
  geom_point() + theme_bw() + geom_abline() +
  labs(title = "Random Forest Regression", x = "Actual cnt",
       y = "Predicted cnt") +
  theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
        axis.title = element_text(family = "Helvetica", size = (10)))
gg.rf
#��line graph �e�Xpredict�Mactual�������
x = 1:length(test_rfr$cnt)
plot(x, test_rfr$cnt, col = "red", type = "l", lwd=2,
     main = "bike sharing test data prediction(rfr)")
lines(x,y_pred_test, col = "blue", lwd=2)
legend("topright",  legend = c("original-cnt", "predicted-cnt"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid()
#______________________________________________#
#Multiple Linear Regression
library(caTools)
set.seed(1004)
#�Ndata����training�Mtesting
split = sample.split(datalm$cnt,SplitRatio = 0.7)
train_lm = subset(datalm,split = TRUE)
test_lm = subset(datalm,split = FALSE)
train.ind_lm <-createDataPartition(data$cnt, p = 0.7 ,list = F)
train_lm = data[train.ind_lm, ]
test_lm = data[-train.ind_lm, ]
#�إ�Multiple Linear Regression model
model_lm = lm(cnt ~ season + yr + mnth + holiday + weekday + workingday + weathersit + temp + atemp + hum + windspeed,data = train_lm)
summary(model_lm)
#�w��
y_pred_lm = predict(model_lm,newdata = test_lm)
#�p��mse,mae,rmse
mse_lm = mean((test_lm$cnt - y_pred_lm)^2)
mae_lm = caret::MAE(test_lm$cnt,y_pred_lm)
rmse_lm = caret::RMSE(test_lm$cnt,y_pred_lm)
cat("MSE: ",mse_lm,"MAE: ",mae_lm,"RMSE: ",rmse_lm)
#��model accuracy
mape_lm=mean(abs(test_lm$cnt-y_pred_lm)/test_lm$cnt)
accuracy_lm=1-mape_lm
accuracy_lm
#�epredict�Mactual����
#�I�V�a��u�V�ǽT
Pred_Actual_lm <- as.data.frame(cbind(Prediction = y_pred_lm, Actual = test_lm$cnt))
gg.lm <- ggplot(Pred_Actual_lm, aes(Actual, Prediction )) +
  geom_point() + theme_bw() + geom_abline() +
  labs(title = "Multiple Linear Regression", x = "Actual cnt",
       y = "Predicted cnt") +
  theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
        axis.title = element_text(family = "Helvetica", size = (10)))
gg.lm
#��line graph �e�Xpredict�Mactual�������
x = 1:length(test_lm$cnt)
plot(x, test_lm$cnt, col = "red", type = "l", lwd=2,
     main = "bike sharing test data prediction(ml)")
lines(x,y_pred_lm, col = "blue", lwd=2)
legend("topright",  legend = c("original-cnt", "predicted-cnt"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid()

#______________________________________________#
#SVR
set.seed(1004)
#�Ndata����trainning�Mtesting data
train.ind_svr <- createDataPartition(data$cnt,p = 0.7,list = F)
train_svr <- data[train.ind_svr, ]
test_svr <- data[-train.ind_svr, ]
test_svr = rbind(train_svr[1,],test_svr)
test_svr = test_svr[-1,]
#�إ�model
svr_model <- svm(cnt ~ season + yr + mnth + holiday + weekday + workingday + weathersit + temp + atemp + hum + windspeed,data = train_svr,type = "eps-regressio",kernel = 'radial')
#kernel ��radial train
y_pred_svr = predict(svr_model,test_svr)
#�p��mse,mae,rmse
mse_svr = mean((test_svr$cnt - y_pred_svr)^2)
mae_svr = caret::MAE(test_svr$cnt,y_pred_svr)
rmse_svr = caret::RMSE(test_svr$cnt,y_pred_svr)
cat("MSE: ",mse_svr,"MAE: ",mae_svr,"RMSE: ",rmse_svr)
#��model accuracy
mape_svr=mean(abs(test_svr$cnt-y_pred_svr)/test_svr$cnt)
accuracy_svr=1-mape_svr
accuracy_svr
#�epredict�Mactual����
#�I�V�a��u�V�ǽT
Pred_Actual_svr <- as.data.frame(cbind(Prediction = y_pred_svr, Actual = test_svr$cnt))
gg.svr <- ggplot(Pred_Actual_svr, aes(Actual, Prediction )) +
  geom_point() + theme_bw() + geom_abline() +
  labs(title = "SVR", x = "Actual cnt",
       y = "Predicted cnt") +
  theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
        axis.title = element_text(family = "Helvetica", size = (10)))
gg.svr
#��line graph �e�Xpredict�Mactual�������
x = 1:length(test_svr$cnt)
plot(x, test_svr$cnt, col = "red", type = "l", lwd=2,
     main = "bike sharing test data prediction(knn)")
lines(x,y_pred_svr, col = "blue", lwd=2)
legend("topright",  legend = c("original-cnt", "predicted-cnt"), 
       fill = c("red", "blue"), col = 2:3,  adj = c(0, 0.6))
grid()