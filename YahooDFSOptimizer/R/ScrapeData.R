#' Scrape Function
#'
#' This function allows the user to scrape the date from RotoWire and
#' import it nicely into an R data frame
#' @param Defaults to TRUE
#' @keywords
#' @export
#' @examples
#' scrapeDFS()

scrapeDFS <- function(){

webpage <- read_html("https://www.rotowire.com/daily/NBA/optimizer.php?site=Yahoo&sport=NBA")

Name <- webpage %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dplayer-link", " " ))]') %>%
  html_text(trim = TRUE) %>%
  as.data.frame()
colnames(Name) <- "Name"

Position <- webpage %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "rwo-pos", " " ))]') %>%
  html_text(trim = TRUE) %>%
  as.data.frame()
colnames(Position) <- "Position"

Salary <- webpage %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "salaryInput", " " ))]') %>%
  xml_attr("value")
Salary <- gsub("[[:punct:]]", " ", Salary)
Salary <- as.data.frame(Salary)

Projection <- webpage %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "ptsInput", " " ))]') %>%
  xml_attr("value") %>%
  as.data.frame()
colnames(Projection) <- "Projection"

DFS_Data <- cbind(Name, Position, Salary, Projection)
DFS_Data$Name <- as.character(DFS_Data$Name)
DFS_Data$Salary <- as.numeric(as.character(DFS_Data$Salary))
DFS_Data$Projection <- as.numeric(as.character(DFS_Data$Projection))
#DFS_Data
DFS_Data <<- DFS_Data
#return(DFS_Data)

}




