#' @importFrom tibble tibble
NULL

#' A complete list of capitals and capital transitions for Correlates of War state system members
#'
#' This is a complete list of capitals and capital transitions for Correlates of War state system members. I
#' use it internally for calculating capital-to-capital distances in the \code{add_capital_distances()} function.
#'
#' @format A data frame with 252 observations on the following 7 variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War state code}
#' \item{\code{statenme}}{a character vector for the state}
#' \item{\code{capital}}{a character vector for the name of the capital}
#' \item{\code{styear}}{a character vector for the start year. See details section for more information.}
#' \item{\code{endyear}}{a character vector for the end year. See details section for more information.}
#' \item{\code{lat}}{a numeric vector of the latitude coordinates for the capital}
#' \item{\code{lng}}{a numeric vector of the longitude coordinates for the capital}
#' }
#'
#' @details For convenience, the start year for most states is 1816. Samoa, for example, was not a state
#' in 1816. However, the functions that use the \code{cow_capitals} data will not create observations for states
#' that did not exist at a given point in time.
#'
#' The data should be current as of the end of 2020.
#'
#' Cases where a start year is not 1816 indicate a capital transition. For example, Brazil's capital moved from
#' Rio de Janeiro to Brasilia (a planned capital) in 1960. Only 25 states in the data experienced a capital transition.
#' The most recent was Burundi in 2018. Indonesia, as of writing, is planning on a capital transition, but this has not
#' been completed yet.
#'
#' Kazakhstan renamed its capital for the state leader in 2019. These data retain the name of Astana. This will be changed
#' in the event the software I use records this change.
#'
#' The capitals data are not without some peculiarities. Prominently, Portugal transferred the Portuguese court from
#' Lisbon to Rio de Janeiro from 1808 to 1821. *This is recorded in the data.* A knowledge of the inter-state conflict data
#' will note there was no war or dispute between, say, Portugal and Spain (or Portugal and any other country) at any point
#' during this time, but it does create some weirdness that would suggest a massive distance between two countries, like
#' Portugal and Spain, that are otherwise land-contiguous.
#'
#' On Spain: the republican government moved the capital at the start of the civil war (in 1936) to Valencia. However, it
#' abandoned this capital by 1937. I elect to not record this capital transition.
#'
#' The data also do some (I think) reasonable back-dating of capitals to coincide with states in transition without
#' necessarily formal capitals by the first appearance in the state system membership data. These concern Lithuania,
#' Kazakhstan, and the Philippines. Kaunas is the initial post-independence capital of Lithuania. Almaty is the initial
#' post-independence capital of Kazakhstan. Quezon City is the initial post-independence capital of the Philippines.
#' This concerns, at the most, one or two years for each of these three countries.
#'
#'
"cow_capitals"

#' A complete list of capitals and capital transitions for Gleditsch-Ward state system members
#'
#' This is a complete list of capitals and capital transitions for Gleditsch-Ward state system members. I
#' use it internally for calculating capital-to-capital distances in the \code{add_capital_distances()} function.
#'
#' @format A data frame with 248 observations on the following 7 variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
#' \item{\code{statenme}}{a character vector for the state}
#' \item{\code{capital}}{a character vector for the name of the capital}
#' \item{\code{styear}}{a character vector for the start year. See details section for more information.}
#' \item{\code{endyear}}{a character vector for the end year. See details section for more information.}
#' \item{\code{lat}}{a numeric vector of the latitude coordinates for the capital}
#' \item{\code{lng}}{a numeric vector of the longitude coordinates for the capital}
#' }
#'
#' @details For convenience, the start year for most states is 1816. Samoa, for example, was not a state
#' in 1816. However, the functions that use the \code{gw_capitals} data will not create observations for states
#' that did not exist at a given point in time.
#'
#' The data should be current as of the end of 2020.
#'
#' Cases where a start year is not 1816 indicate a capital transition. For example, Brazil's capital moved from
#' Rio de Janeiro to Brasilia (a planned capital) in 1960. Only 25 states in the data experienced a capital transition.
#' The most recent was Burundi in 2018. Indonesia, as of writing, is planning on a capital transition, but this has not
#' been completed yet.
#'
#' Kazakhstan renamed its capital for the state leader in 2019. These data retain the name of Astana. This will be changed
#' in the event the software I use records this change.
#'
#' The capitals data are not without some peculiarities. Prominently, Portugal transferred the Portuguese court from
#' Lisbon to Rio de Janeiro from 1808 to 1821. *This is recorded in the data.* A knowledge of the inter-state conflict data
#' will note there was no war or dispute between, say, Portugal and Spain (or Portugal and any other country) at any point
#' during this time, but it does create some weirdness that would suggest a massive distance between two countries, like
#' Portugal and Spain, that are otherwise land-contiguous.
#'
#' On Spain: the republican government moved the capital at the start of the civil war (in 1936) to Valencia. However, it
#' abandoned this capital by 1937. I elect to not record this capital transition.
#'
#' On Myanmar: the Gleditsch-Ward system stands out as having Myanmar entered for the bulk of the 19th century. The capitals
#' recorded for Myanmar (Burma) coincide with capitals of the Konbaung dynasty.
#'
#' The data also do some (I think) reasonable back-dating of capitals to coincide with states in transition without
#' necessarily formal capitals by the first appearance in the state system membership data. These concern Lithuania,
#' Kazakhstan, and the Philippines. Kaunas is the initial post-independence capital of Lithuania. Almaty is the initial
#' post-independence capital of Kazakhstan. Quezon City is the initial post-independence capital of the Philippines.
#' This concerns, at the most, one or two years for each of these three countries.
#'
#'
"gw_capitals"

