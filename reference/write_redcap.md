# Write New or Modified Data to REDCap Project

This method allows you to upload/write a set of records for a project.
To use this method, you must have API Export privileges in the project.

## Usage

``` r
write_redcap(df, url, token, forceAutoNumber = FALSE)
```

## Arguments

- df:

  Data.frame to write back to REDCap.

- url:

  Character, API url.

- token:

  Character, token from project.

- forceAutoNumber:

  Logical, if TRUE new record ids will be automatically determined.

## Value

Success or warning message, no data returned.
