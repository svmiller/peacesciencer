#' @importFrom tibble tibble
NULL

#' A directed dyad-year data frame of Correlates of War state system members
#'
#' This is a complete directed dyad-year data frame of Correlates of War
#' state system members. I offer it here as a shortcut for various other functions when
#' I am working on new additions and don't want to invest time in waiting for
#' [create_dyadyears()] to run. As a general rule, this data frame is
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
#' @details Data are a quick generation from the [create_dyadyears()] function
#' in this package.
#'
"cow_ddy"

#' A directed dyad-year data frame of Gleditsch-Ward state system members
#'
#' This is a complete directed dyad-year data frame of Gleditsch-Ward
#' state system members. I offer it here as a shortcut for various other
#' functions. As a general rule, this data frame is updated after every
#' calendar year to include the most recently concluded calendar year.
#'
#' @format A data frame with the following 5 variables.
#' \describe{
#' \item{\code{gwcode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{gwcode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{microstate1}}{a numeric vector that equals 1 if the first state in the dyad is a micro-state. 0 if otherwise.}
#' \item{\code{microstate2}}{a numeric vector that equals 1 if the second state in the dyad is a micro-state. 0 if otherwise.}
#' }
#'
#' @details
#'
#' Data are a quick generation from the `create_dyadyears(system="gw")` function
#' in this package.
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
#' The functions that previously used these data no longer use these data. They
#' instead use a copy of the data in the \pkg{isard} package I also maintain.
#'
#' @references
#'
#' Gleditsch, Kristian S. and Michael D. Ward. 1999. "A Revised List of
#' Independent States since the Congress of Vienna."
#' *International Interactions* 25(4): 393--413.
#'
"gw_states"

#' The Minimum Distance Between States in the Correlates of War System, 1886-2019
#'
#' These are non-directed dyad-year data for the minimum distance between states
#' in the Correlates of War state system from 1886 to 2019. The data are
#' generated from the \pkg{cshapes} package.
#'
#' @format A data frame with 817053 observations on the following 4 variables.
#' \describe{
#' \item{\code{ccode1}}{the Correlates of War state system code for the first state}
#' \item{\code{ccode2}}{the Correlates of War state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{mindist}}{the minimum distance between states on Jan. 1 of the year, in kilometers}
#' }
#'
#' @details The data are generated from the \pkg{cshapes} package. Data are
#' automatically generated (by default) as directed dyad-years. I elect to make
#' them non-directed for space considerations. Making non-directed dyad-year
#' data into directed dyad-year data isn't too difficult in R. It just looks
#' weird to see the code that does it.
#'
#' Previous versions of these data were for the minimum distance as of Dec. 31
#' of the referent year. These are now Jan. 1. Most of the data I provide
#' elsewhere in this package are to be understood as the data as they were at
#' the *start* of the year. [add_minimum_distance()] permits greater flexibility
#' with this option, but only for the remote and augmented version of the data.
#' Check the documentation of that function for more.
#'
#' @references
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik
#' Cederman,and Kristian Skrede Gleditsch. 2022. "Mapping The International
#' System, 1886-2017: The \code{CShapes} 2.0 Dataset." *Journal of Conflict
#' Resolution*. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring
#' Country Shapes: The \code{cshapes} Package." *The R Journal* 2(1): 18-24

"cow_mindist"

#' The Minimum Distance Between States in the Gleditsch-Ward System, 1886-2019
#'
#' These are non-directed dyad-year data for the minimum distance between states
#' in the Gleditsch-Ward state system from 1886 to 2019. The data are generated
#' from the \pkg{cshapes} package.
#'
#' @format A data frame with 868813 observations on the following 4 variables.
#' \describe{
#' \item{\code{gwcode1}}{the Gleditsch-Ward state system code for the first state}
#' \item{\code{gwcode2}}{the Gleditsch-Ward state system code for the second state}
#' \item{\code{year}}{the year}
#' \item{\code{mindist}}{the minimum distance between states on Jan. 1 of the year, in kilometers}
#' }
#'
#' @details
#'
#' Data are automatically generated (by default) as directed dyad-years. I elect
#' to make them non-directed for space considerations. Making non-directed
#' dyad-year data into directed dyad-year data isn't too difficult in R. It just
#' looks weird to see the code that does it.
#'
#' Previous versions of these data were for the minimum distance as of Dec. 31
#' of the referent year. These are now Jan. 1. Most of the data I provide
#' elsewhere in this package are to be understood as the data as they were at
#' the *start* of the year. [add_minimum_distance()] permits greater flexibility
#' with this option, but only for the remote and augmented version of the data.
#' Check the documentation of that function for more.
#'
#' @references
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik
#' Cederman,and Kristian Skrede Gleditsch. 2022. "Mapping The International
#' System, 1886-2017: The \code{CShapes} 2.0 Dataset." *Journal of Conflict
#' Resolution*. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring
#' Country Shapes: The \code{cshapes} Package." *The R Journal* 2(1): 18-24

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
#' These are state-year level data for armed conflict onsets provided by the
#' Uppsala Conflict Data Program (UCDP).
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
#' @details
#'
#' The user will want to note that the data provided by UCDP are technically not
#' country-year observations. They instead duplicate observations for cases of
#' new conflicts or new conflict episodes. Further, the original data do not
#' provide any information about the conflict-dyad in question to which those
#' duplicates pertain. That means the most these data can do for the package's
#' mission is provide summary information. The user should probably recode these
#' variables into something else they may want for a particular application.
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

