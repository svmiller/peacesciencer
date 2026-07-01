#' Download Some Extra Data for Peace Science Research
#'
#' # A Description of Various Data Sets This Will Download
#'
#' Running \code{download_extdata()} returns the following data that will be
#' stored in the package's `extdata` directory.
#'
#' ## Correlates of War Dyadic Trade Data Set (v. 4.0)
#'
#' These are directed dyad-year-level data for dyadic trade from the
#' Correlates of War project. The trade values presented here
#' have been rounded to three decimal points to conserve space. The
#' data downloaded by this function are about 4.1 megabytes in size.
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
#' ## Directed Leader Dyad-Year Data, 1870-2015 (CoW States)
#'
#' These are all directed leader dyad-year data from 1870-2015. Data come
#' from the Archigos data (version 4.1). The data are standardized to just
#' those observations where both leaders and states appear in the CoW state
#' system data. The data downloaded by this function are about 2 megabytes
#' in size.
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `year` | the year |
#' | `obsid1` | the unique Archigos (v. 4.1) observation ID for the first leader |
#' | `obsid2` | the unique Archigos (v. 4.1) observation ID for the second leader |
#' | `ccode1` | a numeric vector for the Correlates of War state code for the first state |
#' | `ccode2` | a numeric vector for the Correlates of War state code for the second state |
#' | `gender1` | the gender of `obsid1` ("M" or "F") |
#' | `gender2` | the gender of `obsid2` ("M" or "F") |
#' | `leaderage1` | the approximate age (i.e. `year - yrborn`) for `obsid1` in the year |
#' | `leaderage2` | the approximate age (i.e. `year - yrborn`) for `obsid2` in the year |
#' | `yrinoffice1` | a running count for the tenure of `obsid1`, starting at 1. |
#' | `yrinoffice2` | a running count for the tenure of `obsid2`, starting at 1. |
#'
#'
#' ## Directed Leader Dyad-Year Data, 1870-2015 (Gleditsch-Ward States)
#'
#' These are all directed leader dyad-year data from 1870-2015. Data come from
#' the Archigos data (version 4.1). The data represent every possible dyadic
#' leader-pairing in the Archigos data (which is denominated in the
#' Gleditsch-Ward system), but standardizes leader dyad-years to Gleditsch-Ward
#' state system dates. The data downloaded by this function
#' are about 2.2 megabytes in size.
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `year` | the year |
#' | `obsid1` | the unique Archigos (v. 4.1) observation ID for the first leader |
#' | `obsid2` | the unique Archigos (v. 4.1) observation ID for the second leader |
#' | `gwcode1` | a numeric vector for the Gleditsch-Ward state code for the first state |
#' | `gwcode2` | a numeric vector for the Gleditsch-Ward state code for the second state |
#' | `gender1` | the gender of `obsid1` ("M" or "F") |
#' | `gender2` | the gender of `obsid2` ("M" or "F") |
#' | `leaderage1` | the approximate age (i.e. `year - yrborn`) for `obsid1` in the year |
#' | `leaderage2` | the approximate age (i.e. `year - yrborn`) for `obsid2` in the year |
#' | `yrinoffice1` | a running count for the tenure of `obsid1`, starting at 1. |
#' | `yrinoffice2` | a running count for the tenure of `obsid2`, starting at 1. |
#'
#' ## Measures of Dyadic Foreign Policy Similarity (FPSIM)
#'
#' The FPSIM data set provides measures of foreign policy similarity of dyads
#' based on alliance ties (ATOP, version 5.1) and UN General
#' Assembly voting (through 2022) for all members of the Correlates of
#' War state system. The alliance data cover the time period from 1816 to 2018,
#' and the UN voting data from 1946 to 2022. The similarity measures include
#' various versions of Ritter and Signorino's *S* (weighted/non-weighted by
#' material capabilities; squared/absolute distance metrics) as well as the
#' chance-corrected measures Cohen's (1960, 1968) kappa and Scott's (1955) pi. The
#' measures based on alliance data come in two versions: one is based on valued
#' alliance ties and the other is based on binary alliance ties.

