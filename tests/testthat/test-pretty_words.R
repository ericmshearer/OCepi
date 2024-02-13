test_that("simple title casing", {
  expect_equal(pretty_words("hello there"), "Hello There")
})

df <- data.frame(address = c("1234 MaIn StReEt"))

test_that("simple title casing, df", {
  expect_equal(
    df %>% dplyr::mutate(address = pretty_words(address)),
    data.frame(address = c("1234 Main Street"))
    )
})
