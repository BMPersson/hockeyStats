#' Draft extract function
#
#' Nested function that scrapes and extracts the data from the Eliteprospects website. Called automatically by draft_data function in hockeyStats package
#' @param year = sequence of years for whcih draft data is to be extracted and returned
#' @keywords icehockey, stats
#' @export
#' @examples 
#' draft_extract(seq(2012, 2016, 1))
#'

draft_extract <- function(year) {

#load libraries
require("dplyr")
require("magrittr")
require("rvest")

#get input year - which draft data are we scraping?

  
draft_data<-read_html(sprintf("http://www.eliteprospects.com/draft.php?year=%d", year))
#use sprintf to complete URL and load website data to variable
    draft_no <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(1)")%>%html_text())
    team <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(2)")%>%html_text())
    player <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(3)")%>%html_text())
    seasons <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(4)")%>%html_text())
    suppressWarnings(games <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(5)")%>%html_text()%>%as.numeric()))
    suppressWarnings(goals <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(6)")%>%html_text()%>%as.numeric()))
    suppressWarnings(assist <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(7)")%>%html_text()%>%as.numeric()))
    suppressWarnings(points <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(8)")%>%html_text()%>%as.numeric()))
    suppressWarnings(pims <- data.frame(draft_data%>%html_nodes(".tableborder td:nth-child(9)")%>%html_text()%>%as.numeric()))
    #load each column in to a variable

      draft_no[] <- lapply(draft_no, gsub, pattern = '#', replacement = '')
      #Removes hashtag from draft_no

all_data <- data.frame(draft_no, team, player, seasons, games, goals, assist, points, pims)
#concatenate data into a data frame

colnames(all_data) <- c("draft_no", "team", "player", "seasons", "games", "goals", "assist", "points", "pims")
#Changes column names

suppressWarnings(all_data[,1] <- as.numeric(all_data[,1]))
#Change draft_no to numeric instead of character - makes further analysis easier

sequence <- which(!is.na(all_data$draft_no), arr.ind=TRUE)
#Gets index of non-empty rows

draft_rounds <- split(sequence, cumsum(c(TRUE, diff(sequence)!=1)))
#splits previous variable in to individual draft rounds
# draft_rounds$`1` indexes first draft round rows
  no_rows <- 1:nrow(all_data)
  #gets row numbers

    all_data$no_rows <- no_rows

      no_rounds <-  1:length(draft_rounds)

    all_rounds <- sapply(no_rounds, round_FUN, draft_rounds)

  all_data <- all_data[!is.na(all_data$draft_no),]
  #Removes empty rows from dataset

all_rounds <- matrix(unlist(all_rounds), nrow=nrow(all_data), byrow=T)

colnames(all_rounds) <- "draft_round"


all_data[is.na(all_data)] <- 0
#Replaces NA's with 0 to reflect that some players have played no games, scored no goals, etc.
all_data$draft_round <- all_rounds


all_data <- subset(all_data, select = -no_rows )

all_data$year <- rep_len(year, length(sequence))

return(all_data)
#Put all data in one data frame - can then group by both draft year and draft position

}
