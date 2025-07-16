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
#' The "master record" provided by the Correlates of War is "non-directed." I
#' make these data "directed" for convenience.
#'
#' For clarity, the contiguity codes range from 1 to 5. 1 = direct land
#' contiguity. 2 = separated by 12 miles of water or fewer (a la Stannis
#' Baratheon). 3 = separated by 24 miles of water or fewer (but more than 12
#' miles). 4 = separated by 150 miles of water or fewer (but more than 24 miles).
#' 5 = separated by 400 miles of water or fewer (but more than 150 miles). Cases
#' of separation by more than 400 miles of water are here as 0. The documentation
#' for [add_contiguity()] belabors why you should not consider the contiguity
#' variable as ordinal.
#'
#' `stdate` and `enddate` are simple date formats of the original `begin` and
#' `end` columns in the raw data. Correlates of War communicates contiguity
#' periods in a basic year-month format (`YYYYMM`). It's just easier to process
#' an actual date, provided you're careful and know that the day I communicate
#' in these columns means absolutely nothing.
#'
#' The master record contains no entry for a non-continuous relationship, leaving
#' the user to figure that out for themselves. The data I provide here includes
#' information for non-contiguous relationships for all states that had, at least
#' at one point, a contiguous relationship. For example, there is just the one
#' entry a contiguous USA-Russia relationship (from Jan. 1959 to the end of the
#' data), but I also provide manual clarification of a non-continuous relationship
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


#'  Correlates of War National Military Capabilities Data
#'
#' These are version 6.0 of the Correlates of War National Military Capabilities
#' data. Data omit the state abbreviation and version identifier for
#' consideration.
#'
#' @format A data frame with 15951 observations on the following 9 variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War country code}
#' \item{\code{year}}{the year}
#' \item{\code{milex}}{an estimate of military expenditures (in thousands). See details section for more.}
#' \item{\code{milper}}{an estimate of the size of military personnel (in thousands) for the state}
#' \item{\code{irst}}{an estimate of iron and steel production (in thousands of tons)}
#' \item{\code{pec}}{an estimate of primary energy consumption (thousands of coal-ton equivalents)}
#' \item{\code{tpop}}{an estimate of the total population size of the state (in thousands)}
#' \item{\code{upop}}{an estimate of the urban population size of the state (in thousands). See details section for more.}
#' \item{\code{cinc}}{The Composite Index of National Capability ("CINC") score. See details section for more.}
#' }
#'
#' @details
#'
#' The user will want to be a little careful with how some of these data are
#' used, beyond the typical caveat about how difficult it is to pin-point how
#' many thousands of coal-tons a state like Baden was producing in the 19th
#' century.
#'
#' First, military expenditures are denominated in British pounds sterling for
#' observations between 1816 and 1913. The observations from 1914 and beyond are
#' denominated in current United States dollars. This is according to the manual.
#'
#' Second, urban population size is an estimate based on, well, an estimate of
#' the size of the population living in an area with 100,000 or more people.
#'
#' Third, the Composite Index of National Capability score is calculated as each
#' state's world share of each of the six composite indicators also included in
#' the data in a given year. It theoretically is bound between 0 and 1. A state
#' with a 1 is 100% responsible for 1) all of the military expenditures in the
#' world, 2) is the only state with a military, 3) does all the iron and steel
#' production, 4) all the world's primary energy consumption, and 5) is the only
#' state in the world with a population and an urban population. Incidentally,
#' the maximum scores observed in the data belong to the United States in 1945.
#'
#'
#' @references
#'
#' Singer, J. David, Stuart Bremer, and John Stuckey. (1972). "Capability
#' Distribution, Uncertainty, and Major Power War, 1820-1965." in
#' Bruce Russett (ed) Peace, War, and Numbers, Beverly Hills: Sage, 19-48.
#'
#' Singer, J. David. 1987. "Reconstructing the Correlates of War Dataset on
#' Material Capabilities of States, 1816-1985" *International Interactions*
#' 14: 115-32.
#'
"cow_nmc"




#' Correlates of War Non-Directed Dyad-Year International Governmental
#' Organizations (IGOs) Data
#'
#' This is a non-directed dyad-year version of the Correlates of War IGOs data.
#' I use it internally for merging IGOs data into dyad-year data.
#'
#' @format A data frame with 917695 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{the Correlates of War state system code for the first state}
#' \item{\code{ccode2}}{the Correlates of War state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{dyadigos}}{the sum of mutual IGOs for which each state appears as a full member in a given year}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains
#' additional information about how these data were generated from the otherwise
#' enormous dyad-year IGOs data provided by the Correlates of War project. Given
#' the size of that data, and the size limitations of R packages for CRAN, the
#' data I provide here can only be simpler summaries. If you want specifics,
#' you'll need to consult the raw data provided on the Correlates of War project.
#' There's only so much I can do.
#'
#' @references
#'
#' Pevehouse, Jon C.W., Timothy Nordstrom, Roseanne W McManus, Anne Spencer
#' Jamison, 2020. “Tracking Organizations in the World: The Correlates of War
#' IGO Version 3.0 datasets”, *Journal of Peace Research* 57(3): 492-503.
#'
#' Wallace, Michael, and J. David Singer. 1970. "International Governmental
#' Organization in the Global System, 1815-1964." *International Organization*
#' 24: 239-87.
#'
"cow_igo_ndy"