#' These data are directed dyad-years with 16 columns and  2,061,776
#' observations. They will almost certainly be the largest data set
#' I nudge/ask you to download remotely.
#'
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `ccode1` | the Correlates of War state code for the first state |
#' | `ccode2` | the Correlates of War state code for the second state |
#' | `year` | the year |
#' | `sallyvus` | Signorino and Ritter's (s) for alliance (ally) data -- (v)alued, (u)nweighted, (s)quared distances |
#' | `sallyvua` | Signorino and Ritter's (s) for alliance (ally) data -- (v)alued, (u)nweighted, (a)bsolute distances |
#' | `sallybus` |  Signorino and Ritter's (s) for alliance (ally) data -- (b)inary, (u)nweighted, (s)quared distances |
#' | `sallybua` | Signorino and Ritter's (s) for alliance (ally) data -- (b)inary, (u)nweighted, (a)bsolute distances |
#' | `sallyvwa` | Signorino and Ritter's (s) for alliance (ally) data -- (v)alued, (w)eighted, (a)bsolute distances |
#' | `sallybwa` | Signorino and Ritter's (s) for alliance (ally) data -- (b)inary, (w)eighted, (a)bsolute distances |
#' | `pallyv` | Scott's (p)i for alliance (ally) data -- (v)alued |
#' | `pallyb` | Scott's (p)i for alliance (ally) data -- (b)inary |
#' | `kallyv` | Cohen's (k)appa for alliance (ally) data -- (v)alued |
#' | `kallyb` | Cohen's (k)appa for alliance (ally) data -- (b)inary |
#' | `taub` | Kendall's tau-b for alliance data -- valued |
#' | `kvotev` | Cohen's (k)appa for UN voting (vote) data -- (v)alued |
#' | `pvotev` | Scott's (p)i for UN voting (vote) data -- (v)alued |

