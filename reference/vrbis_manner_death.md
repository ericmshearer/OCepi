# Recode VRBIS Manner of Death

Convert single letter to full responses per CCDF data dictionary.

## Usage

``` r
vrbis_manner_death(col)
```

## Arguments

- col:

  Expects "Manner of Death" column from VRBIS dataset.

## Value

Recoded response as character.

## Examples

``` r
vrbis_manner_death("A")
#> [1] "Accident"
vrbis_manner_death(NA)
#> [1] "Not specified"
```
