test_that("check US phone number", {
  expect_equal(clean_phone("(714) 779-7777"), "7147797777")
})

test_that("check dataframe", {
  expect_equal(
    data.frame(phone = clean_phone(c("+442074471400","714) 779-7777"))),
    data.frame(phone = c(NA_character_,"7147797777"))
  )
})