#' Democracy data for all Correlates of War states
#'
#' These are democracy data for all Correlates of War state system members.
#'
#' @format A data frame with 16536 observations on the following 5 variables.
#' \describe{
#' \item{\code{ccode}}{the Correlates of War system code}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{v2x_polyarchy}}{the Varieties of Democracy "polyarchy" estimate}
#' \item{\code{polity2}}{the the \code{polity2} score from the Polity project}
#' \item{\code{xm_qudsest}}{an extension of the Unified Democracy Scores (UDS) estimates, made possibly by the \code{QuickUDS} package from Xavier Marquez.}
#' }
#'
#' @details Missing data connote data that are unavailable for various reasons. Either there is no democracy data to code or, in the case of the Polity project, the state
#' system member is outright not evaluated for the variable.
#'
#' The Polity data are from 2017. The Varieties of Democracy data are version 10. Xavier Marquez' \code{QuickUDS} estimates (i.e. extensions of Pemstein et al. (2010)) come from a package Marquez makes available on his Github (\url{https://github.com/xmarquez/QuickUDS}).
#'
#' @references
#'
#' Coppedge, Michael, John Gerring, Carl Henrik Knutsen, Staffan I. Lindberg,
#' Jan Teorell, David Altman, Michael Bernhard, M. Steven Fish, Adam Glynn,
#' Allen Hicken, Anna Luhrmann, Kyle L. Marquardt, Kelly McMann, Pamela
#' Paxton, Daniel Pemstein, Brigitte Seim, Rachel Sigman, Svend-Erik
#' Skaaning, Jeffrey Staton, Agnes Cornell, Lisa Gastaldi, Haakon Gjerlow,
#' Valeriya Mechkova, Johannes von Romer, Aksel Sundtrom, Eitan Tzelgov,
#' Luca Uberti, Yi-ting Wang, Tore Wig, and Daniel Ziblatt. 2020.
#' "V-Dem Codebook v10" Varieties of Democracy (V-Dem) Project.
#'
#' Marshall, Monty G., Ted Robert Gurr, and Keith Jaggers. 2017.
#' "Polity IV Project: Political Regime Characteristics and Transitions,
#' 1800-2017." Center for Systemic Peace.
#'
#' Marquez, Xavier, "A Quick Method for Extending the Unified Democracy
#' Scores" (March 23, 2016).  \doi{10.2139/ssrn.2753830}
#'
#' Pemstein, Daniel, Stephen Meserve, and James Melton. 2010. "Democratic
#' Compromise: A Latent Variable Analysis of Ten Measures of Regime Type."
#' *Political Analysis* 18(4): 426-449.
#'
"ccode_democracy"



#' Correlates of War directed dyad-year alliance data
#'
#' These are version 4.1 of the Correlates of War directed dyad-year alliance data.
#'
#' @format A data frame with 120784 observations on the following 7 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{cow_defense}}{a numeric vector that equals 1 if the alliance included a defense pledge}
#' \item{\code{cow_neutral}}{a numeric vector that equals 1 if the alliance included a neutrality pledge}
#' \item{\code{cow_nonagg}}{a numeric vector that equals 1 if the alliance included a non-aggression pledge}
#' \item{\code{cow_entente}}{a numeric vector that equals 1 if the alliance included a pledge to consult if a crisis occurred}
#' }
#'
#' @details The directed dyad-year alliance data are for alliance initiations, not straight dyad-years, "per se." This suggests
#' the presence of duplicate directed dyad-years. For computing ease, given the intended use, I take care of these duplicate
#' dyad-years behind the scenes. Consider the case of the U.S. and Canada in 1958. Therein, there were apparently two separate
#' alliance initiations  that included defense pledges. My behind-the-scenes cleaning process groups by \code{ccode1},
#' \code{ccode2}, and \code{year} and summarizes those alliance pledge variables. I then replace any value greater than 1
#' with 1. This indicates the presence or absence of a defense pledge in a given directed dyad-year.
#'
#' @references
#'
#' Gibler, Douglas M. 2009. \emph{International Military Alliances, 1648-2008}. Congressional Quarterly Press.
#'
NULL


