test_that("basic use", {

  df <- data.frame(Date = as.Date(c("2023-01-01","2023-02-01")), scores = c(88,84))
  rownames(df) <- as.character(rownames(df))

  expect_equal(
    end_points(df, Date),
    data.frame(Date = c(as.Date("2023-02-01")), scores = c(84))
    )
})

test_that("different end points", {

  ts = seq.Date(from = as.Date("2024-01-01"), to = as.Date("2024-01-04"), by = "day")

  df <- data.frame(
    Date = rep(ts, 2),
    Group = c(rep("A", 4), rep("B", 4)),
    scores = c(88,84,91,83,88,84,91,NA)
    )

  expect_equal(
    end_points(df, Date, Group),
    data.frame(Date = as.Date(c("2024-01-04","2024-01-03")), Group = c("A","B"), scores = c(83,91), row.names = c(1L,2L))
    )
})