#' UCDP Armed Conflict Data (ACD) (v. 25.1)
#'
#' These are (kind of) dyadic, but mostly state-level data, used internally for
#' doing stuff with the UCDP armed conflict data
#'
#'
#' @format A data frame with 5652 observations on the following 15 variables.
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
#'
#' @details
#'
#' The \code{data-raw} directory on the project's Github will show how I processed
#' the multiple strings for when there are multiple states on a given side.
#'
#'
#' @references
#'
#' Gleditsch, Nils Petter; Peter Wallensteen, Mikael Eriksson, Margareta
#' Sollenberg, and Havard Strand. 2002. "Armed Conflict 1946–2001: A New
#' Dataset." *Journal of Peace Research* 39(5): 615–637.
#'
#' Davies, Shawn, Therése PEttersson, Margareta Sollenberg, and Magnus Öberg.
#' 2025. "Organized violence 1989–2024, and the challenges of identifying
#' civilian victims." *Journal of Peace Research* 62(4): 1223--1240.

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
#' This is a simple data set that communicates directed dyads in the
#' Gleditsch-Ward system that appear in the same year, but not in any particular
#' day in the year. They are used in an anti-join in the
#' [create_dyadyears()] function in this package.
#'
#'
#' @format A data frame with the following six variables.
#' \describe{
#' \item{\code{gwcode1}}{a numeric vector for the Gleditsch-Ward state code for the first state}
#' \item{\code{gwcode2}}{a numeric vector for the Gleditsch-Ward state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{microstate1}}{a numeric vector that equals 1 if the first state in the dyad is a micro-state. 0 if otherwise.}
#' \item{\code{microstate2}}{a numeric vector that equals 1 if the second state in the dyad is a micro-state. 0 if otherwise.}
#' \item{\code{in_ps}}{a constant that equals 1 if these data would appear in [create_dyadyears()] if you were not careful to remove them.}
#' }
#'
#' @details
#'
#' Think of the directed Serbia and Yugoslavia dyad from 2006 as illustrative
#' here. The Gleditsch-Ward system ends Yugoslavia June 4, 2006 and re-enters
#' Serbia (its rump state) on June 5, 2006. How to treat Serbia/Yugoslavia is
#' one of the clearest differences between the Correlates of War system and the
#' Gleditsch-Ward system, and understanding how the Gleditsch-Ward system treats
#' this case matters a great deal in creating dyad-year data. There should
#' obviously be no Serbia-Yugoslavia dyad when Serbia is the rump state of
#' Yugoslavia that Gleditsch-Ward re-enter into their system when Montenegro
#' split from it and enters the state system on June 3, 2006. Both Serbia and
#' Yugoslavia existed in 2006, but not on the same day in the same year.
#'

"false_gw_dyads"






#' Conventional Arms Races During Periods of Rivalry
#'
#' This is a simple data set of 71 arms races reported by Gibler et al. in their
#' 2005 article in *Journal of Peace Research*.
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
#' Data are taken from the appendix of Gibler, Rider, and Hutchison's (2005)
#' article in *Journal of Peace Research*. Read the article and appendix for
#' more information about coding procedures.
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
#' in this finished data product. It should not materially matter for any
#' applied use, given the overall ecosystem of data.
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
#' There is an apparent discrepancy in this understanding of "principal" and
#' "asymmetric principal" regarding the India-Pakistan rivalry (`tssr_id = 107`).
#' Per the authors (Table 2.1, p. 39), this is the only case in the data where
#' both indicators are 1. Per their conceptual definitions of "principal" and
#' "asymmetric" principal, this wouldn't make sense. However, I'm reluctant to
#' impute design decisions on behalf of the user and the authors without being
#' 100% sure about the correct course of action. For context: India has one
#' other rivalry (`tssr_id = 109`, with China) and Pakistan has one other
#' rivalry (`tssr_id = 106`, with Afghanistan). My hunch is this suggests that
#' the `aprin` column for the India-Pakistan rivalry should be blank and but
#' the `principal` column should still be 1. Whereas Afghanistan has no other
#' rivalry in the data during this time prior to the start of the second
#' iteration of its rivalry with Iran (`tssr_id = 210`), it may imply that
#' `aprin` should be 1 for for the Afghanistan-Pakistan rivalry. It was the
#' main one for Afghanistan, but not for Pakistan. I can at least think that
#' out loud, but I'm disinclined to impute that coding on behalf of the authors
#' or the user.
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