#' Correlates of War Direct Contiguity Data (v. 3.2)
#'
#' These contain an abbreviated version of the "master records" for the Correlates of War
#' direct contiguity data. Data contain a few cosmetic changes to assist with some functions
#' downstream from it.
#'
#' @format A data frame with 2025840 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{conttype}}{a numeric vector for the contiguity relationship}
#' \item{\code{begin}}{the year-month when this contiguity relationship begins (YYYYMM)}
#' \item{\code{end}}{the year-month when this contiguity relationship ends (YYYYMM)}
#' }
#'
#' @details The "master record" provided by the Correlates of War is "non-directed." I make
#' these data "directed" for convenience.
#'
#' For clarity, the contiguity codes range from 1 to 5. 1 = direct land contiguity. 2 =
#' separated by 12 miles of water or fewer (a la Stannis Baratheon). 3 = separated by
#' 24 miles of water or fewer (but more than 12 miles). 4 = separated by 150 miles
#' of water or fewer (but more than 24 miles). 5 = separated by 400 miles of water
#' or fewer (but more than 150 miles). Cases of separation by more than 400 miles
#' of water are not included in the master record (but are easily discerned based on
#' complete dyad-year data).
#'
#' @references Stinnett, Douglas M., Jaroslav Tir, Philip Schafer, Paul F. Diehl, and Charles Gochman
#' (2002). "The Correlates of War Project Direct Contiguity Data, Version 3." Conflict
#' Management and Peace Science 19 (2):58-66.
#'
"cow_contdir"


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


#' Correlates of War and Gleditsch-Ward states, by year
#'
#' This is a complete (I believe) data set on Correlates of War states and Gleditsch-Ward states, a byproduct
#' of a \code{full_join()} between \code{gw_states} and \code{cow_states} that leans largely on the
#' state abbreviation variable.
#'
#' @format A data frame with 16936 observations on the following 6 variables.
#' \describe{
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{stateabb}}{the state abbreviation, which was the greatest source of agreement between both data sets}
#' \item{\code{gw_statename}}{the state name as it appears in the Gleditsch-Ward data}
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{cow_statename}}{the state name as it appears in the Correlates of War data}
#' \item{\code{year}}{a numeric vector for the year}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created. I'm going to use it for internal stuff. The workflow is going to treat the Correlates of War state system
#' membership codes as more of the "master" codes, for which the user can add Gleditsch-Ward identifiers as they see
#' fit. Data are extended to 2020, assuming no changes to state system membership for either data set.
#'
"cow_gw_years"


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


#' Directed dispute-year data (Gibler, Miller, and Little, 2016)
#'
#' These are directed dispute-year data from the most recent version (2.2.1) of the
#' Gibler-Miller-Little (GML) militarized interstate dispute (MID) data. They are
#' used internally for merging into full dyad-year data frames.
#'
#' @format A data frame with 10330 observations on the following 39 variables.
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
#' @details Data are the directed dispute-year data made available in version 2.1.1 of the GML MID data.
#'
#' I would caution against using the \code{revtype} variables. They are not informative. They are however
#' included for legacy reasons.
#'
#' @references
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.
#'
NULL


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

#'  Correlates of War National Military Capabilities Data
#'
#' These are version 6.0 of the Correlates of War National Military Capabilities data. Data omit
#' the state abbreviation and version identifier for consideration.
#'
#' @format A data frame with 15171 observations on the following 9 variables.
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
#' @details The user will want to be a little careful with how some of these data are used, beyond the typical caveat
#' about how difficult it is to pin-point how many thousands of coal-tons a state like Baden was producing in the 19th century.
#'
#' First, military expenditures are denominated in British pounds sterling for observations between 1816 and 1913. The observations
#' from 1914 and beyond are denominated in current United States dollars. This is according to the manual.
#'
#' Second, urban population size is an estimate based on, well, an estimate of the size of the population living in an area with 100,000
#' or more people.
#'
#' Third, the Composite Index of National Capability score is calculated as each state's world share of each of the six composite indicators
#' also included in the data in a given year. It theoretically is bound between 0 and 1. A state with a 1 is 100% responsible for 1) all of the military expenditures
#' in the world, 2) is the only state with a military, 3) does all the iron and steel production, 4) all the world's primary energy consumption, and 5)
#' is the only state in the world with a population and an urban population. Incidentally, the maximum scores observed in the data belong to the United States in 1945.
#'
#'
#' @references
#'
#' Singer, J. David, Stuart Bremer, and John Stuckey. (1972). "Capability Distribution, Uncertainty, and Major Power War, 1820-1965." in Bruce Russett (ed) Peace, War, and Numbers, Beverly Hills: Sage, 19-48.
#'
#' Singer, J. David. 1987. "Reconstructing the Correlates of War Dataset on Material Capabilities of States, 1816-1985" International Interactions, 14: 115-32.
#'
"cow_nmc"


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

#' Correlates of War National Trade Data Set (v. 4.0)
#'
#' These are state-year-level data for national trade from the Correlates of War project.
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
#' @details The \code{data-raw} directory on the project's Github shows how the data were processed.
#'
#' @references
#'
#' Barbieri, Katherine and Omar M.G. Keshk. 2016. Correlates of War Project Trade Data Set Codebook, Version 4.0. Online: \url{https://correlatesofwar.org}
#'
#' Barbieri, Katherine, Omar M.G. Keshk, and Brian Pollins. 2009. "TRADING DATA: Evaluating Our Assumptions and Coding Rules." \emph{Conflict Management and Peace Science}, 26(5): 471-491.
#'
"cow_trade_sy"

#' Alliance Treaty Obligations and Provisions (ATOP) Project Data (v. 5.0)
#'
#' These are directed dyad-year-level data for alliance obligations and provisions from the ATOP project
#'
#'
#' @format A data frame with 272,046 observations on the following eight variables.
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
#' @details The \code{data-raw} directory on the project's Github shows how the data were processed.
#'
#' @references
#'
#' Leeds, Brett Ashley, Jeffrey M. Ritter, Sara McLaughlin Mitchell, and Andrew G. Long. 2002.
#' Alliance Treaty Obligations and Provisions, 1815-1944. \emph{International Interactions} 28: 237-60.

