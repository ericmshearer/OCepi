test_that("mmwr year", {
  expect_equal(
    mmwr_year(as.Date("2023-10-01")), 2023)
})

test_that("attempt to pass string input", {
  expect_error(
    mmwr_year("2023-10-01"),
    "Input not in date format."
    )
})
