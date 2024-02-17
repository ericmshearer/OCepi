df <- data.frame(sig_cond = c("HIV, Stroke","Cancer, Asthma","Hepatitis C","COVID-19, Human immunodeficiency virus"))

test_that("remove HIV, abbr and full", {
  expect_equal(
    suppressWarnings(df %>% hiv_redact()),
    data.frame(sig_cond = c("Stroke","Cancer, Asthma","Hepatitis C","COVID-19"))
    )
})

df <- data.frame(sig_cond = c("AIDS, Stroke","Cancer, Asthma","Hepatitis C","COVID-19, ACQUIRED IMMUNODEFICIENCY SYNDROME"))

test_that("remove AIDS, abbr and full", {
  expect_equal(
    suppressWarnings(df %>% hiv_redact()),
    data.frame(sig_cond = c("Stroke","Cancer, Asthma","Hepatitis C","COVID-19"))
  )
})

df <- data.frame(sig_cond = c("Stroke","Cancer, Asthma","Hepatitis C","COVID-19"))

test_that("remove HIV, abbr and full", {
  expect_equal(
    suppressMessages(df %>% hiv_redact()),
    data.frame(sig_cond = c("Stroke","Cancer, Asthma","Hepatitis C","COVID-19"))
  )
})
