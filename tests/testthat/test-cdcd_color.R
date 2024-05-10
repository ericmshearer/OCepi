test_that("london pink", {
  expect_equal(
    cdcd_color("london pink"), "#9e0059")
})


test_that("error in cdcd color", {
  expect_error(
    cdcd_color("steel grey"), "Color not available.")
})
