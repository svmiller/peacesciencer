#' @importFrom tibble tibble
NULL

#' Directed dispute-year data (Gibler, Miller, and Little, 2016)
#'
#' These are directed dispute-year data from the most recent version (2.2.1) of
#' the Gibler-Miller-Little (GML) militarized interstate dispute (MID) data.
#' They are used internally for merging into full dyad-year data frames.
#'
#' @format A data frame with 10,276 observations on the following 39 variables.
#' \describe{
#' \item{\code{dispnum}}{the dispute number}
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{midongoing}}{a constant of 1 for ongoing disputes}
#' \item{\code{midonset}}{a numeric vector that equals 1 for the onset year of a given dispute}
#' \item{\code{sidea1}}{is the first state (in \code{ccode1}) on the side that took the first militarized action?}
#' \item{\code{sidea2}}{is the second state (in \code{ccode2}) on the side that took the first militarized action?}
#' \item{\code{revstate1}}{is the first state (in \code{ccode1}) a revisionist state in the dispute?}
#' \item{\code{revstate2}}{is the second state (in \code{ccode2}) a revisionist state in the dispute?}
#' \item{\code{revtype11}}{what is the \code{revtype1} value for \code{ccode1}?}
#' \item{\code{revtype12}}{what is the \code{revtype1} value for \code{ccode2}?}
#' \item{\code{revtype21}}{what is the \code{revtype2} value for \code{ccode1}?}
#' \item{\code{revtype22}}{what is the \code{revtype2} value for \code{ccode2}?}
#' \item{\code{fatality1}}{what is the \code{fatality} value for \code{ccode1}?}
#' \item{\code{fatality2}}{what is the \code{fatality} value for \code{ccode2}?}
#' \item{\code{fatalpre1}}{what is the \code{fatalpre} value for \code{ccode1}?}
#' \item{\code{fatalpre2}}{what is the \code{fatalpre} value for \code{ccode2}?}
#' \item{\code{hiact1}}{what is the \code{hiact} value for \code{ccode1}?}
#' \item{\code{hiact2}}{what is the \code{hiact} value for \code{ccode2}?}
#' \item{\code{hostlev1}}{what is the \code{hostlev} value for \code{ccode1}?}
#' \item{\code{hostlev2}}{what is the \code{hostlev} value for \code{ccode2}?}
#' \item{\code{orig1}}{is \code{ccode1} an originator (1) of the dispute or a joiner (0)?}
#' \item{\code{orig2}}{is \code{ccode2} an originator (1) of the dispute or a joiner (0)?}
#' \item{\code{hiact}}{the highest level of action observed in the dispute}
#'  \item{\code{hostlev}}{the hostility level of action observed in the dispute}
#'  \item{\code{mindur}}{the minimum length of the dispute (in days)}
#'  \item{\code{maxdur}}{the maximum length of the dispute (in days)}
#'  \item{\code{outcome}}{the dispute-level outcome}
#'  \item{\code{settle}}{the settlement value for the dispute}
#'  \item{\code{fatality}}{the ordinal fatality level for the dispute}
#' \item{\code{fatalpre}}{the fatalities (with precision, if known) for the dispute}
#' \item{\code{stmon}}{the start month of the dispute (dispute-level)}
#' \item{\code{endmon}}{the end month of the dispute (dispute-level)}
#' \item{\code{recip}}{was the dispute reciprocated (i.e. did Side B also have a militarized action)?}
#' \item{\code{numa}}{the number of participants on Side A}
#' \item{\code{numb}}{the number of participants on Side B}
#'  \item{\code{ongo2010}}{was the dispute ongoing as of 2010?}
#'   \item{\code{version}}{a version identifier}
#' }
#'
#' @details
#'
#' Data are the directed dispute-year data made available in version 2.1.1 of
#' the GML MID data.
#'
#' I would caution against using the \code{revtype} variables. They are not
#' informative. They are however included for legacy reasons.
#'
#' @references
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
#' of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
#' *International Studies Quarterly* 60(4): 719-730.
#'
"gml_dirdisp"

#' Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (GML, v. 2.2.1)
#'
#' These are directed dyadic dispute year data derived from the
#' Gibler-Miller-Little (GML) Militarized Interstate Dispute (MID) project. Data
#' are from version 2.2.1. These were whittled to where there is no duplicate
#' dyad-years. Its primary aim here is merging into a dyad-year data frame.
#'
#'
#' @format A data frame with 9,284 observations on the following 24 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{year}}{a numeric vector for the dispute-year}
#' \item{\code{gmlmidongoing}}{a numeric vector for whether there was a dispute ongoing in that year}
#' \item{\code{gmlmidonset}}{a numeric vector for whether it was the onset of a new dispute (or new participant-entry into a recurring dispute)}
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
#' below. Importantly, these data are somewhat "naive." That is: they won't tell
#' you, for example, that Brazil and Japan never directly fought each other
#' during World War II. Instead, it will tell you that there were two years of
#' overlap for the two on different sides of the conflict and that the highest
#' action for both was a war. The data are thus similar to what the
#' `EUGene` program would create for users back in the day. Use these data with
#' that limitation in mind.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level
#' Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{https://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
#' of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
#' *International Studies Quarterly* 60(4): 719-730.

"gml_mid_ddydisps"


#' Abbreviated GML MID Dispute-level Data (v. 2.2.1)
#'
#' This is an abbreviated version of the dispute-level Gibler-Miller-Little (GML) MID data.
#'
#'
#' @format A data frame with 2,174 observations on the following 11 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the CoW-MID dispute number}
#' \item{\code{styear}}{a numeric vector for the start year of the MID}
#' \item{\code{stmon}}{a numeric vector for the start month of the MID}
#' \item{\code{outcome}}{a numeric vector for the outcome of the MID}
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
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
#' of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
#' *International Studies Quarterly* 60(4): 719-730.
#'

"gml_mid_disps"


#' Participant Summaries of the GML-MID Data
#'
#' These are the participant summaries of the most recent GML-MID data. The data
#' also include leaders at the onset and conclusion of a participant episode in
#' the GML MID data.
#'
#'
#' @format A data frame with 5217 observations on the following 19 variables.
#' \describe{
#' \item{\code{dispnum}}{the dispute ID in the GML MID data}
#' \item{\code{ccode}}{the Correlates of War code for the participant}
#' \item{\code{styear}}{the start year for the participant}
#' \item{\code{stmon}}{the start month for the participant}
#' \item{\code{stday}}{the start day for the participant}
#' \item{\code{endyear}}{the end year for the participant}
#' \item{\code{endmon}}{the end month for the participant}
#' \item{\code{endday}}{the end day for the participant}
#' \item{\code{obsid_start}}{an observational ID from \code{archigos} for the leader at the participant onset}
#' \item{\code{obsid_end}}{an observational ID from \code{archigos} for the leader at the participant conclusion}
#' \item{\code{dummy_stday}}{a "dummy" start day for the participant. See details for more.}
#' \item{\code{dummy_endday}}{a "dummy" end day for the participant. See details for more.}
#' \item{\code{sidea}}{was participant on Side A of the dispute}
#' \item{\code{hiact}}{highest action for participant in dispute(-episode)}
#' \item{\code{orig}}{was participant an originator?}
#' \item{\code{anymiss_leader_start}}{a dummy variable for disputes that equals 1 for a dispute in which *any* participant has a missing leader ID at the start date.}
#' \item{\code{anymiss_leader_end}}{a dummy variable for disputes that equals 1 for a dispute in which *any* participant has a missing leader ID at the end date.}
#' \item{\code{allmiss_leader_start}}{a dummy variable for disputes that equals 1 for a dispute in which *all* participants have a missing leader ID at the start date.}
#' \item{\code{allmiss_leader_end}}{a dummy variable for disputes that equals 1 for a dispute in which *all* participants have a missing leader ID at the end date.}
#' }
#'
#' @details
#'
#' Information about leaders come from Archigos (v. 4.1). GML MID Data are
#' version 2.2.1. The \code{data-raw} directory contains information about how
#' these data were generated. There is invariably going to be some guesswork
#' here because dates are sometimes not known with precision. Sometimes, a
#' dispute coincides even with a leadership change when dates are known with
#' precision. The source script includes a discussion of these cases and shows
#' how the data were generated with all these caveats in mind.
#'
#' Do note that participants can have several episodes within a dispute. Sometimes
#' participants switch sides (e.g. Romania in World War 2). Sometime participants
#' drop in and out of a long-running dispute (e.g. Syria, prominently, in
#' MID#4182).
#'
#' "Dummy" start days and end days are there to serve as a parlor trick in
#' assigning disputes to leaders in leader-level analyses. Where days are known
#' with precision, the dummy day is that number. In most cases, where the day is
#' not known with precision coincides with a month that has no leader transition.
#' Thus, the start day that gets imputed is going to be the first of the month
#' (for the dummy start day) or the last of the month (for the dummy end day).
#' Cases where there was a leader transition (or two) that month may require
#' some more sensitive imputing. For example, our best guess is Antonio Guzmán
#' Blanco of Venezuela is president for the end of MID#1639, given his role in
#' trying to negotiate a conclusion to the dispute. Archigos has him leaving
#' office on the 7th, so that's the end day that gets imputed for him. Again,
#' these are here to serve as a parlor trick in assigning disputes to leaders for
#' leader-level analyses. Be careful about using these data for calculating
#' dispute-participant duration. In fact: don't do that.
#'
#' @references
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
#' of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
#' *International Studies Quarterly* 60(4): 719-730.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009.
#' "Introducing Archigos: A Dataset of Political Leaders" *Journal of Peace
#' Research* 46(2): 269--83.

