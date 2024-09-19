# OCepi 0.1.0.9000 - unreleased development

------------------------------------------------------------------------

### New Features

-   Added suppression option to `OCepi::n_percent`.
-   Testing map orientation for `OCepi::theme_apollo`.
-   Shapefiles `OCepi::oc_zip_sf` and `OCepi::oc_city_sf` now available for spatial analysis.
-   Building terms/codes for `OCepi::pos()` and `OCepi::neg()` when recoding electronic laboratory results.

### Bug Fixes

-   Fixed bug in `OCepi::add_percent` where small proportions less than one were not being recoded to "\<1%".
-   Aligned majority `OCepi::highlight_geom` and `OCepi::desaturate_geom` to share same core structure but deviate at fading and desaturating.

# OCepi 0.1.0 (2023-09-15)

------------------------------------------------------------------------

-   Initial release!
-   I foolishly did not document all the changes between initial and dev version 0.1.0.9000 - sorry!
