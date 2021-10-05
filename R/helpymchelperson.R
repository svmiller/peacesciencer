#' Extract years from date objects
#' @param date a date
#' @keywords internal
#' @export
#' @noRd

.pshf_year <- function(date) {
  x <- as.numeric(format(date, "%Y"))
  return(x)

}
