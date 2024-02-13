test_that("convert week to week ending date, 1", {
  expect_equal(
    mmwrweek_to_date(2014, 53),
    as.Date("2015-01-03")
    )
})

test_that("convert week to week ending date, 2", {
  expect_equal(
    mmwrweek_to_date(2023, 40),
    as.Date("2023-10-07")
  )
})

test_that("attempt to pass input string, 1", {
  expect_error(
    mmwrweek_to_date("2023", 40),
    "Input not in numeric format."
  )
})

test_that("attempt to pass input string, 2", {
  expect_error(
    mmwrweek_to_date(2023, "40"),
    "Input not in numeric format."
  )
})
