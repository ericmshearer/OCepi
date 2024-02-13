test_that("clean address then remove extra info", {
  expect_equal(clean_address("1234 main st apt 4", keep_extra = FALSE), "1234 Main Street")
})

test_that("clean address and keep extra info", {
  expect_equal(clean_address("1234 main st apt 4", keep_extra = TRUE), "1234 Main Street Apartment 4")
})

df <- data.frame(Address = c("123 Sky Cir","234 main st unit #3","77 ridgeline space 33"))

test_that("clean addresses from dataframe", {
  expect_equal(
    df %>% dplyr::mutate(Address = clean_address(Address)),
    data.frame(Address = c("123 Sky Circle","234 Main Street Unit #3","77 Ridgeline Space 33"))
    )
})
