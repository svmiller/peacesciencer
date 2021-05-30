context("No duplicates! What are duplicates doing in your peace science data when I told you NO. DUPLICATES. EVER! WHY!")

library(dplyr)
library(magrittr)

test_that("Dyad-year additions do not create duplicates", {
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_contiguity()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_gwcode_to_cow()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_capital_distance()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_majors()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_trade()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_democracy()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_gwcode_to_cow()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_gml_mids()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_mids()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_mids() %>% add_gml_mids() %>% add_peace_years()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_alliance()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_nmc()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_archigos()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_minimum_distance(system="cow")))
  expect_equal(nrow(create_dyadyears(system = "gw")), nrow(create_dyadyears(system = "gw") %>% add_minimum_distance(system="gw")))

})


test_that("State-year additions do not create duplicates", {
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_gwcode_to_cow()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_contiguity()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_capital_distance()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_cow_majors()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_cow_trade()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_democracy()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_gwcode_to_cow()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_nmc()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_archigos()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_minimum_distance(system="cow")))
  expect_equal(nrow(create_stateyears(system = "gw")), nrow(create_stateyears(system = "gw") %>% add_ucdp_onsets()))
  expect_equal(nrow(create_stateyears(system = "gw")), nrow(create_stateyears(system="gw") %>% add_minimum_distance(system="gw")))
})