"gml_part"

#' Directed Leader-Dyadic Dispute-Year Data with No Duplicate Leader-Dyad-Years (GML, v. 2.2.1, Archigos v. 4.1)
#'
#' These are directed leader-dyadic dispute year data derived from the
#' Gibler-Miller-Little (GML) Militarized Interstate Dispute (MID) project. Data
#' are from version 2.2.1 (GML-MID) and version 4.1 (Archigos). These were
#' whittled to where there is no duplicate dyad-years. Its primary aim here is
#' merging into a dyad-year data frame.
#'
#'
#' @format A data frame with 10,708 observations on the following 16 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{obsid1}}{a character vector for the leader of the focal state in the dyad, if available}
#' \item{\code{obsid2}}{a character vector for the leader of the target state in the dyad, if available}
#' \item{\code{year}}{a numeric vector for the dispute-year}
#' \item{\code{gmlmidongoing}}{a numeric vector for whether there was a dispute ongoing in that year}
#' \item{\code{gmlmidonset}}{a numeric vector for whether it was the onset of a new dispute (or new participant-entry into a recurring dispute)}
#' \item{\code{sidea1}}{is \code{ccode1} on side A of the dispute?}
#' \item{\code{sidea2}}{is \code{ccode2} on side A of the dispute?}
#' \item{\code{orig1}}{is \code{ccode1} an originator of the dispute?}
#' \item{\code{orig2}}{is \code{ccode2} an originator of the dispute?}
#' \item{\code{obsid_start1}}{the ID of the leader at the dispute onset for \code{ccode1}}
#' \item{\code{obsid_start2}}{the ID of the leader at the dispute onset for \code{ccode2}}
#' \item{\code{obsid_end1}}{the ID of the leader at the dispute conclusion for \code{ccode1}}
#' \item{\code{obsid_end2}}{the ID of the leader at the dispute conclusion for \code{ccode2}}
#' }
#'
#' @details
#'
#' The process of creating these is described at one of the references below.
#' Importantly, these data are somewhat "naive." That is: they won't tell you,
#' for example, that Brazil and Japan never directly fought each other during
#' World War II. Instead, it will tell you that there were two years of overlap
#' for the two on different sides of the conflict and that the highest action
#' for both was a war. The data are thus similar to what the `EUGene`
#' program would create for users back in the day. Use these data with that
#' limitation in mind.
#'
#' Data were created by first selecting on unique onsets. Then, where
#' duplicates remained: retaining highest fatality, highest hostility level,
#' highest estimated minimum duration, reciprocated observations over
#' unreciprocated observations, and, finally, the lowest start month.
#'
#' Be mindful that Archigos' leader data are nominally denominated in
#' Gleditsch-Ward states, which are standardized to Correlates of War state
#' system membership as well as the data can allow. There will be some missing
#' leaders after 1870 because Archigos is ultimately its own system.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level
#' Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{https://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
#' of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
#' *International Studies Quarterly* 60(4): 719-730.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009.
#' "Introducing Archigos: A Dataset of Political Leaders" *Journal of Peace
#' Research* 46(2): 269--83.

