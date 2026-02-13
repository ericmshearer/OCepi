# Match ID \#3 - Partial Name, DOB, Phone Number

Match ID for linking disparate datasets using parts of identifiers. Be
aware of phone number formatting and consider recoding variable using
clean_phone.

## Usage

``` r
match_id_3(first_name, last_name, dob, phone_number)
```

## Arguments

- first_name:

  First 4 characters of string

- last_name:

  First 4 characters of string

- dob:

  Date

- phone_number:

  String or Numeric

## Value

Match id using part of name, date of birth, and phone number.

## Examples

``` r
match_id_3("Mickey","Mouse","1955-07-17","7147814636")
#> [1] "MICKMOUS1955-07-177147814636"
```
