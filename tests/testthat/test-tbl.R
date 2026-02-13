dat <- linelist |>
  select(Gender, Ethnicity) |>
  dashboard_tbl()

test_that("seven rows", {
  expect_equal(
    nrow(dat),
    7
    )
})

test_that("five cols", {
  expect_equal(
    ncol(dat),
    5
  )
})

test_that("check col names", {
  expect_equal(
    names(dat),
    c("Variable","Category","n","Percent","Label")
  )
})

dat2 <- linelist |>
  select(Gender, Ethnicity) |>
  dashboard_tbl(group_by = Gender)

test_that("group_by - fifteen rows", {
  expect_equal(
    nrow(dat2),
    15
  )
})

test_that("group_by - six cols", {
  expect_equal(
    ncol(dat2),
    6
  )
})

test_that("group_by - check col names", {
  expect_equal(
    names(dat2),
    c("Year","Variable","Category","n","Percent","Label")
  )
})
