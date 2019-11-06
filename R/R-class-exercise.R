a <- (10:20)
b <- letters[4:13]
f <- c(1,1,1,0,0,0,0,0)
factor(f, levels=c(1,0), labels = c("NO","YES"))
?objects
help("objects")
.Ob <- 1
ls(pattern = "O")
ls(pattern= "O", all.names = TRUE)    # also shows ".[foo]"