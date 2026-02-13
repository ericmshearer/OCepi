# Redact HIV/AIDS from Dataframe

Remove iterations of HIV and/or AIDS from dataframe.

## Usage

``` r
hiv_redact(df)
```

## Arguments

- df:

  Dataframe to scan.

## Value

Dataframe with HIV and/or AIDS removed.

## Examples

``` r
df <- data.frame(cause = c("cancer","hepatitis","COVID-19","HIV"))
hiv_redact(df)
#> Warning: HIV/AIDS data detected.
#>       cause
#> 1    cancer
#> 2 hepatitis
#> 3  COVID-19
#> 4          
```
