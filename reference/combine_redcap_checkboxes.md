# Unite Checkbox Variables in REDCap

While useful for data collection, checkbox variables may need to be
merged/united into a singular variable for analysis. REDCap internally
labels checkbox variables are "prefix\_\_\_1", with the number matchin
the number response in the checkbox variable. Warning: if REDCap ever
changes this format, this function will stop working.

## Usage

``` r
combine_redcap_checkboxes(df, prefix = NULL, sep = ", ", drop_cols = FALSE)
```

## Arguments

- df:

  Data.frame or tibble.

- prefix:

  Character, prefix of checkbox variable to be combined. If left blank
  or unspecified, all checkbox variables will be impacted.

- sep:

  Character, delimiter to separate multiple values.

- drop_cols:

  Logical, option to drop united columns after transformation. Default
  set to FALSE.

## Value

Data.frame or tibble with united colums using prefix.
