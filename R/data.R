#' @importFrom tibble tibble
NULL

#' A directed dyad-year data frame of Correlates of War state system members
#'
#' This is a complete directed dyad-year data frame of Correlates of War
#' state system members. I offer it here as a shortcut for various other functions when
#' I am working on new additions and don't want to invest time in waiting for
#' \code{create_dyadyears()} to run. As a general rule, this data frame is
#' updated after every calendar year to include the most recently concluded
#' calendar year.
#'
#' @format A data frame with the following 3 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' }
#'
#' @details Data are a quick generation from the \code{create_dyadyears()} function in this package.
#'
"cow_ddy"





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
#' @details Data are provided "as-is" with no additional re-cleaning before inclusion into this data set.
#'
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership/}
#'
"cow_states"




#' A directed dyad-year data frame of Gleditsch-Ward state system members
#'
#' This is a complete directed dyad-year data frame of Gleditsch-Ward
#' state system members. I offer it here as a shortcut for various other
#' functions. As a general rule, this data frame is updated after every
#' calendar year to include the most recently concluded calendar year.
#'
#' @format A data frame with the following 3 variables.
#' \describe{
#' \item{\code{gwcode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{gwcode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' }
#'
#' @details Data are a quick generation from the \code{create_dyadyears(system="gw")} function in this package.
#'
"gw_ddy"


#' Gleditsch-Ward (Independent States) System Membership Data (1816-2017)
#'
#' These are the independent states in Gleditsch and Ward's data.
#'
#' @format A data frame with 216 observations on the following 5 variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward country code}
#' \item{\code{stateabb}}{a character vector for state abbreviation}
#' \item{\code{statename}}{a character vector for the state name}
#' \item{\code{startdate}}{the start date in the data}
#' \item{\code{enddate}}{the end date in the data}
#' }
#'
#' @details
#'
#' Data originally provided by Gleditsch with no column names. Column names
#' were added before some light re-cleaning in order to generate these data.
#' "Wuerttemberg" and "Cote D'Ivoire" in the `statename` column needed to be
#' renamed to ensure maximal compliance with CRAN, which raises notes for
#' every non-ASCII character that appears in its package. I do not think this
#' to be problematic at all and, after all, state names should never be
#' a basis for something like a match or merge you would do in
#' \pkg{countrycode}.
#'
#' @references
#'
#' Gleditsch, Kristian S. and Michael D. Ward. 1999. "A Revised List of
#' Independent States since the Congress of Vienna."
#' *International Interactions* 25(4): 393--413.
#'
"gw_states"


#' Zeev Maoz' Regional/Global Power Data
#'
#' These are Zeev Maoz' data for what states are regional or global powers at a given point time. They are
#' extensions of the Correlates of War major power data, which only codes "major" power without consideration
#' of regional or global distinctions. Think of Austria-Hungary as intuitive of the issue here. Austria-Hungary
#' is a major power in the Correlates of War data, but there is good reason to treat Austria-Hungary as a major
#' power only within Europe. That is what Zeev Maoz tries to do here.
#'
#' @format A data frame with 20 observations on the following 5 variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War country code}
#' \item{\code{regstdate}}{the start date for regional power status}
#' \item{\code{regenddate}}{the end date for regional power status}
#' \item{\code{globstdate}}{the start date for global power status}
#' \item{\code{globenddate}}{the end date for global power status}
#' }
#'
#'
#' @references Maoz, Zeev. 2010. Network of Nations: The Evolution, Structure, and Impact of International Networks, 1816-2001. Cambridge University Press.
#'
#'
"maoz_powers"




#' Correlates of War Non-Directed Dyad-Year International Governmental Organizations (IGOs) Data
#'
#' This is a non-directed dyad-year version of the Correlates of War IGOs data. I use it internally for merging IGOs data into dyad-year data.
#'
#' @format A data frame with 917695 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{the Correlates of War state system code for the first state}
#' \item{\code{ccode2}}{the Correlates of War state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{dyadigos}}{the sum of mutual IGOs for which each state appears as a full member in a given year}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains additional information about how these data were generated from the otherwise
#' enormous dyad-year IGOs data provided by the Correlates of War project. Given the size of that data, and the size limitations of R packages for CRAN,
#' the data I provide here can only be simpler summaries. If you want specifics, you'll need to consult the underlying raw data provided on the Correlates
#' of War project.
#'
#' @references
#'
#' Pevehouse, Jon C.W., Timothy Nordstrom, Roseanne W McManus, Anne Spencer Jamison, 2020. “Tracking Organizations in the World: The Correlates of War IGO Version 3.0 datasets”, Journal of Peace Research 57(3): 492-503.
#'
#' Wallace, Michael, and J. David Singer. 1970. "International Governmental Organization in the Global System, 1815-1964." International Organization 24: 239-87.
#'
"cow_igo_ndy"

