# Read in Metadata from REDCap Project

This method allows you to read in the metadata for a project. To use
this method, you must have API Export privileges in the project. If
you're starting a new project and want to bulk upload records, you
return = "template" to get a blank data.frame to populate. Otherwise,
set return = "dictionary" to see all specs about project. You can send
this dictionary to others to upload into their instance of REDCap.

## Usage

``` r
redcap_metadata(
  url,
  token,
  return = c("dictionary", "template"),
  repeating_instrument = FALSE
)
```

## Arguments

- url:

  Character, API url.

- token:

  Character, token from project.

- return:

  Character, dictionary or template. If bulk uploading new records, use
  template.

- repeating_instrument:

  Boolean, adds two additional columns (redcap_repeat_instrument,
  redcap_repeat_instance) to template option.

## Value

Data.frame
