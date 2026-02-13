# Delete a Record in REDCap

This method allows you to delete one or more records from a project, and
also optionally allows you to delete parts of records such as specific
instruments and/or repeating instances.

## Usage

``` r
delete_redcap_record(
  url,
  token,
  record_id,
  instrument = NULL,
  repeat_instance = NULL
)
```

## Arguments

- url:

  Character, API url.

- token:

  Character, token from project.

- record_id:

  Numeric, single or vector of record id's.

- instrument:

  Character, name of instrument that contains data you wish to delete.
  Optional.

- repeat_instance:

  Character, repeating instance number that contains data you wish to
  delete. Optional.

## Value

Number of records deleted or (if instrument or repeating instance is
provided) the number of items deleted over the total records specified.