#' Correlates of War State-Year International Governmental Organizations (IGOs) Data
#'
#' This is a state-year version of the Correlates of War IGOs data. I use it internally for merging IGOs data into state-year data.
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
#' @details The \code{data-raw} directory on the project's Github contains additional information about how these data were generated from the otherwise
#' enormous dyad-year IGOs data provided by the Correlates of War project. Given the size of that data, and the size limitations of R packages for CRAN,
#' the data I provide here can only be simpler summaries. If you want specifics, you'll need to consult the underlying raw data provided on the Correlates
#' of War project.
#'
#' @references
#'
#' Pevehouse, Jon C.W., Timothy Nordstrom, Roseanne W McManus, Anne Spencer Jamison. 2020. “Tracking Organizations in the World: The Correlates of War IGO Version 3.0 datasets”, Journal of Peace Research 57(3): 492-503.
#'
#' Wallace, Michael, and J. David Singer. 1970. "International Governmental Organization in the Global System, 1815-1964." International Organization 24: 239-87.
#'
"cow_igo_sy"

#' The Minimum Distance Between States in the Correlates of War System, 1886-2019
#'
#' These are non-directed dyad-year data for the minimum distance between states in the Correlates of War state system from
#' 1886 to 2019. The data are generated from the \pkg{cshapes} package.
#'
#' @format A data frame with 817053 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{the Correlates of War state system code for the first state}
#' \item{\code{ccode2}}{the Correlates of War state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{mindist}}{the minimum distance between states on Jan. 1 of the year, in kilometers}
#' }
#'
#' @details The data are generated from the \pkg{cshapes} package. Data are automatically generated
#' (by default) as directed dyad-years. I elect to make them non-directed for space considerations.
#' Making non-directed dyad-year data into directed dyad-year data isn't too difficult in R. It just
#' looks weird to see the code that does it.
#'
#' Previous versions of these data were for the minimum distance as of Dec. 31 of the referent year. These are now Jan. 1.
#' Most of the data I provide elsewhere in this package are  to be understood as the data as they were at the *start* of
#' the year. This is how I process, for example, the \code{capitals} data as they get merged in the \code{add_capital_distance()}
#' function. However, the script that generates these data are set at Jan. 1 of the year and not Dec. 31. Right now, the \pkg{cshapes}
#' does not appear to work on my system and I do not know why. Fortunately, the package authors made these data available.
#'
#' @references
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik Cederman,
#' and Kristian Skrede Gleditsch. 2022. "Mapping The International System, 1886-2017:
#' The \code{CShapes} 2.0 Dataset." \emph{Journal of Conflict Resolution}. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring Country Shapes: The \code{cshapes} Package." \emph{The R Journal} 2(1): 18-24

"cow_mindist"

#' The Minimum Distance Between States in the Gleditsch-Ward System, 1886-2019
#'
#' These are non-directed dyad-year data for the minimum distance between states in the Gleditsch-Ward state system from
#' 1886 to 2018. The data are generated from the \pkg{cshapes} package.
#'
#' @format A data frame with 868813 observations on the following 4 variables.
#' \describe{
#' \item{\code{gwcode1}}{the Gleditsch-Ward state system code for the first state}
#' \item{\code{gwcode2}}{the Gleditsch-Ward state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{mindist}}{the minimum distance between states on Jan. 1 of the year, in kilometers}
#' }
#'
#' @details The data are generated from the \pkg{cshapes} package. The package authors purport that the data
#' are generated to be compatible with the Gleditsch-Ward system. I trust them on this; indeed, Gleditsch is one of the
#' authors of the \pkg{cshapes} package.
#'
#' Data are automatically generated (by default) as directed dyad-years. I elect to make them non-directed for space
#' considerations. Making non-directed dyad-year data into directed dyad-year data isn't too difficult in R. It just
#' looks weird to see the code that does it.
#'
#' Previous versions of these data were for the minimum distance as of Dec. 31 of the referent year. These are now Jan. 1.
#' Most of the data I prove elsewhere in this package are  to be understood as the data as they were at the *start* of
#' the year. This is how I process, for example, the \code{capitals} data as they get merged in the \code{add_capital_distance()}
#' function. However, the script that generates these data are set at Jan. 1 of the year and not Dec. 31. Right now, the \pkg{cshapes}
#' does not appear to work on my system and I do not know why. Fortunately, the package authors made these data available.
#'
#' @references
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik Cederman,
#' and Kristian Skrede Gleditsch. 2022. "Mapping The International System, 1886-2017:
#' The \code{CShapes} 2.0 Dataset." \emph{Journal of Conflict Resolution}. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring Country Shapes: The \code{cshapes} Package." \emph{The R Journal} 2(1): 18-24

