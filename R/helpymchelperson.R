#' Extract years from date objects
#' @param date a date
#' @keywords internal
#' @export
#' @noRd

.pshf_year <- function(date) {
  x <- as.numeric(format(date, "%Y"))
  return(x)

}

#' Extract months from date objects
#' @param date a date
#' @keywords internal
#' @export
#' @noRd

.pshf_month <- function(date) {
  x <- as.POSIXlt(date)$mon + 1 # Importantly, Jan = 0 and Dec = 11
  return(x)

}
