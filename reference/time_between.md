# Calculate Time Between Two Dates

Calculate the elapsed time between two dates in a specified unit of
time. Order of dates within does not necessarily matter, but order will
dictate sign of returned output.

## Usage

``` r
time_between(date2, date1, unit = c("days", "weeks", "months", "years"))
```

## Arguments

- date2:

  More recent date.

- date1:

  Older date or date further in the past.

- unit:

  Specify if returned time is in days, weeks, months, or years.

## Value

Time interval in specified units.

## Examples

``` r
date2 = as.POSIXlt("2023-02-08 00:10:00 PST")
date1 = as.POSIXlt("1986-01-08 22:00:00 PST")

time_between(date2, date1, unit = "days")
#> [1] 13544
```
