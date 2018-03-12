install.packages("rvest")
library(rvest)
library(magrittr)

require(rvest)
require(magrittr)

webpage <- read_html("https://www.rotowire.com/daily/NBA/optimizer.php?site=Yahoo&sport=NBA")

#results <- webpage %>% html_nodes("dplayer-link")
#results
#results <- webpage %>% html_nodes("table")
#results

#DFS_rawdata2 <- html_table(results)
#DFS_rawdata2
#DFS_raw_data <- html_table(webpage)
#DFS_raw_data
#DFS_data <- as.data.frame(DFS_raw_data[2])

#install.packages("XML")
#library(XML)
#install.packages("RCurl")
#library(RCurl)

#URL <- "https://www.rotowire.com/daily/NBA/optimizer.php?site=Yahoo&sport=NBA"
#xData <- getURL(URL)
#doc <- xmlParse(xData)
#DFS.Table <- readHTMLTable(xData)
#DFS.Table[2]


#-----------------------------------------------------
Name <- webpage %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dplayer-link", " " ))]') %>% 
  html_text(trim = TRUE) %>%
  as.data.frame() 
colnames(Name) <- "Name"
#Name

Position <- webpage %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "rwo-pos", " " ))]') %>% 
  html_text(trim = TRUE) %>%
  as.data.frame()
colnames(Position) <- "Position"
#Position

Salary <- webpage %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "salaryInput", " " ))]') %>% 
  xml_attr("value")
Salary <- gsub("[[:punct:]]", " ", Salary)
Salary <- as.data.frame(Salary)
#Salary

Projection <- webpage %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "ptsInput", " " ))]') %>% 
  xml_attr("value") %>%
  as.data.frame()
colnames(Projection) <- "Projection"
#Projection

DFS_Data <- cbind(Name, Position, Salary, Projection)
DFS_Data$Name <- as.character(DFS_Data$Name)
DFS_Data$Salary <- as.numeric(as.character(DFS_Data$Salary))
DFS_Data$Projection <- as.numeric(as.character(DFS_Data$Projection))
  

