# Calculate Incidence Rate per 100,000

Calculate incidence rate using your own population denominator.

## Usage

``` r
rate_per_100k(n, pop, digits = 1)
```

## Arguments

- n:

  Number of cases.

- pop:

  Population denominator.

- digits:

  Number of digits to round rate.

## Value

Crude rate per 100,000.

## Examples

``` r
rate_per_100k(5, 320000, digits = 1)
#> [1] 1.6
```
