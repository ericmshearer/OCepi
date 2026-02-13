# Read in Data from REDCap Project

This method allows you to import/read in a set of records for a project.
To use this method, you must have API Import/Update privileges in the
project. Please be aware that Data Export user rights will be applied to
this API request. For example, if you have 'No Access' data export
rights in the project, then the API data export will fail and return an
error. And if you have 'De-Identified' or 'Remove All Identifier Fields'
data export rights, then some data fields \*might\* be removed and
filtered out of the data set returned from the API. To make sure that no
data is unnecessarily filtered out of your API request, you should have
'Full Data Set' export rights in the project.

## Usage

``` r
read_redcap(
  url,
  token,
  raw = TRUE,
  exportCheckboxLabel = FALSE,
  exportSurveyFields = FALSE
)
```

## Arguments

- url:

  Character, API url.

- token:

  Character, token from project.

- raw:

  Logical, export the raw coded values or labels for the options of
  multiple choice fields.

- exportCheckboxLabel:

  Logical, export the checkbox value as the checkbox option's label
  (e.g., 'Choice 1').

- exportSurveyFields:

  Logical, export the survey identifier field (e.g.,
  'redcap_survey_identifier') or survey timestamp fields (e.g.,
  instrument+'\_timestamp') when surveys are utilized in the project.

## Value

Data.frame with project data.
