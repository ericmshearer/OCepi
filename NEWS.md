# OCepi 0.1.0.9000 - unreleased development

### New Features

-   Added suppression option to `OCepi::n_percent(n, percent, reverse = FALSE, n_suppress = NULL)`.
-   Testing map orientation for `OCepi::theme_apollo(direction = "map")`.
-   Shapefiles `OCepi::oc_zip_sf` and `OCepi::oc_city_sf` now available for spatial analysis.
-   Building terms/codes for `OCepi::pos()` and `OCepi::neg()` when recoding electronic laboratory results.

### Bug Fixes

-   Fixed bug in `OCepi::add_percent()` where small proportions less than one were not being recoded to "\<1%".
-   Aligned majority `OCepi::highlight_geom()` and `OCepi::desaturate_geom()` to share same core structure but deviate at fading and desaturating.
-   Enhanced `OCepi::wrap_labels()` so that long categories (e.g. race/ethnicity) with backslash wrap nicer.

# OCepi 0.1.0 (2023-09-15)

-   Initial release!