"gw_mindist"

#' Alliance Treaty Obligations and Provisions (ATOP) Project Data (v. 5.1)
#'
#' These are directed dyad-year-level data for alliance obligations and
#' provisions from the ATOP project.
#'
#'
#' @format A data frame with 273,296 observations on the following eight variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{atop_defense}}{a numeric vector that equals 1 if there was an alliance observed with a defense pledge}
#' \item{\code{atop_offense}}{a numeric vector that equals 1 if there was an alliance observed with a offense pledge}
#' \item{\code{atop_neutral}}{a numeric vector that equals 1 if there was an alliance observed with a neutrality pledge}
#' \item{\code{atop_nonagg}}{a numeric vector that equals 1 if there was an alliance observed with a non-aggression pledge}
#' \item{\code{atop_consul}}{a numeric vector that equals 1 if there was an alliance observed with a consultation pledge}
#' }
#'
#' @details
#'
#' The \code{data-raw} directory on the project's Github shows how the data
#' were processed.
#'
#' @references
#'
#' Leeds, Brett Ashley, Jeffrey M. Ritter, Sara McLaughlin Mitchell, and Andrew
#' G. Long. 2002. "Alliance Treaty Obligations and Provisions, 1815-1944."
#' *International Interactions* 28: 237-60.

"atop_alliance"

#' UCDP Onset Data (v. 19.1)
#'
#' These are state-year level data for armed conflict onsets provided by the Uppsala Conflict Data Program (UCDP).
#'
#'
#' @format A data frame with 10142 observations on the following eight variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{sumnewconf}}{a numeric vector for the sum of new conflicts/conflict-dyads}
#' \item{\code{sumonset1}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than one year since last conflict episode}
#' \item{\code{sumonset2}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than two years since last conflict episode}
#' \item{\code{sumonset3}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than three years since last conflict episode}
#' \item{\code{sumonset5}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than five years since last conflict episode}
#' \item{\code{sumonset10}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than 10 years since last conflict episode}
#' }
#' @details The user will want to note that the data provided by UCDP are technically not country-year observations. They instead duplicate observations for cases of new conflicts
#' or new conflict episodes. Further, the original data do not provide any information about the conflict-dyad in question to which those duplicates pertain. That means the most
#' these data can do for the package's mission is provide summary information. The user should probably recode these variables into something else they may want for a
#' particular application
#'
#'
#' @references
#'
#' Gleditsch, Nils Petter; Peter Wallensteen, Mikael Eriksson, Margareta Sollenberg & Havard Strand (2002)
#' Armed Conflict 1946–2001: A New Dataset. \emph{Journal of Peace Research} 39(5): 615–637.
#'
#' Pettersson, Therese; Stina Hogbladh & Magnus Oberg (2019). Organized violence, 1989-2018 and peace
#' agreements. Journal of Peace Research 56(4): 589-603.

"ucdp_onsets"

#' UCDP Armed Conflict Data (ACD) (v. 20.1)
#'
#' These are (kind of) dyadic, but mostly state-level data, used internally for doing stuff with the UCDP armed conflict data
#'
#'
#' @format A data frame with 4164 observations on the following 15 variables.
#' \describe{
#' \item{\code{conflict_id}}{a conflict identifier, not to be confused with an episode identifier (which I don't think UCDP offers)}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{gwno_a}}{the Gleditsch-Ward state code for the state on side A of the armed conflict}
#' \item{\code{gwno_a_2nd}}{the Gleditsch-Ward state code for the state that actively supported side A of the armed conflict with the use of troops}
#' \item{\code{gwno_b}}{the Gleditsch-Ward state code for the actor on side B of the armed conflict}
#' \item{\code{gwno_b_2nd}}{the Gleditsch-Ward state code for the state that actively supported side B of the armed conflict with the use of troops}
#' \item{\code{incompatibility}}{a character vector for the main conflict issue ("territory", "government", "both")}
#' \item{\code{intensity_level}}{a numeric vector for the intensity level in the calendar year (1 = minor (25-999 deaths), 2 = war (>1,000 deaths))}
#' \item{\code{type_of_conflict}}{a character vector for the type of conflict ("extrasystemic", "interstate", "intrastate", "II"). "II" is a simple abbreviation of "internationalized intrastate"}
#' \item{\code{start_date}}{a date of the first battle-related death in the conflict, not to be confused with the first battle-related death of the episode}
#' \item{\code{start_prec}}{the level of precision for \code{start_date}}
#' \item{\code{start_date2}}{a date of the first battle-related death in the episode, not to be confused with the first battle-related death of the conflict}
#' \item{\code{start_prec2}}{the level of precision for \code{start_date2}}
#' \item{\code{ep_end}}{a dummy variable for whether the conflict episode ended in the calendar year of observation}
#' \item{\code{ep_end_date}}{the episode end date, if applicable}
#' }
#' @details The \code{data-raw} directory on the project's Github will show how I processed the multiple strings for when there are multiple states on a given side.
#'
#'
#' @references
#'
#' Gleditsch, Nils Petter; Peter Wallensteen, Mikael Eriksson, Margareta Sollenberg & Havard Strand (2002)
#' Armed Conflict 1946–2001: A New Dataset. \emph{Journal of Peace Research} 39(5): 615–637.
#'
#' Pettersson, Therese; Stina Hogbladh & Magnus Oberg (2019). Organized violence, 1989-2018 and peace
#' agreements. Journal of Peace Research 56(4): 589-603.

