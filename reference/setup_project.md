# Setup R Project

Spend less time thinking about how to setup R project directories. If
not currently working within a R Project, function will return an error.

## Usage

``` r
setup_project(subs = c("R", "data", "output"), read_me = FALSE)
```

## Arguments

- subs:

  Character, vector of sub-directories to create if not already present.

- read_me:

  Boolean to indicate if you want to use built-in OCepi Rmd template.

## Value

Three sub-directories and READme.
