# Match ID \#1 - Partial Name, DOB, Partial Address

Match ID for linking disparate datasets using parts of identifiers. Be
aware of address formatting and consider recoding variable using
clean_address.

## Usage

``` r
match_id_1(first_name, last_name, dob, part_address)
```

## Arguments

- first_name:

  First 4 characters of string

- last_name:

  First 4 characters of string

- dob:

  Date

- part_address:

  First 10 characters of string

## Value

Match id using part of name, date of birth, and the first 10 characters
of the address.

## Examples

``` r
match_id_1("Mickey","Mouse","1955-07-17","1313 Disneyland Dr")
#> [1] "MICKMOUS1955-07-171313 Disne"
```
