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
#' in 1816. However, the functions that use the \code{capitals} data will not create observations for states
#' that did not exist at a given point in time.
#'
#' The data should be current as of the end of 2019.
#'
#' Cases where a start year is not 1816 indicate a capital transition. For example, Brazil's capital moved from
#' Rio de Janeiro to Brasilia (a planned capital) in 1960. Only 25 states in the data experienced a capital transition.
#' The most recent was Burundi in 2018. Indonesia, as of writing, is planning on a capital transition, but this has not
#' been completed yet.
#'
#' Kazakhstan renamed its capital for the state leader in 2019. These data retain the name of Astana.
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
"capitals"


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
#' Coppedge, Michael, John Gerring, Carl Henrik Knutsen, Staffan I. Lindberg, Jan Teorell, David Altman, Michael Bernhard, M. Steven Fish, Adam Glynn, Allen Hicken, Anna Luhrmann, Kyle L. Marquardt, Kelly McMann, Pamela Paxton, Daniel Pemstein, Brigitte Seim, Rachel Sigman, Svend-Erik Skaaning, Jeffrey Staton, Agnes Cornell, Lisa Gastaldi, Haakon Gjerløw, Valeriya Mechkova, Johannes von Römer, Aksel Sundtröm, Eitan Tzelgov, Luca Uberti, Yi-ting Wang, Tore Wig, and Daniel Ziblatt. 2020. ”V-Dem Codebook v10” Varieties of Democracy (V-Dem) Project.
#'
#' Marshall, Monty G., Ted Robert Gurr, and Keith Jaggers. 2017. "Polity IV Project: Political Regime CHaracteristics and Transitions, 1800-2017." Center for Systemic Peace.
#'
#' Marquez, Xavier, "A Quick Method for Extending the Unified Democracy Scores" (March 23, 2016). \doi{10.2139/ssrn.2753830}
#'
#' Pemstein, Daniel, Stephen Meserve, and James Melton. 2010. Democratic Compromise: A Latent Variable Analysis of Ten Measures of Regime Type. Political Analysis 18 (4): 426-449.
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
#' \item{\code{defense}}{a numeric vector that equals 1 if the alliance included a defense pledge}
#' \item{\code{neutrality}}{a numeric vector that equals 1 if the alliance included a neutrality pledge}
#' \item{\code{nonaggression}}{a numeric vector that equals 1 if the alliance included a non-aggression pledge}
#' \item{\code{entente}}{a numeric vector that equals 1 if the alliance included a pledge to consult if a crisis occurred}
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
"cow_alliance"


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
#' state system members. I offer it here as a shortcut for various other functions.
#'
#' @format A data frame with 2025840 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' }
#'
#' @details Data are a quick generation from the \code{create_dyadyears()} function in this package.
#'
"cow_ddy"


#' Correlates of War and Gleditsch-War states, by year
#'
#' This is a complete (I believe) data set on Correlates of War states and Gleditsch-Ward states, a byproduct
#' of a \code{full_join()} between \code{gw_states} and \code{cow_states} that leans largely on the
#' state abbreviation variable
#'
#' @format A data frame with 18656 observations on the following 8 variables.
#' \describe{
#' \item{\code{stateabb}}{the state abbreviation, which was the greatest source of agreement between both data sets}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{gw_statename}}{the state name as it appears in the Gleditsch-Ward data}
#' \item{\code{cow_statename}}{the state name as it appears in the Correlates of War data}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created. I'm going to use it for internal stuff. The workflow is going to treat the Correlates of War state system
#' membership codes as more of the "master" codes, for which the user can add Gleditsch-Ward identifiers as they see
#' fit.
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
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership}
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
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership}
#'
"cow_states"


#' Directed dispute-year data (Gibler, Miller, and Little, 2016)
#'
#' These are directed dispute-year data from the most recent version (2.1.1) of the
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
"gml_dirdisp"


#' A directed dyad-year data frame of Gleditsch-Ward state system members
#'
#' This is a complete directed dyad-year data frame of Gleditsch-Ward
#' state system members. I offer it here as a shortcut for various other functions.
#'
#' @format A data frame with 1999558 observations on the following 4 variables.
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
#' @details Data originally provided by Gleditsch with no column names. Column names were added before some light re-cleaning in order
#' to generate these data.
#'
#' @references Gleditsch, Kristian S. and Michael D. Ward. 1999. "A Revised List of Independent States since the Congress of Vienna" 25(4): 393--413.
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
#' These are version 5.0 of the Correlates of War National Military Capabilities data. Data omit
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


