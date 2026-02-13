# Date to Quarter

Recode date to calendar or fiscal quarter.

## Usage

``` r
to_quarter(x, fiscal = FALSE)
```

## Arguments

- x:

  Input date.

- fiscal:

  Boolean, TRUE returns fiscal quarter.

## Value

Character in format YYYY-Q0#.

## Examples

``` r
to_quarter(Sys.Date())
#> [1] "2026-Q01"
to_quarter(Sys.Date(), fiscal = TRUE)
#> [1] "2026-Q03"
```