"ucdp_acd"



















#' Thompson and Dreyer's (2012) Strategic Rivalries, 1494-2010
#'
#' A simple summary of all strategic (inter-state) rivalries from Thompson and Dreyer (2012).
#'
#'
#' @format A data frame with 197 observations on the following 10 variables.
#' \describe{
#'\item{\code{rivalryno}}{a numeric vector for the rivalry number}
#'\item{\code{rivalryname}}{a character vector for the rivalry name}
#'\item{\code{ccode1}}{the Correlates of War state code for the state with the lowest Correlates of War state code in the rivalry}
#'\item{\code{ccode2}}{the Correlates of War state code for the state with the highest Correlates of War state code in the rivalry}
#'\item{\code{styear}}{a numeric vector for the start year of the rivalry}
#'\item{\code{endyear}}{a numeric vector for the end year of the rivalry}
#'\item{\code{region}}{a character vector for the region of the rivalry, per Thompson and Dreyer (2012)}
#'\item{\code{type1}}{a character vector for the primary type of the rivalry (spatial, positional, ideological, or interventionary)}
#'\item{\code{type2}}{a character vector for the secondary type of the rivalry, if applicable (spatial, positional, ideological, or interventionary)}
#' \item{\code{type3}}{a character vector for the tertiary type of the rivalry, if applicable (spatial, positional, ideological, or interventionary)}
#' }
#' @details Information gathered from the appendix of Thompson and Dreyer (2012). Ongoing rivalries are
#' right-bound at 2010, the date of publication for Thompson and Dreyer's handbook. Users are free to change this if they like. Data are effectively
#' identical to \code{strategic_rivalries} in \pkg{stevemisc}, but include some behind-the-scenes processing (described in a blog post on
#' \url{https://svmiller.com}) that is available to see on the project's Github repository. The data object is also renamed to avoid a conflict.
#'
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
#' URL: \url{https://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R. and David Dreyer. 2012. \emph{Handbook of International Rivalries}. CQ Press.
#'
"td_rivalries"






#' Historical Index of Ethnic Fractionalization data
#'
#' This is a data set with state-year estimates for ethnic fractionalization.
#'
#' @format A data frame with 8808 observations on the following 5 variables.
#' \describe{
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{year}}{the year}
#' \item{\code{efindex}}{a numeric vector for the estimate of ethnic fractionalization}
#' }
#'
#' @details
#'
#' The \code{data-raw} directory on the project's Github contains more
#' information about how these data were created.
#'
#' @references
#'
#' Drazanova, Lenka. 2020. "Introducing the Historical Index of Ethnic
#' Fractionalization (HIEF) Dataset: Accounting for Longitudinal Changes in
#' Ethnic Diversity." \emph{Journal of Open Humanities Data} 6:6
#' \doi{10.5334/johd.16}
#'
"hief"


