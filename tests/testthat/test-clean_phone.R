test_that("check US phone number", {
  expect_equal(clean_phone("(714) 779-7777"), "7147797777")
})

test_that("check international number", {
  expect_equal(clean_phone("+442074471400"), NA)
})
