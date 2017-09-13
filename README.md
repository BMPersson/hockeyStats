# hockeyStats

This is a package for importing ice hockey statistics for visualisation and analysis in R.

Current functions in the package:

draft_data - Used to import career stats from players selected in the NHL entry draft between the years specified
Example:

    draft.df <- draft_data(2009,2015) 
    #Gets the career statistics from all players drafted between 2009 and 2015, with players ordered by the year and position they were drafted
    


# How to install

To install this package you need the devtools library, and then install the hockeyStats package from github using:

    devtools::install_github('BMPersson/hockeyStats')