"atop_alliance"





#' (Surplus and Gross) Domestic Product for Correlates of War States
#'
#' These are state-year level data for surplus and gross domestic product for Correlates of War state system members. Data also
#' include population estimates for per capita standardization.
#'
#'
#' @format A data frame with 27753 observations on the following five variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War state code}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{wbgdp2011est}}{a numeric vector for the estimated natural log of GDP in 2011 USD (log-transformed)}
#' \item{\code{wbpopest}}{a numeric vector for the estimated population size (log-transformed)}
#' \item{\code{sdpest}}{a numeric vector for the estimated surplus domestic product (log-transformed)}
#'  \item{\code{wbgdppc2011est}}{a numeric vector for the estimated GDP per capita (log-transformed)}
#' }
#' @details These were extracted from the actual replication files from \emph{International Studies Quarterly}. Because these
#' data are ultimately being simulated, a user can expect some slight differences between the Correlates of War version of these data
#' (which Anders et al. published) and the Gleditsch-Ward version of these data (which appear to be the one the authors will more
#' vigorously support going forward).
#'
#' Space considerations compel me to round these data to three decimal points.  These "economic" data are routinely
#' the biggest in the package, and it's because of the decimal points. The justification for this is these data are estimated/simulated
#' anyways and the information loss is at the 1/1000th decimal point. This procedure basically cuts the size of the data to be less than
#' 25% of its original size. The original simulations are available for remote download if you'd like. Type \code{?download_extdata()} for
#' more information.
#'
#' @references
#'
#' Anders, Therese, Christopher J. Fariss, and Jonathan N. Markowitz. 2020. "Bread Before Guns or Butter: Introducing Surplus Domestic Product (SDP)"
#' \emph{International Studies Quarterly} 64(2): 392--405.

"cow_sdp_gdp"


#' (Surplus and Gross) Domestic Product for Gleditsch-Ward States
#'
#' These are state-year level data for surplus and gross domestic product for Correlates of War state system members. Data also
#' include population estimates for per capita standardization.
#'
#'
#' @format A data frame with 27387 observations on the following five variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{wbgdp2011est}}{a numeric vector for the estimated natural log of GDP in 2011 USD (log-transformed)}
#' \item{\code{wbpopest}}{a numeric vector for the estimated population size (log-transformed)}
#' \item{\code{sdpest}}{a numeric vector for the estimated surplus domestic product (log-transformed)}
#' \item{\code{wbgdppc2011est}}{a numeric vector for the estimated GDP per capita (log-transformed)}
#' }
#' @details These were provided by Anders on a separate Github repository for this project. Because these
#' data are ultimately being simulated, a user can expect some slight differences between the Correlates of War version of these data
#' (which Anders et al. published) and the Gleditsch-Ward version of these data (which appear to be the one the authors will more
#' vigorously support going forward).
#'
#' Space considerations compel me to round these data to three decimal points.  These "economic" data are routinely
#' the biggest in the package, and it's because of the decimal points. The justification for this is these data are estimated/simulated
#' anyways and the information loss is at the 1/1000th decimal point. This procedure basically cuts the size of the data to be less than
#' 25% of its original size. The original simulations are available for remote download if you'd like. Type \code{?download_extdata()} for
#' more information.
#'
#' @references
#'
#' Anders, Therese, Christopher J. Fariss, and Jonathan N. Markowitz. 2020. "Bread Before Guns or Butter: Introducing Surplus Domestic Product (SDP)"
#' \emph{International Studies Quarterly} 64(2): 392--405.

"gw_sdp_gdp"

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




#' Directed Dyadic Dispute-Year Data (CoW-MID, v. 5.0)
#'
#' These are directed dyadic dispute year data derived from the Correlates of War (CoW) Militarized Interstate
#'  Dispute (MID) project. Data are from version 5.0.
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
#' @details The process of creating these is described at one of the references below. Importantly, these data are somewhat
#' "naive." That is: they won't tell you, for example, that Brazil and Japan never directly fought each other during World War II.
#' Instead, it will tell you that there were two years of overlap for the two on different sides of the conflict and that the highest
#' action for both was a war. The data are thus similar to what the \code{EUGene} program would create for users back in the day. Use these
#' data with that limitation in mind.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{http://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Palmer, Glenn, and Roseanne W. McManus and Vito D'Orazio and Michael R. Kenwick and Mikaela Karstens
#' and Chase Bloch and Nick Dietrich and Kayla Kahn and Kellan Ritter and Michael J. Soules. 2021.
#' "The MID5 Dataset, 2011–2014: Procedures, coding rules, and description" \emph{Conflict Management and Peace Science}.
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
#' @details These data are purposely light on information; they're not intended to be used for dispute-level analyses, per se.
#' They're intended to augment the directed dyadic dispute-year data by adding in variables that serve as exclusion rules to whittle
#' the data from dyadic dispute-year to just dyad-year data.
#'
#' @references
#'
#' Palmer, Glenn, and Roseanne W. McManus and Vito D'Orazio and Michael R. Kenwick and Mikaela Karstens
#' and Chase Bloch and Nick Dietrich and Kayla Kahn and Kellan Ritter and Michael J. Soules. 2021.
#' "The MID5 Dataset, 2011–2014: Procedures, coding rules, and description" \emph{Conflict Management and Peace Science}.
#'

