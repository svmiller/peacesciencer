#' @importFrom tibble tibble
NULL

#' Correlates of War Direct Contiguity Data (v. 3.2)
#'
#' These contain an abbreviated version of the "master records" for the
#' Correlates of War direct contiguity data. Data contain a few cosmetic changes
#' to assist with some functions downstream from it.
#'
#' @format A data frame with 1,874 observations on the following 5 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{conttype}}{a numeric vector for the contiguity relationship}
#' \item{\code{stdate}}{a date communicating the start of the contiguity relationship}
#' \item{\code{enddate}}{a date communicating the end of the contiguity relationship}
#' }
#'
#' @details
#'
#' The "master record" provided by the Correlates of War is "non-directed." I make
#' these data "directed" for convenience.
#'
#' For clarity, the contiguity codes range from 1 to 5. 1 = direct land contiguity. 2 =
#' separated by 12 miles of water or fewer (a la Stannis Baratheon). 3 = separated by
#' 24 miles of water or fewer (but more than 12 miles). 4 = separated by 150 miles
#' of water or fewer (but more than 24 miles). 5 = separated by 400 miles of water
#' or fewer (but more than 150 miles). Cases of separation by more than 400 miles
#' of water are here as 0. The documentation for `add_contiguity()` belabors why
#' you should not consider the contiguity variable as ordinal.
#'
#' `stdate` and `enddate` are simple date formats of the original `begin` and
#' `end` columns in the raw data. Correlates of War communicates contiguity
#' periods in a basic year-month format (`YYYYMM`). It's just easier to process
#' an actual date, provided you're careful and know that the day I communicate
#' in these columns means absolutely nothing.
#'
#' The master record contains no entry for a non-continguous relationship, leaving
#' the user to figure that out for themselves. The data I provide here includes
#' information for non-contiguous relationships for all states that had, at least
#' at one point, a contiguous relationship. For example, there is just the one
#' entry a contiguous USA-Russia relationship (from Jan. 1959 to the end of the
#' data), but I also provide manual clarification of a non-contiguous relationship
#' before that. You can check the `data-raw` directory for how I do this. This
#' is necessary for a case like Myanmar-Philippines, in which a contiguity
#' relationship enters the data in 1963 (but only for September of that year).
#' It would be important to note that the data say there was no contiguity
#' relationship in that dyad at the start of the year.
#'
#' Be mindful that the data are fundamentally year-month. Sometimes the end date
#' for one contiguity relationship overlaps with the start date for another
#' contiguity relationship. Sometimes it doesn't. Since no day information is
#' available in the data, the contiguity entries I impute for non-contiguous
#' relationships cannot know whether, for example, the contiguity relationship
#' that starts in Jan. 1959 started on the first of the month or sometime in
#' the middle of the month.
#'
#'
#' @references Stinnett, Douglas M., Jaroslav Tir, Philip Schafer, Paul F. Diehl, and Charles Gochman
#' (2002). "The Correlates of War Project Direct Contiguity Data, Version 3." Conflict
#' Management and Peace Science 19 (2):58-66.
#'
"cow_contdir"


#' Correlates of War National Trade Data Set (v. 4.0)
#'
#' These are state-year-level data for national trade from the Correlates of War
#' project.
#'
#'
#' @format A data frame with 14410 observations on the following four variables.
#' \describe{
#' \item{\code{ccode}}{the Correlates of War state system code}
#' \item{\code{year}}{the year}
#' \item{\code{imports}}{total imports of the state in current million USD}
#' \item{\code{exports}}{total exports of the state in current million USD}
#' }
#'
#' @details
#'
#' The \code{data-raw} directory on the project's Github shows how the data were
#' processed.
#'
#' @references
#'
#' Barbieri, Katherine and Omar M.G. Keshk. 2016. Correlates of War Project
#' Trade Data Set Codebook, Version 4.0. Online: \url{https://correlatesofwar.org}
#'
#' Barbieri, Katherine, Omar M.G. Keshk, and Brian Pollins. 2009. "TRADING DATA:
#' Evaluating Our Assumptions and Coding Rules."
#' *Conflict Management and Peace Science*, 26(5): 471-491.
#'
"cow_trade_sy"