#' Composition of Religious and Ethnic Groups (CREG) Fractionalization/Polarization Estimates
#'
#' This is a data set with state-year estimates for ethnic and religious
#' fractionalization/polarization, by way of the Composition of Religious and
#' Ethnic Groups (CREG) project at the University of Illinois. I-L-L.
#'
#' @format A data frame with 11523 observations on the following 9 variables.
#' \describe{
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{creg_ccode}}{a numeric code for the state, mostly patterned off Correlates of War codes but with important differences. See details section for more.}
#' \item{\code{year}}{the year}
#' \item{\code{ethfrac}}{an estimate of the ethnic fractionalization index. See details for more.}
#' \item{\code{ethpol}}{an estimate of the ethnic polarization index. See details for more.}
#' \item{\code{relfrac}}{an estimate of the religious fractionalization index. See details for more.}
#' \item{\code{relpol}}{an estimate of the religious polarization index. See details for more.}
#' }
#'
#' @details
#'
#' The \code{data-raw} directory on the project's Github contains more
#' information about how these data were created. Pay careful attention to how I
#' assigned CoW/G-W codes. The underlying data are version 1.02.
#'
#' The state codes provided by the CREG project are mostly Correlates of War
#' codes, but with some differences. Summarizing these differences: the state
#' code for Serbia from 1992 to 2013 is actually the Gleditsch-Ward code (340).
#' Russia after the dissolution of the Soviet Union (1991-onward) is 393 and not
#' 365. The Soviet Union has the 365 code. Yugoslavia has the 345 code. The code
#' for Yemen (678) is effectively the Gleditsch-Ward code because it spans the
#' entire post-World War II temporal domain. Likewise, the code for
#' post-unification Germany is the Gleditsch-Ward code (260) as well. The
#' codebook actually says it's 265 (which would be East Germany's code), but
#' this is assuredly a typo based on the data.
#'
#' The codebook cautions there are insufficient data for ethnic group estimates
#' for Cameroon, France, India, Kosovo, Montenegro, Mozambique, and Papua New
#' Guinea. The French case is particularly disappointing but the missing data
#' there are a function of both France's constitution and modelling issues for
#' CREG (per the codebook). There are insufficient data to make religious group
#' estimates for China, North Korea, and the short-lived Republic of Vietnam.
#'
#' The fractionalization estimates are the familiar Herfindahl-Hirschman
#' concentration index. The polarization formula comes by way of  Montalvo and
#' Reynal-Querol (2000), though this book does not appear to be published beyond
#' its placement online. I recommend Montalvo and Reynal-Querol (2005) instead.
#' You can cite Alesina (2003) for the fractionalization measure if you'd like.
#'
#' In the most literal sense of "1", the group proportions may not sum to
#' exactly 1 because of rounding in the data. There were only two problem cases
#' in these data worth mentioning. First, in both data sets, there would be the
#' occasional duplicates of group names by state-year (for example: Afghanistan
#' in 1951 in the ethnic group data and the United States in 1948 in the
#' religious group data). In those cases, the script I make available in the
#' `data-raw` directory just select distinct values and that effectively fixes
#' the problem of duplicates, where they do appear. Finally, Costa Rica had a
#' curious problem for most years in the religious group data. All Costa Rica
#' years have group data for Protestants, Roman Catholics, and "others." Up
#' until 1964 or so, the "others" are zero. Afterward, there is some small
#' proportion of "others". However, the sum of Protestants, Roman Catholics, and
#' "others" exceeds 1 (pretty clearly) and the difference between the sum and 1
#' is entirely the "others." So, I drop the "others" for all years. I don't
#' think that's terribly problematic, but it's worth saying that's what I did.
#'
#' @references
#'
#' Alesina, Alberto, Arnaud Devleeschauwer, William Easterly, Sergio Kurlat and
#' Romain Wacziarg. 2003. "Fractionalization". *Journal of Economic Growth* 8: 155-194.
#'
#' Montalvo, Jose G. and Marta Reynal-Querol. 2005. "Ethnic Polarization,
#' Potential Conflict, and Civil Wars." *American Economic Review* 95(3):
#' 796--816.
#'
#' Nardulli, Peter F., Cara J. Wong, Ajay Singh, Buddy Petyon, and Joseph
#' Bajjalieh. 2012. *The Composition of Religious and Ethnic Groups (CREG)
#' Project*. Cline Center for Democracy.
#'
"creg"


#' Correlates of War Intra-State War Data (v. 4.1)
#'
#' These are a modified version of the intra-state war data from the Correlates of War project. Data are version 4.1. The temporal domain is
#' 1816-2007.
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
#' @details See \code{data-raw} directory for how these data were generated. In the Guinnea-Bissau Civil War (1998, 1999),
#' the "Mane Junta" have the accented-e scrubbed to coincide with CRAN's character requirements.
#'
#' @references
#'
#' Dixon, Jeffrey, and Meredith Sarkees. 2016. A Guide to Intra-State Wars: An Examination of Civil Wars, 1816-2014. Thousand Oaks, CA: Sage.
#'
#' Sarkees, Meredith Reid, and Frank Wheldon Wayman. 2010. Resort to War: A Data Guide to Inter-State, Extra-State, Intra-State, and Non-State Wars, 1816-2007.
#' Washington DC: CQ Press.
#'

"cow_war_intra"