"cow_mid_disps"



#' Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (CoW-MID, v. 5.0)
#'
#' These are directed dyadic dispute year data derived from the Correlates of War (CoW) Militarized Interstate
#'  Dispute (MID) project. Data are from version 5.0. These were whittled to where there is no duplicate dyad-years.
#'  Its primary aim here is merging into a dyad-year data frame.
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
#' @details The process of creating these is described at one of the references below. Importantly, these data are somewhat
#' "naive." That is: they won't tell you, for example, that Brazil and Japan never directly fought each other during World War II.
#' Instead, it will tell you that there were two years of overlap for the two on different sides of the conflict and that the highest
#' action for both was a war. The data are thus similar to what the \code{EUGene} program would create for users back in the day. Use these
#' data with that limitation in mind.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{http://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Palmer, Glenn, and Roseanne W. McManus and Vito D'Orazio and Michael R. Kenwick and Mikaela Karstens
#' and Chase Bloch and Nick Dietrich and Kayla Kahn and Kellan Ritter and Michael J. Soules. 2021.
#' "The MID5 Dataset, 2011–2014: Procedures, coding rules, and description" \emph{Conflict Management and Peace Science}.
#'

"cow_mid_ddydisps"


#' Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (GML, v. 2.2.1)
#'
#' These are directed dyadic dispute year data derived from the Gibler-Miller-Little (GML) Militarized Interstate
#'  Dispute (MID) project. Data are from version 2.2.1. These were whittled to where there is no duplicate dyad-years.
#'  Its primary aim here is merging into a dyad-year data frame.
#'
#'
#' @format A data frame with 9262 observations on the following 25 variables.
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
#' @details The process of creating these is described at one of the references below. Importantly, these data are somewhat
#' "naive." That is: they won't tell you, for example, that Brazil and Japan never directly fought each other during World War II.
#' Instead, it will tell you that there were two years of overlap for the two on different sides of the conflict and that the highest
#' action for both was a war. The data are thus similar to what the \code{EUGene} program would create for users back in the day. Use these
#' data with that limitation in mind.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{http://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.

NULL





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
#' \url{http://svmiller.com}) that is available to see on the project's Github repository. The data object is also renamed to avoid a conflict.
#'
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
#' URL: \url{http://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R. and David Dreyer. 2012. \emph{Handbook of International Rivalries}. CQ Press.
#'
"td_rivalries"




#' Gleditsch-Ward states and Correlates of War, by year
#'
#' This is a complete (I believe) data set on Gleditsch-Ward states and Correlates of War states, a byproduct
#' of a \code{full_join()} between \code{gw_states} and \code{cow_states} that leans largely on the
#' state abbreviation variable.
#'
#' @format A data frame with 18425 observations on the following 6 variables.
#' \describe{
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{stateabb}}{the state abbreviation, which was the greatest source of agreement between both data sets}
#' \item{\code{gw_statename}}{the state name as it appears in the Gleditsch-Ward data}
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{cow_statename}}{the state name as it appears in the Correlates of War data}
#' \item{\code{year}}{a numeric vector for the year}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created. I'm going to use it for internal stuff. The workflow is going to treat the Gleditsch-Ward state system
#' membership codes as more of the "master" codes, for which the user can add Correlates of War identifiers as they see
#' fit. Data are extended to 2020, assuming no changes to state system membership for either data set.
#'
"gw_cow_years"


#' Rugged/Mountainous Terrain Data
#'
#' This is a data set on state-level estimates for the "ruggedness" of a state's terrain.
#'
#' @format A data frame with 192 observations on the following 6 variables.
#' \describe{
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{rugged}}{the terrain ruggedness index}
#' \item{\code{newlmtnest}}{the (natural log) percentage estimate of the state's terrain that is mountainous}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created. It goes without saying that these data move *slowly* so the data are really only applicable for making state-to-state
#' comparisons and not states-in-time comparisons. The terrain ruggedness index is originally introduced by Riley et al. (1999) but
#' is amended by Nunn and Puga (2012). The mountain terrain data was originally created by Fearon and Laitin (2003) but extended and
#' amended by Gibler and Miller (2014). The data are functionally time-agnostic---use with caution in your state-year analyses---but all
#' data sets seem to benchmark around 1999-2000. I'm not sure it matters  *that* much, but it matters a little at the margins, I suppose,
#' if you suspect there are major differences in interpretation of how much more "rugged" the Soviet Union was than Russia, or Yugoslavia
#' than Serbia.
#'
#' @references
#'
#' Fearon, James D., and David Laitin, "Ethnicity, Insurgency, and Civil War"
#' \emph{American Political Science Review} 97: 75–90.
#'
#' Gibler, Douglas M. and Steven V. Miller. 2014. "External Territorial Threat, State Capacity, and Civil War."
#' \emph{Journal of Peace Research} 51(5): 634-646.
#'
#' Nunn, Nathan and Diego Puga. 2012. "Ruggedness: The Blessing of Bad Geography in Africa."
#' \emph{Review of Economics and Statistics}. 94(1): 20-36.
#'
#' Riley, Shawn J., Stephen D. DeGloria, and Robert Elliot. 1999. "A Terrain Ruggedness
#' Index That Quantifies Topographic Heterogeneity,” \emph{Intermountain Journal of Sciences} 5: 23–27.
#'
"rugged"


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
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created.
#'
#' @references
#'
#' Drazanova, Lenka. 2020. "Introducing the Historical Index of Ethnic Fractionalization (HIEF) Dataset: Accounting
#' for Longitudinal Changes in Ethnic Diversity." \emph{Journal of Open Humanities Data} 6:6
#' \doi{10.5334/johd.16}
#'
"hief"


