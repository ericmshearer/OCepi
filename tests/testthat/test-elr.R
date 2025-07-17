test_that("same length-pos", {
  expect_equal(
    length(pos()),
    16
  )
})

test_that("pos in vector", {
  expect_equal(
    "POSITIVE" %in% pos(),
    TRUE
  )
})

test_that("pos string detect", {
  expect_equal(
    grepl("POSITIVE", pos(collapse = TRUE)),
    TRUE
  )
})

test_that("same length-neg", {
  expect_equal(
    length(neg()),
    23
  )
})

test_that("negative vector", {
  expect_equal(
    "NEGATIVE" %in% neg(),
    TRUE
  )
})

test_that("neg string detect", {
  expect_equal(
    grepl("NEGATIVE", neg(collapse = TRUE)),
    TRUE
  )
})
