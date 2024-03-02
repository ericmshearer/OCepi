x = as.Date("2022-01-01")
y = as.Date("2024-03-01")

test_that("days", {
  expect_equal(time_between(y, x, unit = "days"), 790)
})

test_that("weeks", {
  expect_equal(time_between(y, x, unit = "weeks"), 112)
})

test_that("months", {
  expect_equal(time_between(y, x, unit = "months"), 25)
})

test_that("years", {
  expect_equal(time_between(y, x, unit = "years"), 2)
})

test_that("reverse dates", {
  expect_equal(time_between(x, y, unit = "days"), -790)
})


test_that("passing non-date", {
  expect_error(time_between(as.character(y), x, unit = "days"), "Input not in date format.")
})
