# Match ID \#4 - Partial Name, DOB

Match ID for linking disparate datasets using parts of identifiers.

## Usage

``` r
match_id_4(first_name, last_name, dob)
```

## Arguments

- first_name:

  First 4 characters of string

- last_name:

  First 4 characters of string

- dob:

  Date

## Value

Match id using part of name and date of birth.

## Examples

``` r
match_id_4("Mickey","Mouse","1955-07-17")
#> [1] "MICKMOUS1955-07-17"
```
