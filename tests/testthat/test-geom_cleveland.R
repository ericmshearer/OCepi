df <- data.frame(Country = c("UK-A","US-A","UK-B","US-B"), PRE = c(0,1,2,3), POST = c(4,5,6,7))

test_that("check class", {
  expect_equal(
    class(OCepi::geom_cleveland())[2],
    "Layer")
})

plot_test <- ggplot(data = df, aes(x = PRE, xend = POST, y = Country)) +
  geom_cleveland(colour_x = "#113a72", colour_xend = "#d55c19")

test_that("default aes - point type", {
  expect_equal(
    plot_test$layers[[1]]$geom$default_aes$shape,
    19)
})

test_that("default aes - colour", {
  expect_equal(
    plot_test$layers[[1]]$geom$default_aes$colour,
    "black")
})

test_that("default aes - linewidth", {
  expect_equal(
    plot_test$layers[[1]]$geom$default_aes$linewidth,
    1)
})