#' Composition of Religious and Ethnic Groups (CREG) Fractionalization/Polarization Estimates
#'
#' This is a data set with state-year estimates for ethnic and religious fractionalization/polarization,
#' by way of the Composition of Religious and Ethnic Groups (CREG) project at the
#' University of Illinois. I-L-L.
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
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created. Pay careful attention to how I assigned CoW/G-W codes. The underlying data are version 1.02.
#'
#' The state codes provided by the CREG project are mostly Correlates of War codes, but with some differences.
#' Summarizing these differences: the state code for Serbia from 1992 to 2013 is actually the Gleditsch-Ward code (340).
#' Russia after the dissolution of the Soviet Union (1991-onward) is 393 and not 365. The Soviet Union has the 365 code.
#' Yugoslavia has the 345 code. The code for Yemen (678) is effectively the Gleditsch-Ward code because it spans the entire
#' post-World War II temporal domain. Likewise, the code for post-unification Germany is the Gleditsch-Ward code (260) as well.
#' The codebook actually says it's 265 (which would be East Germany's code), but this is assuredly a typo based on the data.
#'
#' The codebook cautions there are insufficient data for ethnic group estimates for Cameroon, France, India,
#' Kosovo, Montenegro, Mozambique, and Papua New Guinea. The French case is particularly disappointing but the
#' missing data there are a function of both France's constitution and modelling issues for CREG (per the
#' codebook). There are insufficient data to make religious group estimates for China, North Korea, and the
#' short-lived Republic of Vietnam.
#'
#' The fractionalization estimates are the familiar Herfindahl-Hirschman concentration index. The polarization
#' formula comes by way of Montalvo and Reynal-Querol (2000), though this book does not appear to be published
#' beyond its placement online. I recommend Montalvo and Reynal-Querol (2005) instead.
#' You can cite Alesina (2003) for the fractionalization measure if you'd like.
#'
#' In the most literal sense of "1", the group proportions may not sum to exactly 1 because of rounding in the
#' data. There were only two problem cases in these data worth mentioning. First, in both data sets, there would
#' be the occasional duplicates of group names by state-year (for example: Afghanistan in 1951 in the ethnic group
#' data and the United States in 1948 in the religious group data). In those cases, the script I make available
#' in the \code{data-raw} directory just select distinct values and that effectively fixes the problem of duplicates,
#' where they do appear. Finally, Costa Rica had a curious problem for most years in the religious group data. All
#' Costa Rica years have group data for Protestants, Roman Catholics, and "others." Up until 1964 or so, the "others"
#' are zero. Afterward, there is some small proportion of "others". However, the sum of Protestants, Roman Catholics, and
#' "others" exceeds 1 (pretty clearly) and the difference between the sum and 1 is entirely the "others." So, I drop
#' the "others" for all years. I don't think that's terribly problematic, but it's worth saying that's what I did.
#'
#' @references
#'
#' Alesina, Alberto, Arnaud Devleeschauwer, William Easterly, Sergio Kurlat and Romain Wacziarg. 2003.
#' "Fractionalization". \emph{Journal of Economic Growth} 8: 155-194.
#'
#' Montalvo, Jose G. and Marta Reynal-Querol. 2005. "Ethnic Polarization, Potential Conflict, and Civil Wars"
#' \emph{American Economic Review} 95(3): 796--816.
#'
#' Nardulli, Peter F., Cara J. Wong, Ajay Singh, Buddy Petyon, and Joseph Bajjalieh. 2012.
#' \emph{The Composition of Religious and Ethnic Groups (CREG) Project}. Cline Center for Democracy.
#'
"creg"