#' Citations for Data/Functions Used in \code{peacesciencer}
#'
#' This is a master list of references for data/functions used in this package. Do check it out to make sure you're faithfully citing what you're using.
#'
#' @format A data frame with two variables:
#' \describe{
#' \item{\code{data_function}}{the data or function used or referenced in the package}
#' \item{\code{citation}}{an appropriate (text) citation you should include in your manuscript}
#' }
#'
"citations"

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
#' Pevehouse, Jon C.W., Timothy Nordstron, Roseanne W McManus, Anne Spencer Jamison, “Tracking Organizations in the World: The Correlates of War IGO Version 3.0 datasets”, Journal of Peace Research 57(3): 492-503.
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
#' Pevehouse, Jon C.W., Timothy Nordstron, Roseanne W McManus, Anne Spencer Jamison, “Tracking Organizations in the World: The Correlates of War IGO Version 3.0 datasets”, Journal of Peace Research 57(3): 492-503.
#'
#' Wallace, Michael, and J. David Singer. 1970. "International Governmental Organization in the Global System, 1815-1964." International Organization 24: 239-87.
#'
"cow_igo_sy"

#' The Minimum Distance Between States in the Correlates of War System, 1946-2015
#'
#' These are non-directed dyad-year data for the minimum distance between states in the Correlates of War state system from
#' 1946 to 2015. The data are generated from the \code{cshapes} package.
#'
#' @format A data frame with 817053 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{the Correlates of War state system code for the first state}
#' \item{\code{ccode2}}{the Correlates of War state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{mindist}}{the minimum distance between states on Dec. 31 of the year, in kilometers}
#' }
#'
#' @details The data are generated from the \code{cshapes} package. The package authors purport that the data
#' are generated to be compatible with Correlates of War system codes, but a review I did several years ago for
#' an unrelated project (published in 2017 in \emph{Conflict Management & Peace Science}, which you should cite for
#' all your articles if you're reading this) suggested the output does not seem to perfectly meet that billing. These
#' included oddball cases like Zanzibar, United Arab Republic, Comoros, East Germany, and a few others. I pre-process
#' these as outlined in the associated file in the \code{data-raw} directory on the project's Github.
#'
#' Data are automatically generated (by default) as directed dyad-years. I elect to make them non-directed for space
#' considerations. Making non-directed dyad-year data into directed dyad-year data isn't too difficult in R. It just
#' looks weird to see the code that does it.
#'
#' Most of the data I prove elsewhere in this package are to be understood as the data as they were at the *start* of
#' the year. This is how I process, for example, the \code{capitals} data as they get merged in the \code{add_capital_distance()}
#' function. However, the script that generates these data are set at Dec. 31 of the year and not Jan. 1. I do this for concerns
#' of maximizing data coverage. If you wanted the same effect, just lag the data a year.
#'
#' @references
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring Country Shapes: The \code{cshapes} Package." \emph{The R Journal} 2(1): 18-24

"cow_mindist"

#' The Minimum Distance Between States in the Gleditsch-Ward System, 1946-2015
#'
#' These are non-directed dyad-year data for the minimum distance between states in the Gleditsch-Ward state system from
#' 1946 to 2015. The data are generated from the \code{cshapes} package.
#'
#' @format A data frame with 868813 observations on the following 4 variables.
#' \describe{
#' \item{\code{gwcode1}}{the Gleditsch-Ward state system code for the first state}
#' \item{\code{gwcode2}}{the Gleditsch-Ward state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{mindist}}{the minimum distance between states on Dec. 31 of the year, in kilometers}
#' }
#'
#' @details The data are generated from the \code{cshapes} package. The package authors purport that the data
#' are generated to be compatible with the Gleditsch-Ward system. I trust them on this; indeed, Gleditsch is one of the
#' authors of the \code{cshapes} package. However, I'm not sure how exhaustive the coverage is. For example,
#' Tibet is missing in these data and it should not be. I do not use Gleditsch-Ward codes for my own research, so my
#' quality control here for functions using these data will be minimal. I can only confirm there are no duplicates in the
#' data.
#'
#' Data are automatically generated (by default) as directed dyad-years. I elect to make them non-directed for space
#' considerations. Making non-directed dyad-year data into directed dyad-year data isn't too difficult in R. It just
#' looks weird to see the code that does it.
#'
#' Most of the data I prove elsewhere in this package are to be understood as the data as they were at the *start* of
#' the year. This is how I process, for example, the \code{capitals} data as they get merged in the \code{add_capital_distance()}
#' function. However, the script that generates these data are set at Dec. 31 of the year and not Jan. 1. I do this for concerns
#' of maximizing data coverage. If you wanted the same effect, just lag the data a year.
#'
#' @references
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring Country Shapes: The \code{cshapes} Package." \emph{The R Journal} 2(1): 18-24

"gw_mindist"

#' Correlates of War National Trade Data Set (v. 4.0)
#'
#' These are state-year-level data for national trade from the Correlates of War project.
#'
#'
#' @format A data frame with 14410 on the following four variables.
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
#' Barbieri, Katherine and Omar M.G. Keshk. 2016. Correlates of War Project Trade Data Set Cdebook, Version 4.0. Online: \url{https://correlatesofwar.org}
#'
#' Barbieri, Katherine, Omar M.G. Keshk, and Brian Pollins. 2009. "TRADING DATA: Evaluating Our Assumptions and Coding Rules." \emph{Conflict Management and Peace Science}, 26(5): 471-491.
#'
"cow_trade_sy"
