### R - excerise 2 ###

df <- iris
df
?colMeans
colMeans(x)

min(df$Sepal.Length)
max(df$Sepal.Length)
mean(df$Sepal.Length)


min(df$Sepal.Width)
max(df$Sepal.Width)
mean(df$Sepal.Width)


min(df$Petal.Length)
max(df$Petal.Length)
mean(df$Petal.Length)


min(df$Petal.Width)
max(df$Petal.Width)
mean(df$Petal.Width)

summary(df)

df2 <- mtcars
df2
sqrt(df2$mpg)
log(df2$disp)
df2$wt^3

s1 <- c("age","gender","hight","weight")
s2 <-paste(s1,collapse="+")
s2
s3<-paste(s1,sep="+")
s3

m1 <- matrix(c(4,7,-8,3,0,-2,1,-5,12,-3,6,9),ncol = 4)
m1
rowMeans(m1,na.rm = TRUE)
colMeans(m1,na.rm=TRUE)
mean(m1)

version





mapply(rep, LETTERS[26:1], SIMPLIFY = TRUE)


for (x in 1:10) {
  print(sample(c(1:10)))
  if(x==8) {
    break
  }
}

for (x in sample(1:10)) {
  print(x)
  if (x==8) {
    break
  }
}

for (i in 1:40) {
  x<- sample(x=1:10,size=1)
  print(x)
  if (x==8){
    break
  }
}

x<-0
while (x!=8) {
  x<- sample(x=1:10,size=1)
  print (x)
}
  

  a <- c("well", "you", "merged", "vectors","one") 
  b <- c("done", "have", "two", "into", "phrase")
  c<-NULL
  for (i in 1:5){
    c<-paste(c,paste(a[i],b[i]))
  }
c