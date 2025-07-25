# peacesciencer 1.2.0

Changes include:

- Package now assumes a version of R greater than 4.1.0. `{isard}` introduced as dependency.
- `add_cow_alliance()` is deprecated and slated for removal at the request of the data set's maintainer. The function right now returns a stop communicating this information, also at the request of the data set's maintainer.
- `add_sdp_gdp()` is deprecated and slated for removal. Its functionality is replaced by `add_sim_gdp_pop()`.
- `add_gml_mids()` is superseded in light of the release of the MIC data.
- `add_cow_mids()` is superseded.
- `cow_alliance`, `ccode_democracy`, `gwcode_democracy`, `cow_sdp_gdp`, `gw_sdp_gdp`, `cow_gw_years`, and `gw_cow_years` are deprecated and slated for removal.
- Fix error in `cow_capitals` data that did not adequately record Burundi's capital change in 2018. This concerns the data generated for `cow_capitals`.
- Fix error in `tss_rivalries` for `tssr_id = 61`. This was in the book but the change in the data-raw directory shows what they assuredly meant. 
- Add `mry` argument to `add_cow_majors()`, fix bug identified by @rochelleterman in [17](https://github.com/svmiller/peacesciencer/issues/17)
- Fix issue of imputing 0s outside temporal domain of contiguity data for `add_contiguity()`. Brought to my attention by @jandresgannon in [19](https://github.com/svmiller/peacesciencer/issues/19).
- `atop_alliance` updated to version 5.1.
- `add_atop_alliance` has an extra argument (`ndir`) for how it should perform on non-directed dyad-year or leader-dyad-year data.
- `cow_capitals` and `gw_capitals` formally current through 2024. Indonesia is the most likely candidate to require an update in these data, though that change has not happened yet. `cow_capitals` and `gw_capitals` further include some corrections and the introduction of start and end dates for capitals.
- `gw_ddy` and `cow_ddy` current through 2024.
- `add_ccode_to_gw()` and `add_gwcode_to_cow()` now lean on data in `{isard}`.
- `add_capital_distance()` includes an argument (`"transsum"`) for what observation to privilege for yearly summaries in which there was a capital transition. Support for leader-level data momentarily dropped.
- `cow_contdir` replaces columns `begin` and `end` with `stdate` and `enddate` communicating the same information, but in date form.
- `add_contiguity()` has an argument (`"slice"`) that determines its behavior for when there is a change in a contiguity relationship in a given year. The `mry` argument actually does something now.
- `ccode_democracy` and `gwcode_democracy` are deprecated and slated for removal. Democracy data are now maintained in the `{isard}` package.
- `add_democracy()` now leans on `{isard}` for democracy data.
- `add_democracy()` and `add_nmc()` have a `keep` argument now, allowing the user to select particular estimates from the democracy/capabilities data rather than get everything (including stuff they don't want).
- `add_strategic_rivalries()` uses `tss_rivalries` now and no longer has additional arguments prioritizing rivalry type.
- `add_minimum_distance()` optionally (and by default) incorporates extended data available in `download_extdata()`.
- The "create" functions lean on the state system data maintained in `{isard}`. This also means micro-states in the G-W system are included.
- `false_gw_dyads` now includes information about whether the first or second state is/was a micro-state. Two directed entries for Sao Tome and Principe and the Republic of Vietnam were added as well.
- Shortcuts added: `add_cap_dist()` for `add_capital_distance()`, `add_creg_frac()` for `add_creg_fractionalization()`, `add_min_dist()` for `add_minimum_distance()`.
- `ucdp_acd` updated to 25.1. `add_ucdp_acd()` incorporates these newer versions of the data to allow for armed conflict analyses through 2024.

Additions include:

- `archigossums` is a basic yearly summary of leader turnover in the `archigos` data. It will make `add_archigos()` much faster by cutting down on computation time.
- `add_sim_gdp_pop()` replaces `add_sdp_gdp()`, using data from `{isard}`
- `terrthreat` is a state-year data set on latent territorial threat. `add_latent_territorial_threat()` will add it to your data frames.

# peacesciencer 1.1.0

Changes include:

- Package now depends on version 1.6.0 of `{stevemisc}`. This comes as later versions of R balk at the use of `order()` on data frames.
- Changes to documentation for clarity/presentation.
- Changes to file compression, where appropriate.
- `download_extdata()` will download some augmented dyadic minimum distance data for CoW and G-W states from 1886 to 2019.
- Add `tss_rivalries` as updated rivalry data from 1494 to 2020.
- Fixed a bug in `atop_alliance` and `cow_alliance`. It's less of a `{peacesciencer}` bug, per se, but the raw data that were presented as directed were actually not directed at all. They are now.
- Fixed a bug in `add_cow_alliance()` that did not honor the temporal bound of the alliance data (i.e. 1816-2012). My b.

# peacesciencer 1.0.0

This version has a few odds and ends and a version accelerated to 1.0.0 to coincide with the acceptance of [a manuscript describing this package](http://svmiller.com/peacesciencer/ms.pdf) in *Conflict Management and Peace Science*.

- Clarify `add_cow_mids()` and `add_gml_mids()` about the default case-exclusion rules for dyadic analyses.
- Assorted documentation upgrades for clarity.
- The dyadic foreign policy similarity data now have Tau-b estimates. These were generated by me, using valued alliance data, and should be used with some caution (or perhaps not used at all). Check the documentation for `add_fpsim()` and `download_extdata()` for more.
- Update national material capabilities data (`cow_nmc`) to version 6.0.
- Update `cow_ddy` and `gw_ddy`, since it's 2022 now.
- Add `grh_arms_races` for arms race data.
- Amend/update a few items in `ps_bib`.
- Change `ps_cite()` to no longer depend on `{bib2df}`. With it, remove `{bib2df}` as a package dependency.



# peacesciencer 0.7.0


This is a leader-intensive update. Additions/new features include:

- `LEAD`: a data set on select leader experience and attribute descriptions (LEAD).
- `lwuf`: a data set from [Carter and Smith (2020)](https://doi.org/10.1017/S0003055420000313) measuring leader willingness to use force.
- `download_extdata()` now also downloads directed leader dyad-year data for all directed leader dyad-years from 1870 to 2015. The data come in two forms. One is all possible (inter-state, leader-overlap) dyadic leader pairings from 1870 to 2015, as presented in the Archigos data. The second standardizes these data to the CoW state system data. It also downloads directed dyad-yer data of chance-corrected measures of dyadic
foreign policy similarity. Type `?download_extdata()` in the R session after updating for more information.
- `create_leaderdyadyears()`: create leader dyad-year data (via `archigos`) for all leader dyad-year combinations from 1870 to 2015. This function leans on remote data available for download in `download_extdata()`. The function returns either all possible Gleditsch-Ward dyadic leader pairings (standardized to Gleditsch-Ward state system dates) or standardizes the Archigos data to Correlates of War state system member data.
- `gml_part`: a data set on participant summary information from the GML MID data.
- `add_fpsim()` adds estimates of dyadic foreign policy similarity to your dyad-year and leader-dyad-year data.
- `add_gml_mids()` now works with leader-year data. See documentation for more.
- `add_spells()` will do more general peace spell calculations, though this package will now depend on v. 1.3.0 of `{stevemisc}`.
- `add_lwuf()` adds estimates of leader willingness to use force to leader-year and leader-dyad-year analyses.
- `add_lead()` adds some leader attributes to leader-year or leader-dyad-year analyses.
- `gml_mid_dirleaderdisps` and `gml_mid_ddlydisps` include data on leader dyads in conflict.
- `declare_attributes()` allows users to declare package-specific attributes to outside data they bring to the R session. This allows the user to use many of the shortcuts in this package to their data.
- `ps_version()` will display version information about the data included in this package.
- `false_cow_dyads` and `false_gw_dyads` list a handful of dyads that appear in the same year, but never on the same day in the year. They're used for anti-joining in `create_dyadyears()`.
- `leader_codes` matches, as well as one can, leader/observation codes in Archigos 4.1, Archigos 2.9, and the LEAD data.

Other changes include:

- Several functions now have leader-year or leader-dyad-year corollaries. Examples here include `add_creg_fractionalization()`, `add_rugged_terrain()`, `add_democracy()`, and more. Some functions, like `add_gml_mids()`, can be anchored explicitly to leader-level units of analyses. Several other functions (e.g. `add_sdp_gdp()` and others like it) are fundamentally still state-year or dyad-year functions the extent to which leaders are still nested in states and leader-dyads are just a derivation of inter-state dyads (i.e. leaders are nested in states). Use with some caution with that in mind, though these functions are still useful for leader-level analyses that are interested in some of these covariates for making state-to-state comparisons on top of leader-level analyses.
- The data in `cow_sdp_gdp` and `gw_sdp_gdp` are now rounded to three decimal points.  These "economic" data are routinely the biggest in the package, and it's because of the decimal points. The justification for this is these data are estimated/simulated anyways and 
the information loss is at the 1/1000th decimal point. This procedure basically cuts the size of the data to be less than 25% of 
its original size. This is a huge reduction in disk space.
- "leader-year" (`leader_year`) is now an attribute. Where appropriate, leader-year and state-year functions are treated the same. For example, the GDP data contained in  `add_sdp_gdp()` are fundamentally state-year, but perhaps a leader-year control of interest even as leaders are nested in states.
- "leader-dyad-year" (`leader_dyad_year`) is now an attribute. Where appropriate, leader-year and leader-dyad-year functions are treated the same. Where possible/tractable, leader-dyad-year data are explicitly anchored to leader-level units of analysis (e.g. `add_gml_mids()`, prominently).
- `create_leaderyears()` works on the observation ID and not the leader ID. Observation IDs are unique to each leader-period, but leader IDs are not.
- The directed leader dyad-year data is indexed by observation ID and not leader ID, per se. This is because leaders can have multiple terms in office.
- `add_peace_years()` has been superseded by `add_spells()`. The "superseded" language communicates the function will still work as it has for previous releases, for data types supported by the function, though its development will stop. `add_spells()` promises to have greater functionality. Communicating these changes via badges brings in `{lifecycle}` as an imported package.
- `archigos` data's `ccode` has been renamed to `gwcode` to reflect these are actually Gleditsch-Ward state codes.
- The "whittle" functions now work with leader-dyadic conflict data available in the package.
- The package has started taking inventory of non-ASCII characters that appear in the package (e.g. spelling "Wuerttemberg" with the U-umlaut) and replacing them. This is not a functionality issue at all. The problem is CRAN raises a note for every single non-ASCII character it sees and I'd like to avoid the CRAN hammer if I can.
- `create_leaderyears()`, `create_dyadyears()`, and `create_stateyears()` have a built-in argument for subsetting the years returned by the function (`subset_years`). Use to your discretion.

# peacesciencer 0.6.0


- Extend `cow_mindist` and `gw_mindist` data, given new `{cshapes}` updates. Data now run from 1886 to 2019.
- Create `cow_capitals` and `gw_capitals` data. Remove `capitals` data for redundancy. Both capital data sets extended to 2020.
- `add_capital_distance()` now works with Correlates of War and Gleditsch-Ward data, both dyad-year and state-year.
- Fix bug in `add_atop_alliance()` that added 0s to years after the ATOP domain. Thanks to @joshuaalley for pointing this out.
- Add/start a helper function file. These are internal functions I may need to write in order to reduce the potential of dependency issues resulting in package archival. This was necessitated by an Oct. 5, 2021 email from Brian Ripley about the slated removal of `{lubridate}`. Earlier versions of this package uncritically leaned on `{lubridate}` for functions I could either write myself (i.e. `year()`, which is now `.pshf_year()`) or were already duplicated in base functions in R (i.e. `ymd()`, a wrapper for `as.Date()` as I use it). With it, `{lubridate}` is no longer a requirement for this package.
- Upgrade GML conflict data sets to 2.2.1. Fix/update documentation on this.
- Add dispute-level summary of GML conflict data to assist with user-run whittle functions. This is `gml_mid_disps`.
- Add `ps_conflict_type` attributes for some conflict data (e.g. CoW-MID, GML).
- Add messages about case exclusion rules to `add_cow_mids()` and `add_gml_mids()`.
- Add "whittle" class of functions. These include `whittle_conflicts_onsets()`, `whittle_conflicts_fatality()`, `whittle_conflicts_hostility()`, `whittle_conflicts_duration()`, `whittle_conflicts_reciprocation()`, `whittle_conflicts_startmonth()`, and `whittle_conflicts_jds()`. These are admittedly gnarly function names to type out if you don't have an IDE like RStudio to assist you. Thus, these respective functions come with shortcuts of `wc_` (e.g. `wc_onsets()`). Check the package documentation to see what these are.
- Add `show_duplicates()` as a diagnostic tool. This function is useful for users who want to do some advanced stuff with data created in `{peacesciencer}` (e.g. merging in custom data) and want to see if they botched a merge by creating duplicate observations.
- Add/update stuff related to leaders. The `archigos` data frame now includes some more information about leaders (e.g. name, gender, and year of birth). `create_leaderyears()` will create leader-year data as well. The next update will expand more on leader functions. For now, the ensuing output from this function is treated as synonymous to state-year data.
- Add `download_extdata()` as a way of side-stepping package space limitations. Some files will have to be stored remotely and then loaded at the user's discretion, which is what this function will do. This was largely brought on by the CoW trade data (`cow_trade_ndy`), which is also removed in this update. More data may have to be moved remotely in the future, though this package will endeavor to keep this to a bare minimum. Importantly, `download_extdata()` keeps inventory of what it is downloading. Data information is included therein. This develop does implicitly assume that the directory in which this package is installed is writable by the user. For like 99% of users, this shouldn't be a problem (and executing `.libPaths()` should confirm that). Do reach out if it is.
- Remove country name from `creg` data frame.

# peacesciencer 0.5.0


- Add `{bib2df}` as package dependency. Force upgraded version of `{stevemisc}` as package dependency.
- Add `LazyDataCompression: xz` to DESCRIPTION
- Add "system" attributes to `create_dyadyears()`, `create_statedays()`, and `create_stateyears()`.
- Add `add_cow_wars()` function.
- Add `add_ccode_to_gw()`. Fix underlying data for `cow_gw_years`. Add `gw_cow_years`.
- Add `add_strategic_rivalries()`.
- Add `add_ucdp_acd()`. With it, update `ucdp_acd` data for functionality.
- Add `add_rugged_terrain()`.
- Add `cow_trade_ndy` data. With it, update `add_cow_trade()` function for speed upgrades.
- Add `cow_war_inter`, `cow_war_intra` data.
- Add `creg` data.
- Add `gwcode_democracy` data. `add_democracy()` now takes CoW or G-W data.
- Add `hief` data.
- Add `rugged` data.
- Add `td_rivalries` data.
- Add `ps_cite()` and `ps_bib`. Remove `citations`.
- Add log-transformed GDP per capita estimates to `cow_sdp_gdp` and `gw_sdp_gdp`. Update `add_sdp_gdp()` to reflect this change.
- Clarify documentation for `add_contiguity()` for why non-contiguous dyads are 0s and not 6s. Briefly: I don't think of these data as ordinal and I don't encourage the researcher to think of them as ordinal either.
- Expand `add_peace_years()`, which now works with UCDP conflict data.
- `filter_prd()` is now a shortcut for `add_contiguity()` and/or `add_cow_majors()` if it is called near the top of the pipe (i.e. before the user executed the commands required to calculate politically relevant dyad status).
- Fix bug in `add_nmc()` (and `cow_nmc`). -9 is now explicitly NA, as it should have been.
- Fix some typos/incomplete information in documentation. These concerned references to scholarship on these topics.
- Patch `add_peace_years()`, which can now be used anywhere in the chain of commands (instead of just last). `add_peace_years()` is also a bit more "general" and includes a derivation of the `sbtscs()` function from the `{stevemisc}` package.
- Remove mandatory "system" calls in `add_minimum_distance()` and `add_sdp_gdp()`. These merges now lean on system attributes declared in `create_dyadyears()` and `create_stateyears()`.
- Remove `add_mids()`. Use `add_gml_mids()` instead.
- Update `cow_ddy` and its documentation.


# peacesciencer 0.4.0


- Add `cow_mid_ddydisps`, `cow_mid_dirdisps`, and `cow_mid_disps` data.
- Add `gml_mid_ddydisps` data.
- Add `add_cow_mids()` function.
- Add `add_gml_mids()` function.
- Add `add_peace_years()` function.
- Deprecate `add_mids()`. Use `add_gml_mids()` instead.
- Assign `ps_data_type == "dyad_year"` as attribute to `cow_mid_dirdisps` and `gml_dirdisp`. This allows `{peacesciencer}` functions for these data sets.
- File compression for data files (again)

# peacesciencer 0.3.0


- Add `atop_alliance` (directed dyad-year) data
- Add `archigos` data
- Add `cow_sdp_gdp` and `gw_sdp_gdp` data
- Add `ucdp_acd` data
- Add `ucdp_onsets` data
- Add `add_archigos()` function
- Add `add_atop_alliance()` function
- Add `add_minimum_distance()` function. For now, this has no default. You must specify "gw" or "cow".
- Add `add_sdp_gdp()` function. For now, this has no default. You must specify "gw" or "cow".
- Add `add_ucdp_onset()` function.
- Add "stops" that force the correct merge on the correct system code. In most applications, this is Correlates of War codes. 
- File compression for data files (again)
- Fixed bug in `filter_prd()`. Past versions of my code had treated non-contiguous dyads as 6s. Here, they're 0s. That created situations where I wasn't filtering anything at all with this function.
- Rename variables in `cow_alliance` to distinguish from ATOP equivalents.


# peacesciencer 0.2.0


- Fix stupid mistake(s) in README.
- File compression for the data files.
- Add Correlates of War intergovernmental organizations data.
- Add function for adding Correlates of War intergovernmental organizations data.
- Add Correlates of War trade data (state-year and dyad-year).
- Add minimum distance data
- Add citations data frame for assistance in properly citing things.
- Add `create_statedays()` function.


# peacesciencer 0.1.0


- Initial developmental release
