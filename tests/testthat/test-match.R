test_that("match 1", {
  expect_equal(
    match_id_1("Mickey","Mouse","1955-07-17","1313 Disneyland Dr"),
    "MICKMOUS1955-07-171313 Disne"
  )
})

test_that("match 2", {
  expect_equal(
    match_id_2("Mickey","Mouse","1955-07-17","1313 Disneyland Dr"),
    "MICKMOUS1955-07-171313 Disneyland Dr"
  )
})

test_that("match 3", {
  expect_equal(
    match_id_3("Mickey","Mouse","1955-07-17","7147814636"),
    "MICKMOUS1955-07-177147814636"
  )
})

test_that("match 4", {
  expect_equal(
    match_id_4("Mickey","Mouse","1955-07-17"),
    "MICKMOUS1955-07-17"
  )
})
