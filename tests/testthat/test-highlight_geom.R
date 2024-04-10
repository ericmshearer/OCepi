test_that("check highlight fill", {

  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
                   )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_bar(stat = "identity") +
    highlight_geom(loc=="a", pal = "#d55c19")

  p$layers[[2]]$aes_params$fill

  expect_equal(p$layers[[2]]$aes_params$fill, "#d55c19")
})

test_that("check extra layer was created", {

  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_bar(stat = "identity") +
    highlight_geom(loc=="a", pal = "#d55c19")

  length(p$layers)

  expect_equal(length(p$layers), 2)
})

test_that("check expression", {

  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_bar(stat = "identity") +
    highlight_geom(loc=="a", pal = "#d55c19")

  expect_equal(
    p$layers[[2]]$data,
    data.frame(loc = "a", scores = 85)
    )
})

test_that("check point aes", {

  df <- data.frame(loc = letters[1:4],
                   scores = c(85,89,89.5,88)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores)) +
    geom_point(stat = "identity") +
    highlight_geom(loc=="a", pal = "#d55c19", alpha = 0.5, size = 3)

  expect_equal(
    p$layers[[2]]$aes_params$alpha,
    0.5
  )
  expect_equal(
    p$layers[[2]]$aes_params$size,
    3
  )
})

test_that("check line aes", {

  df <- data.frame(
    group = c(rep("A", 4), rep("B", 4)),
    loc = rep(letters[1:4], 2),
    scores = c(85,89,89.5,88, 50,65,66,59)
  )

  p <- ggplot(data = df, aes(x = loc, y = scores, group = group)) +
    geom_line() +
    highlight_geom(group=="B", pal = "#d55c19", linewidth = 5)

  expect_equal(
    p$layers[[2]]$aes_params$linewidth,
    5
  )
})