#' Correlates of War State-Year International Governmental Organizations (IGOs) Data
#'
#' This is a state-year version of the Correlates of War IGOs data. I use it
#' internally for merging IGOs data into state-year data.
#'
#' @format A data frame with 1557 observations on the following 5 variables.
#' \describe{
#' \item{\code{ccode}}{the Correlates of War state system code for the state}
#' \item{\code{year}}{the year}
#' \item{\code{sum_igo_full}}{the sum of IGOs for which the state is a full member in a given year}
#' \item{\code{sum_igo_associate}}{the sum of IGOs for which the state is just an associate member in a given year}
#' \item{\code{sum_igo_observer}}{the sum of IGOs for which the state is just an observer in a given year}
#' \item{\code{sum_igo_anytype}}{the sum of IGOs for which the state is a member of any kind in a given year.}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains
#' additional information about how these data were generated from the otherwise
#' enormous dyad-year IGOs data provided by the Correlates of War project. Given
#' the size of that data, and the size limitations of R packages for CRAN,
#' the data I provide here can only be simpler summaries. If you want specifics,
#' you'll need to consult the underlying raw data provided on the Correlates
#' of War project. There's only so much I can do.
#'
#'
#' @references
#'
#' Pevehouse, Jon C.W., Timothy Nordstrom, Roseanne W McManus, Anne Spencer
#' Jamison, 2020. “Tracking Organizations in the World: The Correlates of War
#' IGO Version 3.0 datasets”, *Journal of Peace Research* 57(3): 492-503.
#'
#' Wallace, Michael, and J. David Singer. 1970. "International Governmental
#' Organization in the Global System, 1815-1964." *International Organization*
#' 24: 239-87.
#'
"cow_igo_sy"

#' Correlates of War State System Membership Data (1816-2016)
#'
#' These are the Correlates of War state system membership data.
#'
#' @format A data frame with 243 observations on the following 10 variables.
#' \describe{
#' \item{\code{stateabb}}{a character vector for the state abbreviation}
#' \item{\code{ccode}}{a numeric vector for the Correlates of War country code}
#' \item{\code{statenme}}{a character vector for the state name}
#' \item{\code{styear}}{the start year in the system}
#' \item{\code{stmonth}}{the start month in the system}
#' \item{\code{stday}}{the start day in the system}
#' \item{\code{endyear}}{the end year in the system}
#' \item{\code{endmonth}}{the end month in the system}
#' \item{\code{endday}}{the end day in the system}
#' \item{\code{version}}{a version identifier}
#' }
#'
#' @details
#'
#' Data are provided "as-is" with no additional re-cleaning before inclusion
#' into this data set.
#'
#' The functions that previously used these data no longer use these data.
#' They instead use a copy of the data in the \pkg{isard} package I also
#' maintain.
#'
#' @references Correlates of War Project. 2017. "State System Membership
#' List, v2016." Online,
#' \url{https://correlatesofwar.org/data-sets/state-system-membership/}
#'
"cow_states"




#' Correlates of War Intra-State War Data (v. 4.1)
#'
#' These are a modified version of the intra-state war data from the Correlates
#' of War project. Data are version 4.1. The temporal domain is 1816-2007.
#'
#' @format A data frame with 1361 observations on the following 17 variables.
#' \describe{
#' \item{\code{warnum}}{the Correlates of War war number}
#' \item{\code{warname}}{the Correlates of War war name}
#' \item{\code{wartype}}{a character vector for the type of war, either "local issues" or "central control"}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{cowintraonset}}{a dummy variable for whether this is a civil war onset (i.e. either the year in \code{StartYear1} or \code{StartYear2} in the raw data)}
#' \item{\code{cowintraongoing}}{a numeric constant of 1}
#' \item{\code{resume_combat}}{a dummy variable for whether this is a resumption of a conflict (i.e. \code{StartYear2} is not -8)}
#' \item{\code{primary_state}}{a dummy variable for whether the state is the primary state having the civil war}
#' \item{\code{ccodea}}{the Correlates of War state code for the participant on Side A. -8 = not applicable (participant is not a state)}
#' \item{\code{sidea}}{the name of the participant on Side A. -8 = not applicable (no additional party on this side)}
#' \item{\code{ccodeb}}{the Correlates of War state code for the participant on Side B. -8 = not applicable (participant is not a state)}
#' \item{\code{sideb}}{the name of the participant on Side B. -8 = not applicable (no additional party on this side)}
#' \item{\code{intnl}}{a dummy variable for if this is an internationalized civil war}
#' \item{\code{outcome}}{an unordered-categorical variable for the outcome of the civil war. Values include 1 (Side A wins),
#' 2 (Side B wins), 3 (Compromise), 4 (war transformed into another type of war), 5 (war is ongoing at the end of 2007),
#' 6 (stalemate), 7 (conflict continues below severity of war)}
#' \item{\code{sideadeaths}}{the estimated deaths for the Side A participant (-9 = unknown, -8 = not applicable)}
#' \item{\code{sidebdeaths}}{the estimated deaths for the Side B participant (-9 = unknown, -8 = not applicable)}
#' \item{\code{ongo2007}}{a dummy variable for if this war is ongoing as of the end of 2007}
#' }
#'
#' @details See \code{data-raw} directory for how these data were generated. In
#' the Guinea-Bissau Civil War (1998, 1999), the "Mane Junta" have the accented
#' "e" scrubbed to coincide with CRAN's character requirements.
#'
#' @references
#'
#' Dixon, Jeffrey, and Meredith Sarkees. 2016. *A Guide to Intra-State Wars: An
#' Examination of Civil Wars, 1816-2014.* Thousand Oaks, CA: Sage.
#'
#' Sarkees, Meredith Reid, and Frank Wheldon Wayman. 2010. *Resort to War: A Data
#' Guide to Inter-State, Extra-State, Intra-State, and Non-State Wars, 1816-2007.*
#' Washington DC: CQ Press.
#'