#' Correlates of War Inter-State War Data (v. 4.0)
#'
#' These are a modified version of the inter-state war data from the Correlates of War project. Data are version 4.0. The temporal domain is
#' 1816-2007. Data are functionally directed dyadic war-year.
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
#' @details See \code{data-raw} directory for how these data were generated. These data are here if you want it, but I caution against using them
#' as gospel. There are a few problems here. One: -9s proliferate the data for battle deaths on either side, which is unhelpful. There are 10 cases where the sum
#' of battle deaths is exactly 1,000 or 1,001. This is suspicious. The "side" variables are not well-explained---in fact they're not explained at all in the codebook---
#' and this can lead a user astray if they want to interpret them analogous to the \code{sidea} variables in the Correlates of War Militarized Interstate Dispute
#' data. You probably want to use the initiator variables for this. Further, the war data routinely betray the MID data and the two do not speak well to each other. The language Sarkees and Wayman (2010) use in their book
#' talk about how MIDs "precede" a war or are "associated" with a war, which forgets the war data are supposed to be a subset of the MID data. In one case (Gulf War),
#' they get the associated dispute number wrong and, in one prominent case (War of Bosnian Independence), they argue no MID exists at all (it's actually MID#3557).
#'
#' @references
#'
#' Sarkees, Meredith Reid, and Frank Wheldon Wayman. 2010. Resort to War: A Data Guide to Inter-State, Extra-State, Intra-State, and Non-State Wars, 1816-2007.
#' Washington DC: CQ Press.
#'

"cow_war_inter"


#' A \code{BibTeX} Data Frame of Citations
#'
#' This is a \code{BibTeX} file, loaded as a data frame, to assist the user in properly citing the source material that is used in this package.
#'
#' @format A data frame with the following columns.
#' \describe{
#' \item{\code{CATEGORY}}{the \code{BibTeX} entry type}
#' \item{\code{BIBTEXKEY}}{the \code{BibTeX} unique entry key}
#'  \item{\code{ADDRESS}}{another \code{BibTeX} field}
#' \item{\code{ANNOTE}}{another \code{BibTeX} field}
#' \item{\code{AUTHOR}}{a list of authors for this entry}
#' \item{\code{BOOKTITLE}}{another \code{BibTeX} field, for book title (if appropriate)}
#' \item{\code{CHAPTER}}{another \code{BibTeX} field, for chapter (if appropriate)}
#' \item{\code{CROSSREF}}{another \code{BibTeX} field}
#' \item{\code{EDITION}}{another \code{BibTeX} field, for edition of book (if appropriate)}
#' \item{\code{EDITOR}}{another \code{BibTeX} field, for book editor (if appropriate)}
#' \item{\code{HOWPUBLISHED}}{another \code{BibTeX} field}
#' \item{\code{INSTITUTION}}{another \code{BibTeX} field}
#' \item{\code{JOURNAL}}{another \code{BibTeX} field, for the journal name (if appropriate)}
#' \item{\code{KEY}}{another \code{BibTeX} field}
#' \item{\code{MONTH}}{another \code{BibTeX} field}
#' \item{\code{NOTE}}{another \code{BibTeX} field}
#' \item{\code{NUMBER}}{another \code{BibTeX} field, for journal volume number (if appropriate)}
#' \item{\code{ORGANIZATION}}{another \code{BibTeX} field}
#' \item{\code{PAGES}}{another \code{BibTeX} field, for pages of the entry}
#' \item{\code{PUBLISHER}}{another \code{BibTeX} field, for book publisher (if appropriate)}
#' \item{\code{SCHOOL}}{another \code{BibTeX} field}
#' \item{\code{SERIES}}{another \code{BibTeX} field}
#' \item{\code{TITLE}}{another \code{BibTeX} field, for title of the entry}
#' \item{\code{TYPE}}{another \code{BibTeX} field}
#' \item{\code{VOLUME}}{another \code{BibTeX} field, for journal volume (if appropriate)}
#' \item{\code{YEAR}}{another \code{BibTeX} field, for year of publication}
#' \item{\code{KEYWORDS}}{another \code{BibTeX} field, used primarily for selective filtering in this package}
#' \item{\code{URL}}{another \code{BibTeX} field, for website (if appropriate)}
#' \item{\code{OWNER}}{another \code{BibTeX} field}
#' \item{\code{TIMESTAMP}}{another \code{BibTeX} field, used occasionally when I started populating my master file (you will see some old entries here)}
#' \item{\code{DOI}}{another \code{BibTeX} field, for a digital object identifier (used rarely)}
#' \item{\code{EPRINT}}{another \code{BibTeX} field}
#' \item{\code{JOURNALTITLE}}{another \code{BibTeX} field, which I think is actually a \code{BibLaTeX} field}
#' \item{\code{ISSN}}{another \code{BibTeX} field}
#' \item{\code{ABSTRACT}}{another \code{BibTeX} field, for entry abstract (if appropriate)}
#' \item{\code{DATE.ADDED}}{another \code{BibTeX} field}
#' \item{\code{DATE.MODIFIED}}{another \code{BibTeX} field}
#' }
#'
#' @details See \code{data-raw} directory for how these data were generated. The data were created by \pkg{bib2df}, which is now a package dependency.
#' I assume the user has some familiarity with \code{BibTeX}. Some entries were copy-pasted from my master bibliography file that I started in 2008 or so.
#'
#'