#' Democracy data for all Gleditsch-Ward states
#'
#' These are democracy data for all Correlates of War state system members.
#'
#' @format A data frame with 18289 observations on the following 5 variables.
#' \describe{
#' \item{\code{gwcode}}{the Gleditsch-Ward system code}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{v2x_polyarchy}}{the Varieties of Democracy "polyarchy" estimate}
#' \item{\code{polity2}}{the the \code{polity2} score from the Polity project}
#' \item{\code{xm_qudsest}}{an extension of the Unified Democracy Scores (UDS) estimates, made possibly by the \code{QuickUDS} package from Xavier Marquez.}
#' }
#'
#' @details Missing data connote data that are unavailable for various reasons. Either there is no democracy data to code or, in the case of the Polity project, the state
#' system member is outright not evaluated for the variable.
#'
#' The Polity data are from 2017. The Varieties of Democracy data are version 10. Xavier Marquez' \code{QuickUDS} estimates (i.e. extensions of Pemstein et al. (2010)) come from a package Marquez makes available on his Github (\url{https://github.com/xmarquez/QuickUDS}).
#'
#' @references
#'
#' Coppedge, Michael, John Gerring, Carl Henrik Knutsen, Staffan I. Lindberg,
#' Jan Teorell, David Altman, Michael Bernhard, M. Steven Fish, Adam Glynn,
#' Allen Hicken, Anna Luhrmann, Kyle L. Marquardt, Kelly McMann, Pamela
#' Paxton, Daniel Pemstein, Brigitte Seim, Rachel Sigman, Svend-Erik
#' Skaaning, Jeffrey Staton, Agnes Cornell, Lisa Gastaldi, Haakon Gjerlow,
#' Valeriya Mechkova, Johannes von Romer, Aksel Sundtrom, Eitan Tzelgov,
#' Luca Uberti, Yi-ting Wang, Tore Wig, and Daniel Ziblatt. 2020.
#' "V-Dem Codebook v10" Varieties of Democracy (V-Dem) Project.
#'
#' Marshall, Monty G., Ted Robert Gurr, and Keith Jaggers. 2017.
#' "Polity IV Project: Political Regime Characteristics and Transitions,
#' 1800-2017." Center for Systemic Peace.
#'
#' Marquez, Xavier, "A Quick Method for Extending the Unified Democracy
#' Scores" (March 23, 2016).  \doi{10.2139/ssrn.2753830}
#'
#' Pemstein, Daniel, Stephen Meserve, and James Melton. 2010. "Democratic
#' Compromise: A Latent Variable Analysis of Ten Measures of Regime Type."
#' *Political Analysis* 18(4): 426-449.
#'
"gwcode_democracy"


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


#' Abbreviated GML MID Dispute-level Data (v. 2.2.1)
#'
#' This is an abbreviated version of the dispute-level Gibler-Miller-Little (GML) MID data.
#'
#'
#' @format A data frame with 2436 observations on the following 7 variables.
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
#' @details These data are purposely light on information; they're not intended to be used for dispute-level analyses, per se.
#' They're intended to augment the directed dyadic dispute-year data by adding in variables that serve as exclusion rules to whittle
#' the data from dyadic dispute-year to just dyad-year data.
#'
#' @references
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.
#'

NULL



#' Participant Summaries of the GML-MID Data
#'
#' These are the participant summaries of the most recent GML-MID data. The data also include leaders at the onset
#' and conclusion of a participant episode in the GML MID data.
#'
#'
#' @format A data frame with 5217 observations on the following 21 variables.
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
#' @details Information about leaders come from Archigos (v. 4.1). GML MID Data are version 2.2.1. The \code{data-raw} directory
#' contains information about how these data were generated. There is invariably going to be some guesswork here because
#' dates are sometimes not known with precision. Sometimes, a dispute coincides even with a leadership change when dates are
#' known with precision. The source script includes a discussion of these cases and shows how the data were generated with all
#' these caveats in mind.
#'
#' Do note that participants can have several episodes within a dispute. Sometimes participants switch sides (e.g. Romania in World War 2).
#' Sometime participants drop in and out of a long-running dispute (e.g. Syria, prominently, in MID#4182).
#'
#' "Dummy" start days and end days are there to serve as a parlor trick in assigning disputes to leaders in leader-level analyses. Where days
#' are known with precision, the dummy day is that number. In most cases, where the day is not known with precision coincides with a month
#' that has no leader transition. Thus, the start day that gets imputed is going to be the first of the month (for the dummy start day)
#' or the last of the month (for the dummy end day). Cases where there was a leader transition (or two) that month may require some more
#' sensitive imputing. For example, our best guess is Antonio Guzmán Blanco of Venezuela is president for the end of MID#1639, given his
#' role in trying to negotiate a conclusion to the dispute. Archigos has him leaving office on the 7th, so that's the end day that gets imputed
#' for him. Again, these are here to serve as a parlor trick in assigning disputes to leaders for leader-level analyses. Be careful about using
#' these data for calculating dispute-participant duration. In fact: don't do that.
#'
#' @references
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.

NULL

#' (An Abbreviation of) The LEAD Data Set
#'
#' These are an abbreviated version of the LEAD Data Set, incorporating variables that I think are most interesting
#' or potentially useful from these data.
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
#' @details Data are ported from Ellis et al. (2015). Users who want more of these variables included in \pkg{peacesciencer} should
#' raise an issue on Github.
#'
#' @references
#'
#' Ellis, Carli Mortenson, Michael C. Horowitz, and Allan C. Stam. 2015. "Introducing the
#' LEAD Data Set." \emph{International Interactions} 41(4): 718--741.

"LEAD"




