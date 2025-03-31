test_that("single input", {
  expect_equal(recode_race("Asian"), "Asian")
})

test_that("dual input", {
  expect_equal(recode_race("Hispanic or Latino","Asian"), "Hispanic/Latinx")
})

test_that("loinc input", {
  expect_equal(recode_race("2106-3"), "White")
})

test_that("multi-race status from VRBIS input", {
  expect_equal(recode_race("9"), "Missing/Unknown")
})

df <- data.frame(
  ethnicity = c("Hispanic or Latino","Hispanic or Latino","Unknown","Not Hispanic or Latino"),
  race = c("Unknown","Black or African American","American Indian or Alaska Native","Native Hawaiian or Other Pacific Islander")
  )

test_that("data.frame with dual inputs, abbreviate long names", {
  expect_equal(
    df %>% dplyr::mutate(race_ethnicity = recode_race(ethnicity, race, abbr_names = TRUE)),
    data.frame(
      ethnicity = c("Hispanic or Latino","Hispanic or Latino","Unknown","Not Hispanic or Latino"),
      race = c("Unknown","Black or African American","American Indian or Alaska Native","Native Hawaiian or Other Pacific Islander"),
      race_ethnicity = c("Hispanic/Latinx","Hispanic/Latinx","AI/AN","NHOPI")
      )
    )
})

test_that("data.frame with dual inputs, return long names", {
  expect_equal(
    df %>% dplyr::mutate(race_ethnicity = recode_race(ethnicity, race, abbr_names = FALSE)),
    data.frame(
      ethnicity = c("Hispanic or Latino","Hispanic or Latino","Unknown","Not Hispanic or Latino"),
      race = c("Unknown","Black or African American","American Indian or Alaska Native","Native Hawaiian or Other Pacific Islander"),
      race_ethnicity = c("Hispanic/Latinx","Hispanic/Latinx","American Indian/Alaska Native","Native Hawaiian/Other Pacific Islander")
    )
  )
})
