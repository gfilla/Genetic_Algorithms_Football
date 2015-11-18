library(ggplot2)
library(XML)

setwd("C:/Users/IBM_ADMIN/Google Drive/_School Docs/CSC578 - ML and NN/Final Project")
dkdata <- read.csv("DKSalaries-11-11.csv")
espndata <- read.csv("11112015espn.csv")

players <- espndata[,2]
espndata <- data.frame(do.call('rbind', strsplit(as.character(espndata[,2]),',',fixed=TRUE)))
espndata[,1]
subset(espndata, espndata[,1]!="*[:punct:]")
#scatterplot
ggplot(dkdata,aes(x=AvgPointsPerGame, y = Salary, colour = Position,shape=Position))+geom_point(size=2.5)




















# #get espn data
# espn_data <- do.call('rbind',lapply(paste0("http://games.espn.go.com/ffl/tools/projections?&amp;startIndex=",seq(0,960,40)), function(x){ readHTMLTable(x, as.data.frame=TRUE, stringsAsFactors=FALSE)$playertable_0}))
# my_data = data.frame
# espn <- function(x){ return(readHTMLTable(x, as.data.frame=TRUE, stringsAsFactors=FALSE)$playertable_0)}  
# i = 0
# for (i in 0:20){
# url = (paste0("http://games.espn.go.com/ffl/tools/projections?&amp;startIndex=",80))
# # my_data <- espn(url)
# # }
# # 
# # write.csv(espn_data, file = "11072015 - espn.csv")
# 
# original <- espn_data
# colnames(espn_data) = espn_data[1,]
# espn_data = espn_data[-1,]
# cols <- colsplit(espn_data[,1],',',c("Players", "Team"))
# cols <- colsplit(cols[,2],' ',c("Team", "Position", "Status"))
# test <- cols[1,]
# col_nos <- gsub(x = cols[,2],pattern= " ",replacement= "")
# col_nos
# espn_data <- espn_data[,-1]
# espn_data <- cbind(espn_data, cols, 1)
# espn_data
#  combined <- merge(espn_data, dkdata, by.x = "surname", by.y = "name")
# 
#  cols[1,]
#  