#' Directed Dyadic Dispute-Year Data (CoW-MID, v. 5.0)
#'
#' These are directed dyadic dispute year data derived from the Correlates of War
#' (CoW) Militarized Interstate Dispute (MID) project. Data are from version 5.0.
#'
#'
#' @format A data frame with 11390 observations on the following 18 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the CoW-MID dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{year}}{a numeric vector for the dispute-year}
#' \item{\code{dispongoing}}{a numeric vector for whether there was a dispute ongoing in that year}
#' \item{\code{disponset}}{a numeric vector for whether it was the onset of a new dispute (or new participant-entry into a recurring dispute)}
#' \item{\code{sidea1}}{is \code{ccode1} on side A of the dispute?}
#' \item{\code{sidea2}}{is \code{ccode2} on side A of the dispute?}
#' \item{\code{fatality1}}{a numeric vector for the overall fatality level of \code{ccode1} in the dispute}
#' \item{\code{fatality2}}{a numeric vector for the overall fatality level of \code{ccode2} in the dispute}
#' \item{\code{fatalpre1}}{a numeric vector for the known fatalities (with precision) for \code{ccode1} in the dispute}
#' \item{\code{fatalpre2}}{a numeric vector for the known fatalities (with precision) for \code{ccode2} in the dispute}
#' \item{\code{hiact1}}{a numeric vector for the highest action of \code{ccode1} in the dispute}
#' \item{\code{hiact2}}{a numeric vector for the highest action of \code{ccode2} in the dispute}
#' \item{\code{hostlev1}}{a numeric vector for the hostility level of \code{ccode1} in the dispute}
#' \item{\code{hostlev2}}{a numeric vector for the hostility level of \code{ccode2} in the dispute}
#' \item{\code{orig1}}{is \code{ccode1} an originator of the dispute?}
#' \item{\code{orig2}}{is \code{ccode2} an originator of the dispute?}
#' }
#'
#' @details
#'
#' The process of creating these is described at one of the references below.
#' Importantly, these data are somewhat "naive." That is: they won't tell you,
#' for example, that Brazil and Japan never directly fought each other during
#' World War II. Instead, it will tell you that there were two years of overlap
#' for the two on different sides of the conflict and that the highest action for
#' both was a war. The data are thus similar to what the *EUGene* program would
#' create for users back in the day. Use these
#' data with that limitation in mind.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{https://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Palmer, Glenn, Roseanne W. McManus, Vito D'Orazio, Michael R. Kenwick,
#' Mikaela Karstens, Chase Bloch, Nick Dietrich, Kayla Kahn, Kellan Ritter, and
#' Michael J. Soules. 2022. "The MID5 Dataset, 2011–2014: Procedures, coding
#' rules, and description" *Conflict Management and Peace Science* 39(4): 470--82.
#'

"cow_mid_dirdisps"


#' Abbreviated CoW-MID Dispute-level Data (v. 5.0)
#'
#' This is an abbreviated version of the dispute-level CoW-MID data.
#'
#'
#' @format A data frame with 2436 observations on the following 7 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the CoW-MID dispute number}
#' \item{\code{outcome}}{a numeric vector for the outcome of the MID}
#' \item{\code{styear}}{a numeric vector for the start year of the MID}
#' \item{\code{stmon}}{a numeric vector for the start month of the MID}
#' \item{\code{settle}}{a numeric vector for the how dispute was settled}
#' \item{\code{fatality}}{a numeric vector for the fatality level of the dispute}
#' \item{\code{mindur}}{a numeric vector for the minimum duration of the MID}
#' \item{\code{maxdur}}{a numeric vector for the maximum duration of the MID}
#' \item{\code{hiact}}{a numeric vector for the highest action of the MID}
#' \item{\code{hostlev}}{a numeric vector for the hostility level of the MID}
#'  \item{\code{recip}}{a numeric vector for whether a MID was reciprocated}
#' }
#'
#' @details
#'
#' These data are purposely light on information; they're not intended to be
#' used for dispute-level analyses, per se. They're intended to augment the
#' directed dyadic dispute-year data by adding in variables that serve as
#' exclusion rules to whittle the data from dyadic dispute-year to just dyad-year
#' data.
#'
#' @references
#'
#' Palmer, Glenn, Roseanne W. McManus, Vito D'Orazio, Michael R. Kenwick,
#' Mikaela Karstens, Chase Bloch, Nick Dietrich, Kayla Kahn, Kellan Ritter, and
#' Michael J. Soules. 2022. "The MID5 Dataset, 2011–2014: Procedures, coding
#' rules, and description" *Conflict Management and Peace Science* 39(4): 470--82.
#'