#' Directed Leader-Dyadic Dispute-Year Data with No Duplicate Leader-Dyad-Years (GML, v. 2.2.1, Archigos v. 4.1)
#'
#' These are directed leader-dyadic dispute year data derived from the Gibler-Miller-Little (GML) Militarized Interstate
#'  Dispute (MID) project. Data are from version 2.2.1 (GML-MID) and version 4.1 (Archigos).
#'  These were whittled to where there is no duplicate dyad-years.
#'  Its primary aim here is merging into a dyad-year data frame.
#'
#'
#' @format A data frame with 10708 observations on the following 12 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{obsid1}}{a character vector for the leader of the focal state in the dyad, if avialable}
#' \item{\code{obsid2}}{a character vector for the leader of the target state in the dyad, if avialable}
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
#' @details The process of creating these is described at one of the references below. Importantly, these data are somewhat
#' "naive." That is: they won't tell you, for example, that Brazil and Japan never directly fought each other during World War II.
#' Instead, it will tell you that there were two years of overlap for the two on different sides of the conflict and that the highest
#' action for both was a war. The data are thus similar to what the \code{EUGene} program would create for users back in the day. Use these
#' data with that limitation in mind.
#'
#' Data were created by first selecting on unique onsets. Then, where duplicates remained: retaining highest fatality, highest hostility level,
#'  highest estimated minimum duration, reciprocated observations over unreciprocated observations, and, finally, the lowest start month.
#'
#'  Be mindful that Archigos' leader data are nominally denominated in Gleditsch-Ward states, which are standardized to Correlates of War
#'  state system membership as well as the data can allow. There will be some missing leaders after 1870 because Archigos is ultimately its
#'  own system.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{http://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.

NULL



#' Directed Leader-Dyadic Dispute-Year Data (GML, v. 2.2.1, Archigos v. 4.1)
#'
#' These are directed leader-dyadic dispute year data derived from the Gibler-Miller-Little (GML) Militarized Interstate
#'  Dispute (MID) project. Data are from version 2.2.1 (GML-MID) and version 4.1 (Archigos). The data are all relevant
#'  dyadic leader pairings in conflict, allowing users to employ their own case exclusion rules to the data as they see fit.
#'
#'
#' @format A data frame with 11686 observations on the following 16 variables.
#' \describe{
#' \item{\code{dispnum}}{a numeric vector for the dispute number}
#' \item{\code{ccode1}}{a numeric vector for the focal state in the dyad}
#' \item{\code{ccode2}}{a numeric vector for the target state in the dyad}
#' \item{\code{obsid1}}{a character vector for the leader of the focal state in the dyad, if avialable}
#' \item{\code{obsid2}}{a character vector for the leader of the target state in the dyad, if avialable}
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
#' @details The process of creating these is described at one of the references below. Importantly, these data are somewhat
#' "naive." That is: they won't tell you, for example, that Brazil and Japan never directly fought each other during World War II.
#' Instead, it will tell you that there were two years of overlap for the two on different sides of the conflict and that the highest
#' action for both was a war. The data are thus similar to what the \code{EUGene} program would create for users back in the day. Use these
#' data with that limitation in mind.
#'
#'
#'  Be mindful that Archigos' leader data are nominally denominated in Gleditsch-Ward states, which are standardized to Correlates of War
#'  state system membership as well as the data can allow. There will be some missing leaders after 1870 because Archigos is ultimately its
#'  own system.
#'
#' @references
#'
#' Miller, Steven V. 2021. "How to (Meticulously) Convert Participant-Level Dispute Data to Dyadic Dispute-Year Data in R."
#' URL: \url{http://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/}
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.

NULL



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



#' A Data Set of Leader Codes Across Archigos 4.1, Archigos 2.9, and the LEAD Data
#'
#' This is a simple data set that matches, as well as one can, leader codes across Archigos 4.1, Archigos 2.9, and the LEAD data set.
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
#' These data treat version 4.1 of the Archigos data as the gospel leader data (if you will) for which  the observation ID (`obsid`)
#' is the master code indicating a leader tenure period. It also builds in an assumption that various observations that duplicate in the
#' LEAD data should not have duplicated. This concerns Francisco Aguilar Barquer (who appears twice), Emile Reuter (who appears twice),
#' and Gunnar Thoroddsen (who appears three times) in the LEAD data despite having uninterrupted tenures in office. None of the covariates
#' associated with these leaders change in the LEAD data, which is why I assume they were duplicates.

"leader_codes"


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
#' This file adjusts for what is assuredly two print errors in Thompson et al.
#' (2021). In print, Thompson et al. (2021) say the Italy-Turkey rivalry
#' extends from 1884-1843 and say the Mauritania-Morocco rivalry extends
#' from 1060-1969. They had meant an end year of 1943 in the first case and
#' a start year of 1960 in the second case. This is fixed in this version.
#'
#' Venice never appears in any data set in the Correlates of War ecosystem
#' of data, but I gave it a country code of 324 for the sake of these data
#' (and the previous Thompson and Dreyer (2012) version of it). You'll never
#' use this, but it's worth saying out loud that's what I did.
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
#' illustrative. Tge rivalry with the Soviet Union (`tssr_id = 100`) was
#' the primary rivalry for the U.S. (and the Soviet Union). However, the U.S.
#' presently sees China as its main rival (`tssr_id = 211`). The ongoing
#' rivalry with Russia (`tssr_id = 246`) is one where Russia sees the U.S.
#' as its primary rival but the U.S. does not see Russia the same way.
#'
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
#' URL: \url{http://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R., Kentaro Sakuwa, and Prashant Hosur Suhas. 2021.
#' *Analyzing Strategic Rivalries in World Politics: Types of Rivalry,
#' Regional Variation, and Escalation/De-escalation*. Springer.
#'
"tss_rivalries"
