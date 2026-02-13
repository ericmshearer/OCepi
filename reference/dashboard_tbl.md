# Aggregate Data for Dashboard Reporting

Summarize data across columns in preparation for dashboard reporting.

## Usage

``` r
dashboard_tbl(
  data,
  group_by = NULL,
  reverse = TRUE,
  digits = 1,
  n_suppress = NULL
)
```

## Arguments

- data:

  Input dataframe containing only those columns that need to be
  summarized.

- group_by:

  To be used if summarizing data over multiple years or groups.

- reverse:

  Sets order of n and percent in label.

- digits:

  Number of digits to round proportion.

- n_suppress:

  Suppress values less than specified value.

## Value

Dataframe with n, proportion, and label.