"cow_mid_disps"


#' Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (CoW-MID, v. 5.0)
#'
#' These are directed dyadic dispute year data derived from the Correlates of
#' War (CoW) Militarized Interstate Dispute (MID) project. Data are from version
#' 5.0. These were whittled to where there is no duplicate dyad-years. Its
#' primary aim here is merging into a dyad-year data frame.
#'
#'
#' @format A data frame with 10234 observations on the following 25 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the CoW-MID dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{year}}{a numeric vector for the dispute-year}
#' \item{\code{cowmidongoing}}{a numeric vector for whether there was a dispute ongoing in that year}
#' \item{\code{cowmidonset}}{a numeric vector for whether it was the onset of a new dispute (or new participant-entry into a recurring dispute)}
#' \item{\code{sidea1}}{is \code{ccode1} on side A of the dispute?}
#' \item{\code{sidea2}}{is \code{ccode2} on side A of the dispute?}
#' \item{\code{fatality1}}{a numeric vector for the overall fatality level of \code{ccode1} in the dispute}
#' \item{\code{fatality2}}{a numeric vector for the overall fatality level of \code{ccode2} in the dispute}
#' \item{\code{fatalpre1}}{a numeric vector for the known fatalities (with precision) for \code{ccode1} in the dispute}
#' \item{\code{fatalpre2}}{a numeric vector for the known fatalities (with precision) for \code{ccode2} in the dispute}
#' \item{\code{hiact1}}{a numeric vector for the highest action of \code{ccode1} in the dispute}
#' \item{\code{hiact2}}{a numeric vector for the highest action of \code{ccode2} in the dispute}
#' \item{\code{hostlev1}}{a numeric vector for the hostility level of \code{ccode1} in the dispute}
#' \item{\code{hostlev2}}{a numeric vector for the hostility level of \code{ccode2} in the dispute}
#' \item{\code{orig1}}{is \code{ccode1} an originator of the dispute?}
#' \item{\code{orig2}}{is \code{ccode2} an originator of the dispute?}
#' \item{\code{fatality}}{a numeric vector for the fatality level of the dispute}
#' \item{\code{hostlev}}{a numeric vector for the hostility level of the MID}
#' \item{\code{mindur}}{a numeric vector for the minimum duration of the MID}
#' \item{\code{maxdur}}{a numeric vector for the maximum duration of the MID}
#'  \item{\code{recip}}{a numeric vector for whether a MID was reciprocated}
#'  \item{\code{stmon}}{a numeric vector for the start month of the MID}
#' }
#'
#' @details The process of creating these is described at one of the references
#' below. Importantly, these data are somewhat "naive." That is: they won't
#' tell you, for example, that Brazil and Japan never directly fought each
#' other during World War II. Instead, it will tell you that there were two
#' years of overlap for the two on different sides of the conflict and that the
#' highest action for both was a war. The data are thus similar to what the
#' \code{EUGene} program would create for users back in the day. Use these
#' data with that limitation in mind.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{https://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Palmer, Glenn, Roseanne W. McManus, Vito D'Orazio, Michael R. Kenwick,
#' Mikaela Karstens, Chase Bloch, Nick Dietrich, Kayla Kahn, Kellan Ritter, and
#' Michael J. Soules. 2022. "The MID5 Dataset, 2011–2014: Procedures, coding
#' rules, and description" *Conflict Management and Peace Science* 39(4): 470--82.
#'

"cow_mid_ddydisps"


#' Correlates of War Major Powers Data (1816-2016)
#'
#' These are the Correlates of War major powers data.
#'
#' @format A data frame with 14 observations on the following 8 variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War country code}
#' \item{\code{styear}}{the start year as a major power}
#' \item{\code{stmonth}}{the start month as a major power}
#' \item{\code{stday}}{the start day as a major power}
#' \item{\code{endyear}}{the end year as a major power}
#' \item{\code{endmonth}}{the end month as a major power}
#' \item{\code{endday}}{the end day as a major power}
#' \item{\code{version}}{a version identifier}
#' }
#'
#' @details Data are provided "as-is" with no additional re-cleaning before inclusion into this data set (beyond eliminating the state abbreviation).
#'
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership/}
#'
"cow_majors"
