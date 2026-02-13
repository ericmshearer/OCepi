# Plot Labels for Counts & Proportion

Standardized plot labels with options for ordering.

## Usage

``` r
n_percent(n, percent, reverse = FALSE, n_suppress = NULL)
```

## Arguments

- n:

  Counts variable.

- percent:

  Proportion variable.

- reverse:

  Default set to false. Order switched to percent n if FALSE.

- n_suppress:

  Maximum value for suppression. Returns double asterisk.

## Value

Plot label as character.

## Examples

``` r
n_percent(5, 25)
#> [1] "5 (25%)"
n_percent(5, 25, reverse = TRUE)
#> [1] "25% (5)"
```
