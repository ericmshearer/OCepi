# Assign Respiratory Season

Calculate respiratory season based on laboratory or episode date.
Respiratory season is defined as week 40 through week 39.

## Usage

``` r
assign_season(date)
```

## Arguments

- date:

  Input date.

## Value

Character in format YYYY-YY.

## Examples

``` r
x = as.Date("2023-10-01")
assign_season(x)
#> [1] "2023-24"
```