"gml_mid_ddlydisps"


#' Directed Leader-Dyadic Dispute-Year Data (GML, v. 2.2.1, Archigos v. 4.1)
#'
#' These are directed leader-dyadic dispute year data derived from the
#' Gibler-Miller-Little (GML) Militarized Interstate Dispute (MID) project. Data
#' are from version 2.2.1 (GML-MID) and version 4.1 (Archigos). The data are all
#' relevant dyadic leader pairings in conflict, allowing users to employ their
#' own case exclusion rules to the data as they see fit.
#'
#'
#' @format A data frame with 11,686 observations on the following 16 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{obsid1}}{a character vector for the leader of the focal state in the dyad, if available}
#' \item{\code{obsid2}}{a character vector for the leader of the target state in the dyad, if available}
#' \item{\code{year}}{a numeric vector for the dispute-year}
#' \item{\code{gmlmidongoing}}{a numeric vector for whether there was a dispute ongoing in that year}
#' \item{\code{gmlmidonset}}{a numeric vector for whether it was the onset of a new dispute (or new participant-entry into a recurring dispute)}
#' \item{\code{sidea1}}{is \code{ccode1} on side A of the dispute?}
#' \item{\code{sidea2}}{is \code{ccode2} on side A of the dispute?}
#' \item{\code{orig1}}{is \code{ccode1} an originator of the dispute?}
#' \item{\code{orig2}}{is \code{ccode2} an originator of the dispute?}
#' \item{\code{obsid_start1}}{the ID of the leader at the dispute onset for \code{ccode1}}
#' \item{\code{obsid_start2}}{the ID of the leader at the dispute onset for \code{ccode2}}
#' \item{\code{obsid_end1}}{the ID of the leader at the dispute conclusion for \code{ccode1}}
#' \item{\code{obsid_end2}}{the ID of the leader at the dispute conclusion for \code{ccode2}}
#' }
#'
#' @details
#'
#' The process of creating these is described at one of the references below.
#' Importantly, these data are somewhat "naive." That is: they won't tell you,
#' for example, that Brazil and Japan never directly fought each other during
#' World War II. Instead, it will tell you that there were two years of overlap
#' for the two on different sides of the conflict and that the highest action
#' for both was a war. The data are thus similar to what the `EUGene`
#' program would create for users back in the day. Use these data with that
#' limitation in mind.
#'
#' Be mindful that Archigos' leader data are nominally denominated in
#' Gleditsch-Ward states, which are standardized to Correlates of War state
#' system membership as well as the data can allow. There will be some missing
#' leaders after 1870 because Archigos is ultimately its own system.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level
#' Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{https://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
#' of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
#' *International Studies Quarterly* 60(4): 719-730.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009.
#' "Introducing Archigos: A Dataset of Political Leaders" *Journal of Peace
#' Research* 46(2): 269--83.

"gml_mid_dirleaderdisps"