#'
#' ## (Non-Directed) Dyadic Minimum Distance Data *Plus* (CoW States)
#'
#' These are *non-directed* dyadic minimum distance data from Schvitz et al.
#' (2022) for all Correlates of War states from the start of 1886 to the
#' end of 2019. Note that I call these "data *plus*", with the idea of
#' informally branding these as a kind of augmentation of what you might
#' otherwise do with the \pkg{cshapes} package. This data set has over
#' 4.4 million rows for each dyadic minimum distance for all available
#' years. Within each year, there is a recorded minimum distance for Jan. 1,
#' June 30, Dec. 31 and, in addition, any day within the year where the
#' composition of the international system (or shape of a state) changed, as
#' recorded in \pkg{cshapes}. Sometimes these changes concern the dyadic
#' minimum distance; sometimes they don't. For example, the League of Nations
#' is responsible for a lot shape changes (i.e. system entry) in the CoW state
#' system data in the year 1920. That obviously won't change the dyadic minimum
#' distance between the U.S. and Canada, which will always be zero. Sometimes
#' the start of the year (Jan. 1), the midpoint of the year (June 30), or the
#' end of the year (Dec. 31) coincides with a system change. Often it doesn't.
#' Note that a referent day (Jan. 1, June 30, Dec. 31) may not appear in a given
#' year for a given dyad if that date exists outside CoW state system membership.
#' For example, Canada doesn't appear as a state system member until Jan. 10,
#' 1920. The goal of this data set is allow you to more quickly generate dyadic
#' minimum distances within \pkg{peacesciencer}'s functionality if you are
#' proficient in \pkg{tidyverse} verbs. You could also use it to highlight
#' how often the dyadic minimum distance may vary within a year for a given
#' dyad.
#'
#' Despite the dimensions of the data set, it's not too big of a download. The
#' data are about 1.7 MB in size.
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `ccode1` | the Correlates of War state code for the first state |
#' | `ccode2` | the Correlates of War state code for the second state |
#' | `year` | the year |
#' | `date` | a date, coinciding with either a system change date or a referent day (i.e. Jan. 1, June 30, Dec. 31) |
#' | `change_date` | a date that, when present, indicates the shape of the system changed on that day |
#' | `mindist` | the dyadic minimum distance (in kilometers) |
#'
#' ## (Non-Directed) Dyadic Minimum Distance Data *Plus* (G-W States)
#'
#' These are *non-directed* dyadic minimum distance data from Schvitz et al.
#' (2022) for all Gleditsch-Ward states from the start of 1886 to the
#' end of 2019. Note that I call these "data *plus*", with the idea of
#' informally branding these as a kind of augmentation of what you might
#' otherwise do with the \pkg{cshapes} package. This data set has over
#' 3.7 million rows for each dyadic minimum distance for all available
#' years. Within each year, there is a recorded minimum distance for Jan. 1,
#' June 30, Dec. 31 and, in addition, any day within the year where the
#' composition of the international system (or shape of a state) changed, as
#' recorded in \pkg{cshapes}. Sometimes these changes concern the dyadic
#' minimum distance; sometimes they don't. For example, the dissolution of
#' the Soviet Union is responsible for a lot shape changes (i.e. system entry) in
#' 1991. That obviously won't change the dyadic minimum
#' distance between the U.S. and Canada, which will always be zero. Sometimes the
#' start of the year (Jan. 1), the midpoint of the year (June 30), or the end of
#' the year (Dec. 31) coincides with a system change. Often it doesn't. Note that
#' a referent day (Jan. 1, June 30, Dec. 31) may not appear in a given year for
#' a given dyad if that date exists outside G-W state system membership. For
#' example, Haiti disappears from the state system on July 4, 1915 and
#' reappears on Aug. 15, 1934. That means there won't be any dyadic minimum
#' distance observations with the U.S., for example, on Dec. 31, 1915 or June
#' 30, 1934. The goal of this data set is allow you to more quickly generate dyadic
#' minimum distances within \pkg{peacesciencer}'s functionality if you are
#' proficient in \pkg{tidyverse} verbs. You could also use it to highlight
#' how often the dyadic minimum distance may vary within a year for a given
#' dyad.
#'
#' Despite the dimensions of the data set, it's not too big of a download. The
#' data are about 1.4 MB in size.
#'
#' | COLUMN | DESCRIPTION |
#' | -------| ------------|
#' | `gwcode1` | the Gleditsch-Ward state code for the first state |
#' | `gwcode2` | the Gleditsch-Ward state code for the second state |
#' | `year` | the year |
#' | `date` | a date, coinciding with either a system change date or a referent day (i.e. Jan. 1, June 30, Dec. 31) |
#' | `change_date` | a date that, when present, indicates the shape of the system changed on that day |
#' | `mindist` | the dyadic minimum distance (in kilometers) |
#'
#'
#' @description \code{download_extdata()} leverages R's \code{inst} directory
#' flexibility to allow you to download some extra data and store it in
#' the package.
#'
#' @return \code{download_extdata()} downloads some extra data stored on
#' my website (\url{https://svmiller.com}) and sticks them in the *extdata*
#' directory in the package.
#'
#' @author Steven V. Miller
#'
#' @param overwrite logical, defaults to FALSE. If FALSE, the function
#' checks to see if you've already downloaded the data and, if you already
#' have, it does nothing. If TRUE, the function redownloads the data.
#' @param confirm logical, defaults to FALSE. If FALSE, the function
#' does not actually download the data. Set this to TRUE to confirm your
#' intentions to download the data.
#' @param warning logical, defaults to TRUE. If TRUE, the function returns a
#' message advising you about the total size of the files you'll be downloading.
#' If FALSE, no message is returned about the total file sizes.
#' @md
#'
#' @references
#'
#' Barbieri, Katherine, Omar M. G. Keshk, and Brian Pollins. 2009. "TRADING DATA:
#' Evaluating our Assumptions and Coding Rules." *Conflict Management and
#' Peace Science*. 26(5): 471-491.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009.
#' "Introducing Archigos: A Dataset of Political Leaders" *Journal of Peace
#' Research* 46(2): 269--83.
#'
#' Haege, Frank. 2011. "Choice or Circumstance? Adjusting Measures of Foreign
#' Policy Similarity for Chance Agreement." *Political Analysis* 19(3): 287-305.
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik Cederman,
#' and Kristian Skrede Gleditsch. 2022. "Mapping The International System, 1886-2017:
#' The \code{CShapes} 2.0 Dataset." *Journal of Conflict Resolution*. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring
#' Country Shapes: The \code{cshapes} Package." *The R Journal* 2(1): 18-24.
#'
#' @examples
#'
#' \dontrun{
#' # Here's where the data are going to be downloaded.
#' system.file("extdata", package="peacesciencer")
#' # Now, let's download the data.
#' download_extdata(confirm = TRUE)
#' }

