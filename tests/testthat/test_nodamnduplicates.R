context("No duplicates! What are duplicates doing in your peace science data when I told you NO. DUPLICATES. EVER! WHY!")

library(dplyr)
library(magrittr)

test_that("Dyad-year additions do not create duplicates", {
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_contiguity()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_capital_distance()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_majors()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_democracy()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_gwcode_to_cow()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_mids()))
  expect_equal(nrow(cow_ddy), nrow(cow_ddy %>% add_cow_alliance()))

})


test_that("State-year additions do not create duplicates", {
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_contiguity()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_capital_distance()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_cow_majors()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_democracy()))
  expect_equal(nrow(create_stateyears()), nrow(create_stateyears() %>% add_gwcode_to_cow()))
})
