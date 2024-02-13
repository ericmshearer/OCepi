test_that("week ending date, Saturday", {
  expect_equal(
    week_ending_date(as.Date("2023-10-01")),
    as.Date("2023-10-07")
    )
})

test_that("attempt to pass string input", {
  expect_error(
    week_ending_date("2023-10-01"),
    "Input not in date format."
  )
})
