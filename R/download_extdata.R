#' Download Some Extra Data for Peace Science Research
#'
#' # A Description of Various Data Sets This Will Download
#'
#' Running \code{download_extdata()} returns the following data that will be stored in the package's `extdata` directory.
#'
#' ## Correlates of War Dyadic Trade Data Set (v. 4.0)
#'
#' These are directed dyad-year-level data for national trade from the Correlates of War project.
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `ccode1` | a numeric vector for the Correlates of War state code for the first state |
#' | `ccode2` | a numeric vector for the Correlates of War state code for the second state |
#' | `year` | the year |
#' | `flow1` | imports of \code{ccode1} from \code{ccode2}, in current million USD |
#' | `flow2` | imports of \code{ccode2} from \code{ccode1}, in current million USD |
#' | `smoothflow1` | smoothed \code{flow1} values |
#' | `smoothflow2` | smoothed \code{flow2} values |
#'
#' ## Directed Leader Dyad-Year Data, 1870-2015
#'
#' These are all directed leader dyad-year data from 1870-2015. Data come from the Archigos data (version 4.1).
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `year` | the year |
#' | `obsid1` | the unique Archigos (v. 4.1) observation ID for the first leader |
#' | `obsid2` | the unique Archigos (v. 4.1) observation ID for the second leader |
#' | `ccode1` | a numeric vector for the Correlates of War state code for the first state |
#' | `startdate1` | the start date in office for the first leader |
#' | `enddate1` | the end date in office for the first leader |
#' | `ccode2` | a numeric vector for the Correlates of War state code for the second state |
#' | `startdate2` | the start date in office for the second leader |
#' | `enddate2` | the end date in office for the second leader |
#'
#'
#' @description \code{download_extdata()} leverages R's \code{inst} directory flexibility to allow you to download
#' some extra data and store it in the package.
#'
#' @return \code{download_extdata()} downloads some extra data stored on my website (\url{http://svmiller.com}) and
#' sticks them in the \code{extdata} directory in the package. Right now, these data are just the directed dyad-year
#' Correlates of War trade data.
#'
#' @author Steven V. Miller
#'
#' @param overwrite logical, defaults to FALSE. If FALSE, the function checks to see if you've already
#' downloaded the data and, if you already have, it does nothing. If TRUE, the function redownloads the data.
#' @md
#'
#' @references
#'
#' Barbieri, Katherine, Omar M. G. Keshk, and Brian Pollins. 2009. "TRADING DATA: Evaluating our Assumptions and Coding Rules."
#' \emph{Conflict Management and Peace Science}. 26(5): 471-491.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#' @examples
#'
#' \dontrun{
#' # Here's where the data are going to be downloaded.
#' system.file("extdata", package="peacesciencer")
#' # Now, let's download the data.
#' download_extdata()
#' }

download_extdata <- function(overwrite = FALSE) {
  extdata_dir <- system.file("extdata", package="peacesciencer")

  if(overwrite == FALSE) {
    if(file.exists(system.file("extdata", "cow_trade_ddy.rds", package="peacesciencer"))) {
      message("cow_trade_ddy.rds is in /extdata in the package directory.")
    } else {
      message("Downloading cow_trade_ddy.rds from http://svmiller.com/R/peacesciencer.")
      cow_trade_ddy <- readRDS(url("http://svmiller.com/R/peacesciencer/cow_trade_ddy.rds"))
      saveRDS(cow_trade_ddy, paste0(extdata_dir,"/cow_trade_ddy.rds"))
      message("cow_trade_ddy.rds downloaded and moved to /extdata directory in the package.")
    }

    # directed leader dyad-year data now...
    if(file.exists(system.file("extdata", "dir_leader_dyad_years.rds", package="peacesciencer"))) {
      message("dir_leader_dyad_years.rds is in /extdata in the package directory.")
    } else {
      message("Downloading dir_leader_dyad_years.rds from http://svmiller.com/R/peacesciencer.")
      dir_leader_dyad_years <- readRDS(url("http://svmiller.com/R/peacesciencer/dir_leader_dyad_years.rds"))
      saveRDS(dir_leader_dyad_years, paste0(extdata_dir,"/dir_leader_dyad_years.rds"))
      message("dir_leader_dyad_years.rds downloaded and moved to /extdata directory in the package.")
    }


  } else if (overwrite == TRUE){
    message("Downloading cow_trade_ddy.rds from http://svmiller.com/R/peacesciencer.")
    cow_trade_ddy <- readRDS(url("http://svmiller.com/R/peacesciencer/cow_trade_ddy.rds"))
    saveRDS(cow_trade_ddy, paste0(extdata_dir,"/cow_trade_ddy.rds"))
    message("cow_trade_ddy.rds downloaded and moved to /extdata directory in the package.")

    message("Downloading dir_leader_dyad_years.rds from http://svmiller.com/R/peacesciencer.")
    dir_leader_dyad_years <- readRDS(url("http://svmiller.com/R/peacesciencer/dir_leader_dyad_years.rds"))
    saveRDS(dir_leader_dyad_years, paste0(extdata_dir,"/dir_leader_dyad_years.rds"))
    message("dir_leader_dyad_years.rds downloaded and moved to /extdata directory in the package.")
  } else {
    stop("overwrite must either be TRUE (T) or FALSE (F). Default is FALSE (F)")
  }

  message(paste0("Check the contents of the /extdata directory below:\n", extdata_dir))
}

# remote_files <- c("cow_trade_ddy")
# extdata_dir <- system.file("extdata", package="peacesciencer")
#
# the_files <- paste0(extdata_dir, "/", remote_files, ".rds")
