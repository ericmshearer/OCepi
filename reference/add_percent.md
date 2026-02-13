# Add Proportion

Calculate percentage per category with options to round and multiply by
100.

## Usage

``` r
add_percent(n, digits = 2, multiply = TRUE)
```

## Arguments

- n:

  Count/frequency variable.

- digits:

  Number of digits to round.

- multiply:

  Default set to TRUE. To keep as fraction set to FALSE.

## Value

Proportion.

## Examples

``` r
df <- data.frame(species = c("Droid","Human","Wookie"), n = c(3,12,1))
df$percent <- add_percent(df$n)
df
#>   species  n percent
#> 1   Droid  3   18.75
#> 2   Human 12   75.00
#> 3  Wookie  1    6.25
```