"ps_bib"




















#' The Version Numbers for Data Included in \pkg{peacesciencer}
#'
#' This is a simple data set that communicates the version numbers of data included in this package. It's a companion
#' to the data frame \code{ps_bib}, and other information functions like \code{ps_cite()} and \code{ps_version()}. The latter
#' uses this data set.
#'
#'
#' @format A data frame the following four variables.
#' \describe{
#' \item{\code{category}}{a category for the type of data}
#' \item{\code{data}}{the name of the particular data source coinciding with the category}
#' \item{\code{version}}{the version number included in \pkg{peacesciencer} for this data source}
#' \item{\code{bibtexkey}}{a character key for the \code{BibTeX} key corresponding with an appropriate citation in \code{ps_bib}}
#' }
#'
#' @details
#'
#' Version numbers that are years should be understood as data sources with no formal version numbering system, per se. Instead,
#' they communicate a year of last update. For example, the Correlates of War does not formally version number its state system data
#' as it does its MID data. Likewise, the Anders et al. (2020) simulations of population and surplus/gross domestic product are not formally
#' versioned, per se. Instead, the data were published and last updated in 2020.


"ps_data_version"


#' False Correlates of War Directed Dyad-Years
#'
#' This is a simple data set that communicates directed dyads in the Correlates of War data that appear in the same year,
#' but not in any particular day in the year. They are used in an anti-join in the \code{create_dyadyears()} function in this package.
#'
#'
#' @format A data frame the following four variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{in_ps}}{a constant that equals 1 if these data would appear in \code{create_dyadyears()} if you were not careful to remove them.}
#' }
#'
#' @details
#'
#' Think of the directed Suriname and Republic of Vietnam dyad here as illustrative here. The Republic of Vietnam exits the
#' Correlates of War state system on April 30, 1975 whereas Suriname enters the state system on November 25, 1975. Both appear in the same
#' year, but not at the same time.
#'

"false_cow_dyads"


#' False Gleditsch-Ward Directed Dyad-Years
#'
#' This is a simple data set that communicates directed dyads in the Gleditsch-Ward data that appear in the same year,
#' but not in any particular day in the year. They are used in an anti-join in the \code{create_dyadyears()} function in this package.
#'
#'
#' @format A data frame the following four variables.
#' \describe{
#' \item{\code{gwcode1}}{a numeric vector for the Gleditsch-Ward state code for the first state}
#' \item{\code{gwcode2}}{a numeric vector for the Gleditsch-Ward state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{in_ps}}{a constant that equals 1 if these data would appear in \code{create_dyadyears()} if you were not careful to remove them.}
#' }
#'
#' @details
#'
#' Think of the directed Suriname and Republic of Vietnam dyad here as illustrative here. The Republic of Vietnam exits the
#' Correlates of War state system on April 30, 1975 whereas Suriname enters the state system on November 25, 1975. Both appear in the same
#' year, but not at the same time.
#'

"false_gw_dyads"






#' Conventional Arms Races During Periods of Rivalry
#'
#' This is a simple data set of 71 arms races reported by Gibler et al. in their 2005 article in \emph{Journal of Peace Research}.
#'
#'
#' @format A data frame the following five variables.
#' \describe{
#' \item{\code{race_id}}{the arms race identifier}
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{styear}}{the start year for the arms race}
#' \item{\code{endyear}}{the end year for the arms race}
#' }
#'
#' @details
#'
#' Data are taken from the appendix of Gibler, Rider, and Hutchison's 2005 article in *Journal of Peace Research*. Read the
#' article and appendix for more information about coding procedures.
#'
#' @references
#'
#' Gibler, Douglas M., Toby J. Rider, and Marc L. Hutchison. 2005. "Taking Arms Against
#' a Sea of Troubles: Conventional Arms Races during Periods of Rivalry"
#' *Journal of Peace Research* 42(2): 131--47.

"grh_arms_races"


