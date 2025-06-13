#' @importFrom tibble tibble
NULL

#' Archigos: A (Subset of a) Dataset on Political Leaders
#'
#' These are leader-level data drawn from the Archigos data. Space considerations mean I offer here just a few columns
#' based on these data.  Data are version 4.1.
#'
#'
#' @format A data frame with 3409 observations on the following 11 variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
#' \item{\code{obsid}}{a character vector for observation ID}
#' \item{\code{leadid}}{the unique leader identifier}
#'  \item{\code{leader}}{the leader name}
#'   \item{\code{yrborn}}{the year the leader was born}
#'   \item{\code{gender}}{a categorical variable for leader gender ("M" for men, "W" for women)}
#' \item{\code{startdate}}{a date for the leader start date}
#' \item{\code{enddate}}{a date for the leader end date}
#' \item{\code{entry}}{a character vector for the leader's entry type}
#' \item{\code{exit}}{a character vector for the leader's exit type}
#' \item{\code{exitcode}}{a character vector for more information about the leader's exit type}
#' }
#' @details Space considerations mean I can only offer a few columns from the
#' overall data. Archigos data are rich with information. Consult the raw data
#' available on Hein Goeman's website for more.
#'
#' To best conform with data requirements on CRAN, a few leader names were
#' renamed if they included irregular characters (e.g. umlauts or accents).
#' These leaders, in these particular applications, hav been renamed to "(Juan
#' Orlando) Hernandez" (`HON-2014`), "(Antonio) Saca Gonzalez" (`SAL-2004`),
#' "Julian Trujillo Largacha" (`COL-1878`), "Cesar Gaviria Trujillo"
#' (`COL-1990`), "Gabriel Garcia Moreno" (`ECU-1869`), "Marcos A. Morinigo"
#' (`PAR-1894-1`), "Higinio Morinigo" (`PAR-1940`), "Sebastian Pinera"
#' (`CHL-2010`), "Sauli Niinisto" (`FIN-2012`), "Louis Gerhard De Geer"
#' (`SWD-1876`), "Stefan Lofven" (`SWD-2014`), "Lars Lokke Rasmussen"
#' (`DEN-2009`, `DEN-2015`), and "Fernando de Araujo" (`ETM-2008-1`). None of
#' these names contain these special characters in the data here.
#'
#' For clarity's sake, I renamed the `ccode` column in the raw data to be
#' `gwcode`. This is because it may deceive the user peeking into the data
#' that these are not Correlates of War state codes, but Gleditsch-Ward
#' state codes.
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing
#' Archigos: A Dataset of Political Leaders" \emph{Journal of Peace Research}
#' 46(2): 269--83.
#'
#' @md

"archigos"

#' Archigos Yearly Leader Turnover: A Summary
#'
#' These are yearly summaries of leader turnover from the Archigos data, for use
#' in `add_archigos()`
#'
#' @format A data frame with 14707 observations on the following 7 variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
#' \item{\code{year}}{a numeric vector for a referent year}
#' \item{\code{leadertransition}}{a dummy variable indicating a leader transition in a given year}
#' \item{\code{irregular}}{a dummy variable indicating an irregular leader transition in a given year}
#' \item{\code{n_leaders}}{an integer for the number of leaders in a given year}
#' \item{\code{jan1obsid}}{a character vector for the observation ID of the head of state on Jan. 1 of the referent year}
#' \item{\code{dec31obsid}}{a character vector for the observation ID of the head of state on Dec. 31 of the referent year}
#' }
#' @details
#'
#' Consult `archigos` in the same data frame for more information about the data.
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing
#' Archigos: A Dataset of Political Leaders" \emph{Journal of Peace Research}
#' 46(2): 269--83.


"archigossums"



#' Leader Willingness to Use Force
#'
#' These are the estimates of leader willingness to use force as estimated by Carter and Smith (2020).
#'
#'
#' @format A data frame with 3409 observations on the following 9 variables.
#' \describe{
#' \item{\code{obsid}}{an observational ID from \code{archigos}}
#' \item{\code{theta1_mean}}{the mean simulated M1 theta, as estimated by Carter and Smith (2020)}
#' \item{\code{theta1_sd}}{the standard deviation of simulated M1 thetas}
#' \item{\code{theta2_mean}}{the mean simulated M2 theta, as estimated by Carter and Smith (2020)}
#' \item{\code{theta2_sd}}{the standard deviation of simulated M2 thetas}
#' \item{\code{theta3_mean}}{the mean simulated M3 theta, as estimated by Carter and Smith (2020)}
#' \item{\code{theta3_sd}}{the standard deviation of simulated M3 thetas}
#' \item{\code{theta4_mean}}{the mean simulated M4 theta, as estimated by Carter and Smith (2020)}
#' \item{\code{theta4_sd}}{the standard deviation of simulated M4 thetas}
#' }
#'
#' @details The letter published by the authors contains more information as to what these thetas refer.
#' The "M1" theta is a variation of the standard Rasch model from the boilerplate information in the LEAD
#' data. The authors consider this to be "theoretically relevant" or "risk-related" as these all refer to conflict
#' or risk-taking. The "M2" theta expands on "M1" by including political orientation and psychological characteristics.
#' "M3" and "M4" expand on "M1" and "M2" by considering all 36 variables in the LEAD data.
#'
#' The authors construct and include all these measures, though their analyses suggest "M2" is the best-performing measure.
#'
#' @references
#'
#' Carter, Jeff and Charles E. Smith, Jr. 2020. "A Framework for Measuring Leaders' Willingness
#' to Use Force." \emph{American Political Science Review} 114(4): 1352--1358.

"lwuf"
