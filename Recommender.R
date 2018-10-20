userNum <- function()
{
  cat ("Enter the user number")
  line <- readline()
}

noOfVal <- function()
{
  cat ("Enter the number of values")
  line <- readline()
}

setwd("/Users/kinjal.jain/Documents/")

user <- userNum()      #user input
number <- noOfVal()    #number of recommendations to be given

library(recommenderlab)
library(reshape2)

#tab = read.delim("u.data")
#write.table(tab, file="u.data.csv",sep=",",col.names=FALSE,row.names=FALSE)

tr <- read.csv("u.data.csv", header = TRUE)
head(tr)

g <- acast(tr, UID ~ MID)

class(g)

R <- as.matrix(g)

r <- as(R, "realRatingMatrix")


#r_m <- normalize(r)

rec1 <- Recommender(r[1:nrow(r)], method = "POPULAR")
print(rec1)

rec2=Recommender(r[1:nrow(r)],method="IBCF", param=list(normalize = "Z-score",method="Jaccard",minRating=1))
print(rec2)

rec3=Recommender(r[1:nrow(r)],method="SVD")
print(rec3)

rec4=Recommender(r[1:nrow(r)],method="UBCF", param=list(normalize = "Z-score",method="Cosine",nn=5, minRating=1))
print(rec4)

pre1 <- predict(rec1, r[user], type="topNList" , n=number)
pre1

pre1 <- as(pre1, "list")
print(pre1)

pre2 <- predict(rec2, r[user], type="topNList" , n=number)
pre2

pre2 <- as(pre2, "list")
print(pre2)

pre3 <- predict(rec3, r[1:nrow(r)], type="ratings")
pre3

pre3 <- as(pre3, "list")
print(pre3)

pre4 <- predict(rec4, r[user], type="topNList" , n=number)
pre4

pre4 <- as(pre4, "list")
print(pre4)
