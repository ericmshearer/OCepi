# Date to Month Date

Recode date to standard month date for dashboards or ggplots2.

## Usage

``` r
to_month(date)
```

## Arguments

- date:

  Input date.

## Value

Date in YYYY-MM-01 format.

## Examples

``` r
patient_encounter = as.Date("2020-01-14")
to_month(patient_encounter)
#> [1] "2020-01-01"
```
