# Recode Gender/Sex in CalREDIE

Made specifically for CaLREDIE UDF data export. Recode abbreviations to
full names.

## Usage

``` r
recode_gender(col)
```

## Arguments

- col:

  Input column from CalREDIE.

## Value

Recoded input column as character.

## Examples

``` r
example = c("F","F","TF",NA)
recode_gender(example)
#> [1] "Female"            "Female"            "Transgender woman"
#> [4] "Missing/Unknown"  
```
