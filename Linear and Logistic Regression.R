
####Linear regression###

data <- Orange
head(data)
mod <- lm(age ~ circumference, data=data)
summary(mod)
yhat <- predict(mod,data)
plot(yhat ~ data$age)
scatter.smooth(yhat ~ data$age)



###Logistic Regression###

data <- iris
head(data)
data$y <- ifelse(data$Species == "versicolor",1,0)
rnd <- sample(seq(1,nrow(data)))
data <-data[rnd,]
data$Species <-NULL
mod <-glm(factor(y) ~ Petal.Length + Sepal.Width ,family = "binomial", data = data)
summary(mod)
pred <- predict(mod,data,type="response")
hist(pred)
yhat <- ifelse(pred>=0.5,1,0)
table (yhat=yhat, y=data$y)
accuracy <-(21+88)/nrow(data)
accuracy



yhat <- ifelse(pred>=0.3,1,0)
table (yhat=yhat, y=data$y)
