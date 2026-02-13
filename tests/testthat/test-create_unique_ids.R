test_that("make 20 ids", {
  expect_length(
    create_unique_ids(20),
    20
  )
})

id <- create_unique_ids(1)

test_that("verify unique is 12 characters long", {
  expect_equal(
    nchar(id),
    12
  )
})
