#' @importFrom tibble tibble
NULL

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



#' Estimates from a Random Item Response Model of External Territorial Threat, 1816-2010
#'
#' This is a state-year data set on (latent) estimates of external territorial
#' threat. Data correspond with a publication in *Journal of Global Security Studies*.
#'
#' @format A data frame with 14781 observations on the following 10 variables.
#' \describe{
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{year}}{a year}
#' \item{\code{lterrthreat}}{an estimate of latent external territorial threat for the state in a given year}
#' \item{\code{sd}}{the standard deviation of simulated, latent external territorial threat}
#' \item{\code{lwr}}{a lower bound estimate of simulated, latent external territorial threat}
#' \item{\code{upr}}{an upper bound estimate of simulated, latent external territorial threat}
#' \item{\code{m_lterrthreat}}{another estimate of latent external territorial threat for the state in a given year}
#' \item{\code{m_sd}}{another standard deviation of simulated, latent external territorial threat}
#' \item{\code{m_lwr}}{another lower bound estimate of simulated, latent external territorial threat}
#' \item{\code{m_upr}}{another upper bound estimate of simulated, latent external territorial threat}
#' }
#'
#' @details
#'
#' The variables with the prefix of `m_` communicate alternate estimates in
#' which the state-year-level estimate of territorial threat derived from dyadic
#' data is weighted by the minimum distance between pairs of states. The
#' pertinent variables without this prefix communicate what I (the author!)
#' treat as the standard measure of latent, external territorial threat in which
#' the estimates derived from the dyadic data are weighted by capital distance.
#' You can see the clear corollaries to other functions and data in this package,
#' like the kind used in [add_minimum_distance()] and [add_capital_distance()].
#'
#' The lower and upper bounds communicate 90% intervals.
#'
#' @references
#'
#' Miller, Steven V. 2022. "A Random Item Response Model of External Territorial
#' Threat, 1816-2010" *Journal of Global Security Studies* 7(4): ogac012.
#'
"terrthreat"

#' Zeev Maoz' Regional/Global Power Data
#'
#' These are Zeev Maoz' data for what states are regional or global powers at a
#' given point time. They are extensions of the Correlates of War major power
#' data, which only codes "major" power without consideration of regional or
#' global distinctions. Think of Austria-Hungary as intuitive of the issue here.
#' Austria-Hungary is a major power in the Correlates of War data, but there is
#' good reason to treat Austria-Hungary as a major power only within Europe.
#' That is what Zeev Maoz tries to do here.
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
#' @references Maoz, Zeev. 2010. *Network of Nations: The Evolution, Structure,
#' and Impact of International Networks, 1816-2001*. Cambridge University Press.
#'
#'
"maoz_powers"


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
