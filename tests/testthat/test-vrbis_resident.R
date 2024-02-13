df <- data.frame(
  place_of_death = c("2","6","1","1"),
  county_of_death_code = c("20","30","30","40"),
  county_fips = c("030","059","059","040")
)

test_that("mark deaths as resident/non-resident", {
  expect_equal(
    df %>% dplyr::mutate(lhj_resident = vrbis_resident(place_of_death, county_of_death_code, county_fips, fips = "059", county_code = "30")),
    data.frame(
      place_of_death = c("2","6","1","1"),
      county_of_death_code = c("20","30","30","40"),
      county_fips = c("030","059","059","040"),
      lhj_resident = c(0,1,1,0)
      )
    )
})
