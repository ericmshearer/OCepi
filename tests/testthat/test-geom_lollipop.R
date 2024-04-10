df <- data.frame(Country = c("UK-A","US-A","UK-B","US-B"), POST = c(4,5,6,7))

test_that("check class", {
  expect_equal(
    class(OCepi::geom_lollipop())[2],
    "Layer")
})

plot_test <- ggplot(data = df, aes(x = Country, y = POST)) +
  geom_lollipop(linewidth = 3, size = 5)

test_that("default aes - point type", {
  expect_equal(
    plot_test$layers[[1]]$geom$default_aes$colour,
    "black")
})

test_that("default aes - colour", {
  expect_equal(
    plot_test$layers[[1]]$geom$default_aes$colour,
    "black")
})

test_that("check stem thickness", {
  expect_equal(
    plot_test$layers[[1]]$geom_params$linewidth,
    3)
})
