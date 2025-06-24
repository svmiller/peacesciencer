#' @importFrom tibble tibble
NULL

#' A complete list of capitals and capital transitions for Correlates of War state system members
#'
#' This is a complete list of capitals and capital transitions for Correlates of
#' War state system members. I use it internally for calculating
#' capital-to-capital distances in the \code{add_capital_distances()} function.
#'
#' @format A data frame with the following 7 variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War state code}
#' \item{\code{statenme}}{a character vector for the state}
#' \item{\code{capital}}{a character vector for the name of the capital}
#' \item{\code{stdate}}{a start date for the capital. See details section for more information.}
#' \item{\code{enddate}}{an end date for the capital. See details section for more information.}
#' \item{\code{lat}}{a numeric vector of the latitude coordinates for the capital}
#' \item{\code{lng}}{a numeric vector of the longitude coordinates for the capital}
#' }
#'
#' @details
#'
#' For convenience, the dates for most of these entries allows for some generous
#' coverage prior to its actual emergence in the state system or after its
#' actual exit from it. This is largely in consideration of the other state
#' system and its extension to potential daily format. However, the functions
#' that use the `cow_capitals` data will not create observations for states that
#' did not exist at a given point in time.
#'
#' Sometimes, a city is entered in these data to correspond with what makes it
#' easy for the geocoder, not necessarily what the name of the city was or what
#' it might be commonly called. I say this because I know it's heresy to call
#' Ho Chi Minh City the capital of the Republic of Vietnam. I'm aware.
#'
#' The data should be current as of the end of 2024. Indonesia is the most
#' likely candidate to require an update to these data and I am just having to
#' remind myself of this to make sure I don't forget.
#'
#' Cases where a start year is not 1816 indicate a capital transition. For
#' example, Brazil's capital moved from Rio de Janeiro to Brasilia (a planned
#' capital) in 1960. Only 25 states in the data experienced a capital transition.
#' The most recent was Burundi in 2018.
#'
#' Kazakhstan renamed its capital for the state leader in 2019. These data
#' retain the name of Astana and successfully outlived the short-lived name of
#' "Nur-Sultan". The city returned to its original name in 2022.
#'
#' The capitals data are not without some peculiarities. Prominently, Portugal
#' transferred the Portuguese court from Lisbon to Rio de Janeiro from 1808 to
#' 1821. *This is recorded in the data.* A knowledge of the inter-state conflict
#' data will note there was no war or dispute between, say, Portugal and Spain
#' (or Portugal and any other country) at any point during this time, but it
#' does create some weirdness that would suggest a massive distance between two
#' countries, like Portugal and Spain, that are otherwise land-contiguous.
#'
#' On Spain: the republican government moved the capital at the start of the
#' civil war (in 1936) to Valencia. However, it abandoned this capital by 1937.
#' I elect to not record this capital transition.
#'
#' The data also do some (I think) reasonable back-dating of capitals to
#' coincide with states in transition without necessarily formal capitals by the
#' first appearance in the state system membership data. These concern Lithuania,
#' Kazakhstan, and the Philippines. Kaunas is the initial post-independence
#' capital of Lithuania. Almaty is the initial post-independence capital of
#' Kazakhstan. Quezon City is the initial post-independence capital of the
#' Philippines. This concerns, at the most, one or two years for each of these
#' three countries.
#'
#' The `data-raw` directory have a raw spreadsheet with these data in their raw
#' form, along with comments I make about the transitions in question. Dates
#' where this is a transition are coded as the start and the end date for the
#' previous capital is the day before. I will confess that some decision rules
#' for what constitutes the transfer of the capital can be understood as ad hoc.
#' In modern instances, I generally privilege the legal documentation. For
#' example, Ivory Coast's transfer was declared in 1983 even if much of the
#' transfer wasn't completed until 2011. In this case, I prioritize 1983 as
#' the legal transfer of the capital. In the case of Australia, Canberra was
#' such a planned experiment that its announcement in 1908 coincided with no
#' name for the new location and the need for the government to buy up states
#' to build infrastructure. Even if it was announced with its name in 1913, I
#' don't record the transition until 1927 (when it opened the provisional
#' house for parliament). Much like the case above in Spain, I elect to ignore
#' cases where governments were declared in absentia or during an active conflict.
#' You can check the comments section of the raw spreadsheet for some of my
#' rationale.
#'
#'
"cow_capitals"

