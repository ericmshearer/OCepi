# Algorithm for Death Certificate Inclusion

Standardized method to determine if death belongs to local health
jurisdiction.

## Usage

``` r
vrbis_resident(
  death_location,
  county_of_death,
  county_fips,
  fips = "059",
  county_code = "30"
)
```

## Arguments

- death_location:

  Expects "Place of Death (Facility)" column from VRBIS dataset.

- county_of_death:

  Expects "County of Death (Code)" column.

- county_fips:

  Expects "Decedents County of Residence (NCHS Code)" column.

- fips:

  County fips code of local health jurisdiction.

- county_code:

  State county code per Appendix G of CCDF data dictionary.

## Value

0/1, with 1 indicating death belongs to local health jurisdiction.
