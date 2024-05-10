test_that("specify to show legend at top", {
  theme <- theme_apollo(direction = "horizontal", legend = "Show")
  expect_s3_class(theme, "theme")
  expect_equal(theme$legend.position, "top")
})

test_that("specify font", {
  theme <- theme_apollo(direction = "horizontal", font = "Arial")
  expect_s3_class(theme, "theme")
  expect_equal(theme$plot.title$family, "Arial")
})

test_that("theme_apollo works", {
  theme <- theme_apollo(direction = "horizontal")
  expect_s3_class(theme, "theme")
  expect_equal(theme$plot.title$size, 24)
  expect_equal(theme$plot.subtitle$size, 20)
  expect_equal(theme$plot.caption$size, 12)
  expect_equal(theme$plot.title$size, 24)
  expect_equal(theme$axis.ticks.length.y, unit(0.15, "cm"))
  expect_equal(theme$axis.ticks.length.x, unit(0, "cm"))
})

test_that("theme_apollo works", {
  theme <- theme_apollo(direction = "vertical")
  expect_s3_class(theme, "theme")
  expect_equal(theme$plot.title$size, 24)
  expect_equal(theme$plot.subtitle$size, 20)
  expect_equal(theme$plot.caption$size, 12)
  expect_equal(theme$plot.title$size, 24)
})
