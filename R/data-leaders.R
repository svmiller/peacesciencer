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

#' (An Abbreviation of) The LEAD Data Set
#'
#' These are an abbreviated version of the LEAD Data Set, incorporating
#' variables that I think are most interesting or potentially useful from these
#' data.
#'
#'
#' @format A data frame with 3409 observations on the following 12 variables.
#' \describe{
#' \item{\code{obsid}}{an observational ID from \code{archigos}}
#' \item{\code{leveledu}}{0 = primary, 1 = secondary, 2 = university, 3 = graduate}
#' \item{\code{milservice}}{did leader have prior military service?}
#' \item{\code{combat}}{did leader have prior combat experience in military service?}
#' \item{\code{rebel}}{was leader previously part of a rebel group?}
#' \item{\code{warwin}}{was leader previously part of a winning war effort as part of military service?}
#' \item{\code{warloss}}{was leader previously part of a losing war effort as part of military service?}
#' \item{\code{rebelwin}}{was leader previously part of a winning war effort as part of a rebel group?}
#' \item{\code{rebelloss}}{was leader previously part of a losing war effort as part of a rebel group?}
#' \item{\code{yrsexper}}{previous years of experience in politics before becoming a leader}
#' \item{\code{physhealth}}{does leader have physical health issues?}
#' \item{\code{mentalhealth}}{does leader have mental health issues?}
#' }
#'
#' @details
#'
#' Data are ported from Ellis et al. (2015). Users who want more of these
#' variables included in \pkg{peacesciencer} should raise an issue on Github.
#'
#' @references
#'
#' Ellis, Carli Mortenson, Michael C. Horowitz, and Allan C. Stam. 2015.
#' "Introducing the LEAD Data Set." *International Interactions* 41(4): 718--741.

"LEAD"

#' A Data Set of Leader Codes Across Archigos 4.1, Archigos 2.9, and the LEAD Data
#'
#' This is a simple data set that matches, as well as one can, leader codes
#' across Archigos 4.1, Archigos 2.9, and the LEAD data set.
#'
#'
#' @format A data frame the following four variables.
#' \describe{
#' \item{\code{obsid}}{the observation ID in the Archigos data}
#' \item{\code{leadid}}{the leader ID in version 4.1 of the Archigos data}
#' \item{\code{leadid29}}{the leader ID in version 2.9 of the Archigos data}
#' \item{\code{leaderid}}{the leader ID in the LEAD data}
#' }
#'
#' @details
#'
#' These data treat version 4.1 of the Archigos data as the gospel leader data
#' (if you will) for which  the observation ID (`obsid`) is the master code
#' indicating a leader tenure period. It also builds in an assumption that
#' various observations that duplicate in the LEAD data should not have
#' duplicated. This concerns Francisco Aguilar Barquer (who appears twice),
#' Emile Reuter (who appears twice), and Gunnar Thoroddsen (who appears three
#' times) in the LEAD data despite having uninterrupted tenures in office. None
#' of the covariates associated with these leaders change in the LEAD data,
#' which is why I assume they were duplicates.

"leader_codes"
