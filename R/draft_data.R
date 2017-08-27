#' Draft data function
#
#' This function gets data from all players drafted in the years specified, and returns a dataframe
#' @param startYear = First year you want draft data from, endYear = last year you want draft data from. BOth values must be entered.
#' @keywords icehockey, stats
#' @export
#' @examples 
#' #Returns regular season statistics from all players drafted between 2012 and 2016
#' draft_data(2012, 2016)
#'

draft_data<-function(startYear, endYear) {
  require("plyr")

    xYear<-startYear
    #Enter draft year you want to start with

    yYear<- endYear
    #Enter draft year you want to end at

    years<-data.frame(seq(xYear, yYear, 1))

    draft.dataset <- apply(years, 1, draft_extract)
    #Returns as many lists as years - need to unlist and add each draft year

    draft.dataset <- do.call(rbind.data.frame, draft.dataset)
    
    #return(years)
    return(draft.dataset)


}


#Script/functions:
#1. draft_data
#2. draft_extract
#3. round_FUN