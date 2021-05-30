# This is a skeleton...

add_something <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

  } else  {
    stop("add_something() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