"cow_war_intra"


#' Correlates of War Inter-State War Data (v. 4.0)
#'
#' These are a modified version of the inter-state war data from the Correlates
#' of War project. Data are version 4.0. The temporal domain is 1816-2007. Data
#' are functionally directed dyadic war-year.
#'
#' @format A data frame with 1932 observations on the following 15 variables.
#' \describe{
#' \item{\code{warnum}}{the Correlates of War war number}
#' \item{\code{ccode1}}{the Correlates of War state code for side1}
#'  \item{\code{ccode2}}{the Correlates of War state code for side2}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{cowinteronset}}{a dummy variable for whether this is an inter-state war onset (i.e. either the year in \code{StartYear1} or \code{StartYear2} in the raw data)}
#' \item{\code{cowinterongoing}}{a numeric constant of 1}
#' \item{\code{sidea1}}{a numeric vector for the side in the war for \code{ccode1}, either 1 or 2}
#' \item{\code{sidea2}}{a numeric vector for the side in the war for \code{ccode2}, either 1 or 2}
#' \item{\code{initiator1}}{a dummy variable that equals 1 if \code{ccode1} initiated the war}
#' \item{\code{initiator2}}{a dummy variable that equals 1 if \code{ccode2} initiated the war}
#' \item{\code{outcome1}}{the outcome for \code{ccode1} as numeric vector. Outcomes are 1 (winner), 2 (loser), 3 (compromise/tied),
#' 4 (transformed into another type of war), 5 (ongoing at end of 2007, which is not observed in these data), 6 (stalemate),
#' 7 (conflict continues below severity of war), and 8 (changed sides)}
#' \item{\code{outcome2}}{the outcome for \code{ccode2} as numeric vector. Outcomes are 1 (winner), 2 (loser), 3 (compromise/tied),
#' 4 (transformed into another type of war), 5 (ongoing at end of 2007, which is not observed in these data), 6 (stalemate),
#' 7 (conflict continues below severity of war), and 8 (changed sides)}
#' \item{\code{batdeath1}}{the estimated deaths for \code{ccode1} (-9 = unknown)}
#' \item{\code{batdeath2}}{the estimated deaths for \code{ccode2} (-9 = unknown)}
#' \item{\code{resume}}{a dummy variable that equals 1 if this is a conflict resumption episode}
#' }
#'
#' @details
#'
#' See \code{data-raw} directory for how these data were generated. These data
#' are here if you want it, but I caution against using them as gospel. There are
#' a few problems here. One: -9s proliferate the data for battle deaths on either
#' side, which is unhelpful. There are 10 cases where the sum of battle deaths is
#' exactly 1,000 or 1,001. This is suspicious. The "side" variables are not
#' well-explained---in fact they're not explained at all in the codebook---and
#' this can lead a user astray if they want to interpret them analogous to the
#' \code{sidea} variables in the Correlates of War Militarized Interstate Dispute
#' data. You probably want to use the initiator variables for this. Further, the
#' war data routinely betray the MID data and the two do not speak well to each
#' other. The language Sarkees and Wayman (2010) use in their book talk about
#' how MIDs "precede" a war or are "associated" with a war, which forgets the
#' war data are supposed to be a subset of the MID data. In one case (Gulf War),
#' they get the associated dispute number wrong and, in one prominent case (War
#' of Bosnian Independence), they argue no MID exists at all (it's actually
#' MID#3557).
#'
#' @references
#'
#' Sarkees, Meredith Reid, and Frank Wheldon Wayman. 2010. *Resort to War: A Data
#' Guide to Inter-State, Extra-State, Intra-State, and Non-State Wars, 1816-2007.*
#' Washington DC: CQ Press.
#'

"cow_war_inter"
