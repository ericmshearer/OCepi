test_that("clean address then remove extra info", {
  expect_equal(clean_address("1234 main st apt 4", keep_extra = FALSE), "1234 MAIN STREET")
})

test_that("clean address and keep extra info", {
  expect_equal(clean_address("1234 main st apt 4", keep_extra = TRUE), "1234 MAIN STREET APARTMENT 4")
})

df <- data.frame(Address = c("123 Sky Cir","234 main st unit #3","77 ridgeline space 33"))

test_that("clean addresses from dataframe", {
  expect_equal(
    df %>% dplyr::mutate(Address = clean_address(Address)),
    data.frame(Address = c("123 SKY CIRCLE","234 MAIN STREET UNIT #3","77 RIDGELINE SPACE 33"))
    )
})
