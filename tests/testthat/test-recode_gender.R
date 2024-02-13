df <- data.frame(gender = c("G","D",NA,"M","TF"))

test_that("recode gender data from CalREDIE", {
  expect_equal(
    df %>% dplyr::mutate(gender_new = recode_gender(gender)),
    data.frame(
      gender = c("G","D",NA,"M","TF"),
      gender_new = c("Genderqueer/Non-binary","Missing/Unknown","Missing/Unknown","Male","Transgender woman")
      )
    )
})
