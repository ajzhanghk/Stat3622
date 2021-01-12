library(rvest)

thisurl = "https://brandirectory.com/rankings/global/table"
webpage <- read_html(thisurl)

# Inspect the webpage
xdata <- webpage %>% html_nodes("body tbody") 
length(xdata)
head(xdata)
print.AsIs(xdata[1])

DataX = NULL
for (i in 1:length(xdata)){
  tmp <- xdata[i] %>% html_nodes("td") 
  rank20 <- tmp[1] %>% html_text()  %>% as.numeric() 
  rank19 <- tmp[2] %>% html_text()  %>% as.numeric()
  # logo <- tmp[3] %>% html_nodes("img") %>% xml_attr("src")
  company <- tmp[3] %>% html_text() 
  company = trimws(gsub("\n", "", company))
  country <- tmp[4] %>% html_text() 
  country = trimws(gsub("\n", "", country))  
  # flag <- tmp[5] %>% html_nodes("img") %>% xml_attr("src") 
  value20 <- tmp[5] %>% html_nodes("span") %>% html_text()  
  value19 <- tmp[6] %>% html_nodes("span") %>% html_text()  
  rate20 <- tmp[7] %>% html_text()  
  rate20 = trimws(gsub("\n", "", rate20))
  rate19 <- tmp[8] %>% html_text()  
  rate19 = trimws(gsub("\n", "", rate19))
  DataX = rbind(DataX, c(rank20, rank20, company, country, 
                         value20, value19, rate20, rate19))
}

# xname <- webpage %>% html_nodes(".col-sm-9 .main th") %>% html_text() 
colnames(DataX) = c("Rank20", "Rank19", "Company", "Country", 
                    "Value20", "Value19", "Rate20", "Rate19")
DataX = as.data.frame(DataX)
# knitr::kable(head(DataX), format="html")
write.csv(DataX,  file="TopBrand2020.csv", row.names=F)
