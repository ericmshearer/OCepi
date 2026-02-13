# Clean Phone Number

Reformat phone number column to 10 digit U.S. format. If international
or invalid phone number (e.g. not 10 digits), returns NA.

## Usage

``` r
clean_phone(x)
```

## Arguments

- x:

  Phone Character or numeric, number variable.

## Value

Character, phone number containing 10 digits if valid.

## Examples

``` r
clean_phone("1-714-834-8180")
#> [1] "7148348180"
```
