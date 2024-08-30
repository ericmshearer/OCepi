test_that("highlight fill", {
  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_bar(stat = "identity") +
    desaturate_geom(loc=="a", pal = "#d55c19", desaturate = 0.7)

  expect_equal(p$layers[[2]]$aes_params$fill, "#d55c19")
})

test_that("desaturate color", {
  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_bar(stat = "identity") +
    desaturate_geom(loc=="a", pal = "#d55c19", desaturate = 0.7)

  expect_equal(p$layers[[1]]$aes_params$fill, "#F2CEBA")
})

test_that("point params", {
  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_point(stat = "identity") +
    desaturate_geom(loc=="a", pal = "#d55c19", desaturate = 0.7)

  expect_equal(p$layers[[1]]$aes_params$size, NULL)
  expect_equal(p$layers[[2]]$aes_params$colour, "#d55c19")
})
