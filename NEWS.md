peacesciencer 0.7.0 (in development)
---------------------------------------------------------------------

This is a leader-intensive update. Additions/new features include:

- `lwuf`: a data set from [Carter and Smith (2020)](https://doi.org/10.1017/S0003055420000313) measuring leader willingness to use force.
- `download_extdata()` now also downloads directed leader dyad-year data for all directed leader dyad-years from 1870 to 2015.
- `create_leaderdyadyears()`: create leader dyad-year data (via `archigos`) for all leader dyad-year combinations from 1870 to 2015. This function leans on remote data available for download in `download_extdata()`.
- `gml_part`: a data set on participant summary information from the GML MID data.
- `add_gml_mids()` now works with leader-year data. See documentation for more.

Other changes include:

- The data in `cow_sdp_gdp` and `gw_sdp_gdp` are now rounded to three decimal points.  These "economic" data are routinely the biggest in the package, and it's because of the decimal points. The justification for this is these data are estimated/simulated anyways and 
the information loss is at the 1/1000th decimal point. This procedure basically cuts the size of the data to be less than 25% of 
its original size. This is a huge reduction in disk space. The original simulations are [available for remote download](http://svmiller.com/R/peacesciencer/) if you'd like. Type `?download_extdata()` for more information.
- "leader-year" (`leader_year`) is now an attribute. Where appropriate, leader-year and state-year functions are treated the same. For example, the GDP data contained in  `add_sdp_gdp()` are fundamentally state-year, but perhaps a leader-year control of interest even as leaders are nested in states.
- `create_leaderyears()` works on the observation ID and not the leader ID. Observation IDs are unique to each leader-period, but leader IDs are not.

peacesciencer 0.6.0
---------------------------------------------------------------------

- Extend `cow_mindist` and `gw_mindist` data, given new `{cshapes}` updates. Data now run from 1886 to 2019.
- Create `cow_capitals` and `gw_capitals` data. Remove `capitals` data for redundancy. Both capital data sets extended to 2020.
- `add_capital_distance()` now works with Correlates of War and Gleditsch-Ward data, both dyad-year and state-year.
- Fix bug in `add_atop_alliance()` that added 0s to years after the ATOP domain. Thanks to @joshuaalley for pointing this out.
- Add/start a helper function file. These are internal functions I may need to write in order to reduce the potential of dependency issues resulting in package archival. This was necessitated by an Oct. 5, 2021 email from Brian Ripley about the slated removal of `{lubridate}`. Earlier versions of this package uncritically leaned on `{lubridate}` for functions I could either write myself (i.e. `year()`, which is now `.pshf_year()`) or were already duplicated in base functions in R (i.e. `ymd()`, a wrapper for `as.Date()` as I use it). With it, `{lubridate}` is no longer a requirement for this package.
- Upgrade GML conflict data sets to 2.2.1. Fix/update documentation on this.
- Add dispute-level summary of GML conflict data to assist with user-run whittle functions. This is `gml_mid_disps`.
- Add `ps_conflict_type` attributes for some conflict data (e.g. CoW-MID, GML).
- Add messages about case exclusion rules to `add_cow_mids()` and `add_gml_mids()`.
- Add "whittle" class of functions. These include `whittle_conflicts_onsets()`, `whittle_conflicts_fatality()`, `whittle_conflicts_hostility()`, `whittle_conflicts_duration()`, `whittle_conflicts_reciprocation()`, `whittle_conflicts_startmonth()`, and `whittle_conflicts_jds()`. These are admittedly gnarly function names to type out if you don't have an IDE like Rstudio to assist you. Thus, these respective functions come with shortcuts of `wc_` (e.g. `wc_onsets()`). Check the package documentation to see what these are.
- Add `show_duplicates()` as a diagnostic tool. This function is useful for users who want to do some advanced stuff with data created in `{peacesciencer}` (e.g. merging in custom data) and want to see if they botched a merge by creating duplicate observations.
- Add/update stuff related to leaders. The `archigos` data frame now includes some more information about leaders (e.g. name, gender, and year of birth). `create_leaderyears()` will create leader-year data as well. The next update will expand more on leader functions. For now, the ensuing output from this function is treated as synonymous to state-year data.
- Add `download_extdata()` as a way of side-stepping package space limitations. Some files will have to be stored remotely and then loaded at the user's discretion, which is what this function will do. This was largely brought on by the CoW trade data (`cow_trade_ndy`), which is also removed in this update. More data may have to be moved remotely in the future, though this package will endeavor to keep this to a bare minimum. Importantly, `download_extdata()` keeps inventory of what it is downloading. Data information is included therein. This develop does implicitly assume that the directory in which this package is installed is writable by the user. For like 99% of users, this shouldn't be a problem (and executing `.libPaths()` should confirm that). Do reach out if it is.
- Remove country name from `creg` data frame.

peacesciencer 0.5.0
---------------------------------------------------------------------

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


peacesciencer 0.4.0
---------------------------------------------------------------------

- Add `cow_mid_ddydisps`, `cow_mid_dirdisps`, and `cow_mid_disps` data.
- Add `gml_mid_ddydisps` data.
- Add `add_cow_mids()` function.
- Add `add_gml_mids()` function.
- Add `add_peace_years()` function.
- Deprecate `add_mids()`. Use `add_gml_mids()` instead.
- Assign `ps_data_type == "dyad_year"` as attribute to `cow_mid_dirdisps` and `gml_dirdisp`. This allows `{peacesciencer}` functions for these data sets.
- File compression for data files (again)

peacesciencer 0.3.0
---------------------------------------------------------------------

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


peacesciencer 0.2.0
---------------------------------------------------------------------

- Fix stupid mistake(s) in README.
- File compression for the data files.
- Add Correlates of War intergovernmental organizations data.
- Add function for adding Correlates of War intergovernmental organizations data.
- Add Correlates of War trade data (state-year and dyad-year).
- Add minimum distance data
- Add citations data frame for assistance in properly citing things.
- Add `create_statedays()` function.


peacesciencer 0.1.0
---------------------------------------------------------------------

- Initial developmental release