download_extdata <- function(overwrite = FALSE, confirm = FALSE, warning = TRUE) {

  extdata_dir <- system.file("extdata", package="peacesciencer")

  if(warning == TRUE) {
    message("Please be advised the sum total of external data will take up about 48.2 MB of disk space. The biggest offender here is easily the dyadic foreign policy similarity data (36.8 MB). You must set warning = FALSE to disable this message. This is more a point of information for you, the user.\n")
  }

  if(confirm == FALSE) {
    stop("CRAN generally frowns on functions that foist non-interactive execution on the user or assume a console session. Please set confirm = TRUE to actually get the data.")
  } else {



  if(overwrite == FALSE) {
    if(file.exists(system.file("extdata", "cow_trade_ddy.rds", package="peacesciencer"))) {
      message("cow_trade_ddy.rds is already in /extdata in the package directory.")
    } else {
      message("Downloading cow_trade_ddy.rds from https://svmiller.com/R/peacesciencer (file size: 4.1 MB).")
      cow_trade_ddy <- readRDS(url("https://svmiller.com/R/peacesciencer/cow_trade_ddy.rds"))
      saveRDS(cow_trade_ddy, paste0(extdata_dir,"/cow_trade_ddy.rds"))
      message("cow_trade_ddy.rds downloaded and moved to /extdata directory in the package.")
    }

    # directed leader dyad-year data now...
    if(file.exists(system.file("extdata", "cow_dir_leader_dyad_years.rds", package="peacesciencer"))) {
      message("cow_dir_leader_dyad_years.rds is already in /extdata in the package directory.")
    } else {
      message("Downloading cow_dir_leader_dyad_years.rds from https://svmiller.com/R/peacesciencer  (file size: 2.0 MB).")
      cow_dir_leader_dyad_years <- readRDS(url("https://svmiller.com/R/peacesciencer/cow_dir_leader_dyad_years.rds"))
      saveRDS(cow_dir_leader_dyad_years, paste0(extdata_dir,"/cow_dir_leader_dyad_years.rds"))
      message("cow_dir_leader_dyad_years.rds downloaded and moved to /extdata directory in the package.")
    }

    # directed leader dyad-year data now...
    if(file.exists(system.file("extdata", "gw_dir_leader_dyad_years.rds", package="peacesciencer"))) {
      message("gw_dir_leader_dyad_years.rds is already in /extdata in the package directory.")
    } else {
      message("Downloading gw_dir_leader_dyad_years.rds from https://svmiller.com/R/peacesciencer  (file size: 2.2 MB).")
      gw_dir_leader_dyad_years <- readRDS(url("https://svmiller.com/R/peacesciencer/gw_dir_leader_dyad_years.rds"))
      saveRDS(gw_dir_leader_dyad_years, paste0(extdata_dir,"/gw_dir_leader_dyad_years.rds"))
      message("gw_dir_leader_dyad_years.rds downloaded and moved to /extdata directory in the package.")
    }

    # dyadic foreign policy similarity data now...
    if(file.exists(system.file("extdata", "FPSIM.rds", package="peacesciencer"))) {
      message("FPSIM.rds is already in /extdata in the package directory.")
    } else {
      message("Downloading FPSIM.rds from https://svmiller.com/fpsim/data (file size: 36.8 MB).")
      FPSIM <- readRDS(url("https://svmiller.com/fpsim/data/FPSIM.rds"))
      saveRDS(FPSIM, paste0(extdata_dir,"/FPSIM.rds"))
      message("FPSIM.rds downloaded and moved to /extdata directory in the package.")
    }


    # CoW mindist-plus now...
    if(file.exists(system.file("extdata", "cow_mindist_plus.rds", package="peacesciencer"))) {
      message("cow_mindist_plus.rds is already in /extdata in the package directory.")
    } else {
      message("Downloading cow_mindist_plus.rds from https://svmiller.com/R/peacesciencer (file size: 1.7 MB).")
      cow_mindist_plus <- readRDS(url("https://svmiller.com/R/peacesciencer/cow_mindist_plus.rds"))
      saveRDS(cow_mindist_plus, paste0(extdata_dir,"/cow_mindist_plus.rds"))
      message("cow_mindist_plus.rds downloaded and moved to /extdata directory in the package.")
    }

    # G-W mindist-plus now...
    if(file.exists(system.file("extdata", "gw_mindist_plus.rds", package="peacesciencer"))) {
      message("gw_mindist_plus.rds is already in /extdata in the package directory.")
    } else {
      message("Downloading gw_mindist_plus.rds from https://svmiller.com/R/peacesciencer  (file size: 1.4 MB).")
      gw_mindist_plus <- readRDS(url("https://svmiller.com/R/peacesciencer/gw_mindist_plus.rds"))
      saveRDS(gw_mindist_plus, paste0(extdata_dir,"/gw_mindist_plus.rds"))
      message("gw_mindist_plus.rds downloaded and moved to /extdata directory in the package.")
    }



  } else if (overwrite == TRUE) {

    message("Downloading cow_trade_ddy.rds from https://svmiller.com/R/peacesciencer (file size: 4.1 MB).")
    cow_trade_ddy <- readRDS(url("https://svmiller.com/R/peacesciencer/cow_trade_ddy.rds"))
    saveRDS(cow_trade_ddy, paste0(extdata_dir,"/cow_trade_ddy.rds"))
    message("cow_trade_ddy.rds downloaded and moved to /extdata directory in the package.")

    message("Downloading cow_dir_leader_dyad_years.rds from https://svmiller.com/R/peacesciencer (file size: 2.0 MB).")
    cow_dir_leader_dyad_years <- readRDS(url("https://svmiller.com/R/peacesciencer/cow_dir_leader_dyad_years.rds"))
    saveRDS(cow_dir_leader_dyad_years, paste0(extdata_dir,"/cow_dir_leader_dyad_years.rds"))
    message("cow_dir_leader_dyad_years.rds downloaded and moved to /extdata directory in the package.")

    message("Downloading gw_dir_leader_dyad_years.rds from https://svmiller.com/R/peacesciencer (file size: 2.2 MB).")
    gw_dir_leader_dyad_years <- readRDS(url("https://svmiller.com/R/peacesciencer/gw_dir_leader_dyad_years.rds"))
    saveRDS(gw_dir_leader_dyad_years, paste0(extdata_dir,"/gw_dir_leader_dyad_years.rds"))
    message("gw_dir_leader_dyad_years.rds downloaded and moved to /extdata directory in the package.")

    message("Downloading FPSIM.rds from https://svmiller.com/fpsim/data (file size: 36.8 MB).")
    FPSIM <- readRDS(url("https://svmiller.com/fpsim/data/FPSIM.rds"))
    saveRDS(FPSIM, paste0(extdata_dir,"/FPSIM.rds"))
    message("FPSIM.rds downloaded and moved to /extdata directory in the package.")

    message("Downloading cow_mindist_plus.rds from https://svmiller.com/R/peacesciencer (file size: 1.7 MB).")
    cow_mindist_plus <- readRDS(url("https://svmiller.com/R/peacesciencer/cow_mindist_plus.rds"))
    saveRDS(cow_mindist_plus, paste0(extdata_dir,"/cow_mindist_plus.rds"))
    message("cow_mindist_plus.rds downloaded and moved to /extdata directory in the package.")

    message("Downloading gw_mindist_plus.rds from https://svmiller.com/R/peacesciencer (file size: 1.4 MB).")
    gw_mindist_plus <- readRDS(url("https://svmiller.com/R/peacesciencer/gw_mindist_plus.rds"))
    saveRDS(gw_mindist_plus, paste0(extdata_dir,"/gw_mindist_plus.rds"))
    message("gw_mindist_plus.rds downloaded and moved to /extdata directory in the package.")


  } else {
    stop("overwrite must either be TRUE (T) or FALSE (F). Default is FALSE (F)")
  }

    message(paste0("\n\nCheck the contents of the /extdata directory below:\n\n", extdata_dir))

  } # end of confirm argument


}

# remote_files <- c("cow_trade_ddy")
# extdata_dir <- system.file("extdata", package="peacesciencer")
#
# the_files <- paste0(extdata_dir, "/", remote_files, ".rds")
