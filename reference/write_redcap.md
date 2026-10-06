# Write New or Modified Data to REDCap Project

This method allows you to upload/write a set of records for a project.
To use this method, you must have API Export privileges in the project.

## Usage

``` r
write_redcap(
  df,
  url,
  token,
  forceAutoNumber = FALSE,
  batch = FALSE,
  batch_delay = 0.5
)
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

- batch:

  Logical, TRUE if uploading large volumes of data.

- batch_delay:

  Numeric, time delay between batches when batch uploading.

## Value

Success or warning message, no data returned.
