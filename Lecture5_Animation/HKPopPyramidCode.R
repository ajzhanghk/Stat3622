# Question 1: Hong Kong Population Pyramids
DataX = read.csv("HongKongPopulation2017.csv") 
tmp = levels(DataX$Age.group)
DataX$Age = factor(DataX$Age.group, tmp[c(2,11,3:10,12:18,1)])
DataX1 = rbind(data.frame(DataX[,c("Year","Age")], Gender="Male", Population=DataX[,3]),
               data.frame(DataX[,c("Year","Age")], Gender="Female", Population=DataX[,4]))

library(ggplot2)
library(gridExtra)
ListYear = c(1961, 1981, 2001, 2017)
for (k in 1:length(ListYear)){
  TmpX = DataX1[DataX1$Year==ListYear[k], ]
  idx = TmpX$Gender=="Male"
  TmpX$Population[idx] = -TmpX$Population[idx]
  tmp = ggplot(TmpX, aes(x = Age, y = Population, fill=Gender)) + 
    geom_bar(stat="identity")+
    scale_y_continuous(labels = abs, limits = max(abs(DataX1$Population))*c(-1,1)) + 
    coord_flip() + theme_bw() + scale_fill_brewer(palette = "Set1") +
    ggtitle(paste("HK Population:", ListYear[k]))
  eval(parse(text=paste(paste("g",k,sep=""),"= tmp")))
}
grid.arrange(g1, g2, g3, g4, nrow=2, ncol=2)  


 