#' Thompson et al. (2021) Strategic Rivalries, 1494-2020
#'
#' A simple summary of all strategic (inter-state) rivalries from Thompson
#' et al. (2021). This is a simple spreadsheet entry job (with some light
#' cleaning) based on information provided from pages 34 to 46 in their
#' book.
#'
#'
#' @format A data frame with 264 observations on the following 12 variables.
#' \describe{
#'\item{\code{tssr_id}}{a numeric vector for the rivalry number}
#'\item{\code{rivalry}}{a character vector for the rivalry name}
#'\item{\code{ccode1}}{the Correlates of War state code for the state with the lowest Correlates of War state code in the rivalry}
#'\item{\code{ccode2}}{the Correlates of War state code for the state with the highest Correlates of War state code in the rivalry}
#'\item{\code{start}}{a numeric vector for the start year of the rivalry}
#'\item{\code{end}}{a numeric vector for the end year of the rivalry}
#'\item{\code{positional}}{a numeric vector that is 1 if Thompson et al. (2021) say the rivalry has a positional element (`NA` otherwise)}
#'\item{\code{spatial}}{a numeric vector that is 1 if Thompson et al. (2021) say the rivalry has a spatial element (`NA` otherwise)}
#'\item{\code{ideological}}{a numeric vector that is 1 if Thompson et al. (2021) say the rivalry has an ideological element (`NA` otherwise)}
#'\item{\code{interventionary}}{a numeric vector that is 1 if Thompson et al. (2021) say the rivalry has an interventionary element (`NA` otherwise)}
#' \item{\code{principal}}{a numeric vector that is 1 if Thompson et al. (2021) say the rivalry is the primary (principal) rivalry for the rivals (`NA` otherwise)}
#' \item{\code{aprin}}{a numeric vector that is 1 if Thompson et al. (2021) say this is an asymmetric principal rivalry (`NA` otherwise)}
#' }
#' @details Information gathered from chapter 2 of Thompson et al. (2021).
#' Ongoing rivalries are right-bound at 2020. In several cases, start dates
#' of 1494 and 1816 originally had a "P" attached to them, indicating they
#' were ongoing before that particular year. This is captured in the "raw"
#' spreadsheet included in the "data-raw" directory, though this is adjusted
#' in this finished data product.
#'
#' This file adjusts for what are (assuredly) three print errors in Thompson et
#' al. (2021). In print, Thompson et al. (2021) say the Italy-Turkey rivalry
#' extends from 1884-1843, the Mauritania-Morocco rivalry extends from 1060-1969,
#' and the Bulgaria-Yugoslavia rivalry extends from 1878 to 1855. They had meant
#' an end year of 1943 in the first case, a start year of 1960 in the second case,
#' and an end year of 1955 in the third case. This is fixed in this version.
#'
#' Venice never appears in any data set in the Correlates of War ecosystem of
#' data and thus never has any semblance of state code (of which I'm aware) that
#' I could assign it. I gave it a country code of 324 for the sake of these data
#' (and the previous Thompson and Dreyer (2012) version of it). You'll never use
#' this, but it's worth saying that's what I did.
#'
#' Thompson et al. (2021) dedicate their book to expanding on the various
#' types of rivalry. Users who know the Thompson and Dreyer (2012) version
#' will see a few differences here. First, rivalries no longer have formal
#' primary, secondary, or tertiary types. Instead, rivalries have
#' there/not there markers for whether a particular element of a rivalry type
#' is present in the rivalry. From what I've read so far of Thompson et al.
#' (2021), along with their ordering of the information in Chapter 2, it reads
#' like they've just made informal what was otherwise a more formal classification
#' component to the Thompson and Dreyer (2012) rivalry data. Positional rivalries
#' seem to be an informal "type 1" as Thompson et al. (2021) discuss it, not
#' at all dissimilar to how the classic alliance scholarship treats defense as
#' a "type 1" pledge. No matter, this book is already more explicit that
#' positional and spatial rivalries are clearly different from ideological
#' and interventionary rivalries, and certainly the interventionary rivalries.
#'
#' "Principal" and "asymmetric principal" rivalries are a new classification in
#' Thompson et al. (2021), relative to Thompson and Dreyer (2012). "Principal"
#' rivalries exist where 1) the two rivals have no other rivalry or 2) the two
#' rivals elevate this rivalry as their primary rivalry among other rivalries.
#' Asymmetric principal rivalries are when only one of the two rivals sees the
#' other as its primary rival. Consider two U.S.-Russian rivalries as
#' illustrative. The rivalry with the Soviet Union (`tssr_id = 100`) was
#' the primary rivalry for the U.S. (and the Soviet Union). However, the U.S.
#' presently sees China as its main rival (`tssr_id = 211`). The ongoing
#' rivalry with Russia (`tssr_id = 246`) is one where Russia sees the U.S.
#' as its primary rival but the U.S. does not see Russia the same way.
#'
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
#' URL: \url{https://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R., Kentaro Sakuwa, and Prashant Hosur Suhas. 2021.
#' *Analyzing Strategic Rivalries in World Politics: Types of Rivalry,
#' Regional Variation, and Escalation/De-escalation*. Springer.
#'
"tss_rivalries"
