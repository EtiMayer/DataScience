a <- (10:20)
b <- letters[4:13]
f <- c(1,1,1,0,0,0,0,0)
factor(f, levels=c(1,0), labels = c("NO","YES"))
?objects
help("objects")
.Ob <- 1
ls(pattern = "O")
ls(pattern= "O", all.names = TRUE)    # also shows ".[foo]"



movies_list <- list(movie1=list(RANK=1, PEAK=1, TITLE="Avatar", WORLDWIDE_GROSS=2787, YEAR= 2009),
                    movie2=list(RANK=2, PEAK=1, TITLE="Titanic", WORLDWIDE_GROSS=2187, YEAR= 1997),
                    movie3=list(RANK=3, PEAK=3, TITLE="Star Wars", WORLDWIDE_GROSS=2068, YEAR= 2015),
                    movie4=list(RANK=4, PEAK=4, TITLE="Avengers", WORLDWIDE_GROSS=1844, YEAR= 2018),
                    movie5=list(RANK=5, PEAK=3, TITLE="Jurassic World", WORLDWIDE_GROSS=1671, YEAR= 2015)
)

movies_list$movie2$TITLE
movies_list[[2]][[3]]

movies_list2 <-as.data.frame(movies_list)
View(movies_list2)

rm(movies_list2)
