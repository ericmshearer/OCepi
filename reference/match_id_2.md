# Match ID \#2 - Partial Name, DOB, Full Address

Match ID for linking disparate datasets using parts of identifiers.

## Usage

``` r
match_id_2(first_name, last_name, dob, address)
```

## Arguments

- first_name:

  First 4 characters of string

- last_name:

  First 4 characters of string

- dob:

  Date

- address:

  Full address

## Value

Match id using part of name, date of birth, and full address.

## Examples

``` r
match_id_2("Mickey","Mouse","1955-07-17","1313 Disneyland Dr")
#> [1] "MICKMOUS1955-07-171313 Disneyland Dr"
```
