# Clean patient/record address

Recode common address issues such as cardinal directions and street
names, and removes extra location information such as unit or apartment
number.

## Usage

``` r
clean_address(address_var, keep_extra = TRUE)
```

## Arguments

- address_var:

  Address variable.

- keep_extra:

  Defaults to TRUE. Option to keep/remove extra address components (e.g.
  Apartment, Unit, Space).

## Value

Address as character.

## Examples

``` r
x = "1234 N Main St Apt 405"
clean_address(x, keep_extra = TRUE)
#> [1] "1234 North Main Street Apartment 405"
clean_address(x, keep_extra = FALSE)
#> [1] "1234 North Main Street"
```
