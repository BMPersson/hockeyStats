#' Function to get the individual draft rounds frp, each draft year. Called by the draft_extract function in the hockeyStats package
#
#' This function returns list of the numbers of the draft rounds from each draft year
#' @param no_rounds = number of draft rounds that particular year. draft_rounds = length of individual draft rounds
#' @keywords icehockey, stats
#' @export
#' @examples 
#' roundFun(no_rounds, draft_rounds)
#'

round_FUN <- function(no_rounds, draft_rounds) {
  
  draft_vec <- data.frame(draft_rounds[no_rounds])
  leng_draft <- dim(draft_vec)
  leng_draft <- leng_draft[1]
  draft_list <- rep(no_rounds, leng_draft)
  return(draft_list)
}