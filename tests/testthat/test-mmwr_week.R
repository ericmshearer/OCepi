test_that("mmwr week", {
  expect_equal(
    mmwr_week(as.Date("2023-10-01")),
    40
    )
})

test_that("attempt to pass string input", {
  expect_error(
    mmwr_week("2023-10-01"),
    "Input not in date format."
    )
})