#' A complete list of capitals and capital transitions for Gleditsch-Ward state system members
#'
#' This is a complete list of capitals and capital transitions for
#' Gleditsch-Ward state system members. I use it internally for calculating
#' capital-to-capital distances in the \code{add_capital_distances()} function.
#'
#' @format A data frame with the following 7 variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
#' \item{\code{statenme}}{a character vector for the state}
#' \item{\code{capital}}{a character vector for the name of the capital}
#' \item{\code{stdate}}{a start date for the capital. See details section for more information.}
#' \item{\code{enddate}}{an end date for the capital. See details section for more information.}
#' \item{\code{lat}}{a numeric vector of the latitude coordinates for the capital}
#' \item{\code{lng}}{a numeric vector of the longitude coordinates for the capital}
#' }
#'
#' @details
#'
#' For convenience, the dates for most of these entries allows for some generous
#' coverage prior to its actual emergence in the state system or after its
#' actual exit from it. This is largely in consideration of the other state
#' system and its extension to potential daily format. However, the functions
#' that use the `gw_capitals` data will not create observations for states that
#' did not exist at a given point in time.
#'
#' Sometimes, a city is entered in these data to correspond with what makes it
#' easy for the geocoder, not necessarily what the name of the city was or what
#' it might be commonly called. I say this because I know it's heresy to call
#' Ho Chi Minh City the capital of the Republic of Vietnam. I'm aware.
#'
#' The data should be current as of the end of 2024. Indonesia is the most
#' likely candidate to require an update to these data and I am just having to
#' remind myself of this to make sure I don't forget.
#'
#' Cases where a start year is not 1816 indicate a capital transition. For
#' example, Brazil's capital moved from Rio de Janeiro to Brasilia (a planned
#' capital) in 1960. Only 25 states in the data experienced a capital transition.
#' The most recent was Burundi in 2018. Indonesia, as of writing, is planning on
#' a capital transition, but this has not been completed yet.
#'
#' Kazakhstan renamed its capital for the state leader in 2019. These data
#' retain the name of Astana and successfully outlived the short-lived name of
#' "Nur-Sultan". The city returned to its original name in 2022.
#'
#' The capitals data are not without some peculiarities. Prominently, Portugal
#' transferred the Portuguese court from Lisbon to Rio de Janeiro from 1808 to
#' 1821. *This is recorded in the data.* A knowledge of the inter-state conflict
#' data will note there was no war or dispute between, say, Portugal and Spain
#' (or Portugal and any other country) at any point during this time, but it
#' does create some weirdness that would suggest a massive distance between two
#' countries, like Portugal and Spain, that are otherwise land-contiguous.
#'
#' On Spain: the republican government moved the capital at the start of the
#' civil war (in 1936) to Valencia. However, it abandoned this capital by 1937.
#' I elect to not record this capital transition.
#'
#' On Myanmar: the Gleditsch-Ward system stands out as having Myanmar entered
#' for the bulk of the 19th century. The capitals recorded for Myanmar (Burma)
#' coincide with capitals of the Konbaung dynasty.
#'
#' The data also do some (I think) reasonable back-dating of capitals to
#' coincide with states in transition without necessarily formal capitals by the
#' first appearance in the state system membership data. These concern Lithuania,
#' Kazakhstan, and the Philippines. Kaunas is the initial post-independence
#' capital of Lithuania. Almaty is the initial post-independence capital of
#' Kazakhstan. Quezon City is the initial post-independence capital of the
#' Philippines. This concerns, at the most, one or two years for each of these
#' three countries.
#'
#' The `data-raw` directory have a raw spreadsheet with these data in their raw
#' form, along with comments I make about the transitions in question. Dates
#' where this is a transition are coded as the start and the end date for the
#' previous capital is the day before. I will confess that some decision rules
#' for what constitutes the transfer of the capital can be understood as ad hoc.
#' In modern instances, I generally privilege the legal documentation. For
#' example, Ivory Coast's transfer was declared in 1983 even if much of the
#' transfer wasn't completed until 2011. In this case, I prioritize 1983 as
#' the legal transfer of the capital. In the case of Australia, Canberra was
#' such a planned experiment that its announcement in 1908 coincided with no
#' name for the new location and the need for the government to buy up states
#' to build infrastructure. Even if it was announced with its name in 1913, I
#' don't record the transition until 1927 (when it opened the provisional
#' house for parliament). Much like the case above in Spain, I elect to ignore
#' cases where governments were declared in absentia or during an active conflict.
#' You can check the comments section of the raw spreadsheet for some of my
#' rationale.
#'
#'
#'
"gw_capitals"

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
#' @details
#'
#' The \code{data-raw} directory on the project's Github contains more
#' information about how these data were created. It goes without saying that
#' these data move *slowly* so the data are really only applicable for making
#' state-to-state comparisons and not states-in-time comparisons. The terrain
#' ruggedness index is originally introduced by Riley et al. (1999) but is
#' amended by Nunn and Puga (2012). The mountain terrain data was originally
#' created by Fearon and Laitin (2003) but extended and amended by Gibler and
#' Miller (2014). The data are functionally time-agnostic, but all data sets
#' seem to benchmark around 1999-2000. You should still use it with some care in
#' your state- or dyad-year panel analyses. I'm not sure it matters *that* much,
#' but it matters a little at the margins, I suppose, if you suspect there are
#' major differences in interpretation of how much more "rugged" the Soviet
#' Union was than Russia, or Yugoslavia than Serbia.
#'
#' @references
#'
#' Fearon, James D., and David Laitin, "Ethnicity, Insurgency, and Civil War"
#' *American Political Science Review* 97: 75–90.
#'
#' Gibler, Douglas M. and Steven V. Miller. 2014. "External Territorial Threat,
#' State Capacity, and Civil War." *Journal of Peace Research* 51(5): 634-646.
#'
#' Nunn, Nathan and Diego Puga. 2012. "Ruggedness: The Blessing of Bad Geography
#' in Africa." *Review of Economics and Statistics*. 94(1): 20-36.
#'
#' Riley, Shawn J., Stephen D. DeGloria, and Robert Elliot. 1999. "A Terrain
#' Ruggedness Index That Quantifies Topographic Heterogeneity,” *Intermountain
#' Journal of Sciences* 5: 23–27.
#'
"rugged"
