df <- data.frame(firstname = c("babyboy","TWINGIRL","Janie","Walt"))

test_that("find pesky birth dose records with no real first name", {
  expect_equal(
    df %>% dplyr::mutate(firstname = baby_name(firstname)),
    data.frame(
      firstname = c(NA,NA,"Janie","Walt")
      )
    )
})
