# OCepi 0.3.4 (2025-09-09)

### Bug Fixes

-   `OCepi::clean_phone()` now mirrors internal REDCap validation for standard US phone numbers, including N11 codes.

# OCepi 0.3.3 (2025-07-17)

### Enhancement

-   Add missing API features to `OCepi::write_redcap()`
-   Simplify API arguments in `OCepi::read_readcap()`
-   Add ability to pull metadata (data dictionary or blank template) via `OCepi::redcap_metadata()`.

# OCepi 0.3.2 (2025-06-11)

### Enhancement

-   Darker grid lines when using `OCepi::theme_apollo()`.

# OCepi 0.3.1 (2025-04-11)

### Bug Fixes

-   Resolved issue in `OCepi::dashboard_tbl()` when grouping by a variable.

# OCepi 0.3.0 (2025-03-31)

### New Features

-   Added `OCepi::dashboard_tbl()` to more efficiently summarize data across columns in preparation for dashboard reporting.
-   Added experimental functions for REDCap to import/write data from project.

# OCepi 0.2.1 (2024-11-01)

### Breaking Changes

-   `OCepi::wrap_labels()` now has argument `delim` so user can set what string or symbol to wrap the text at (thanks Jen).
-   `OCepi::theme_apollo()` has more flexibility in setting legend position via `legend` argument: top, right, bottom, left, or none.

### New Features

-   Added `OCepi::to_quarter(x, fiscal = FALSE)` to convert dates to quarter or fiscal quarter (July 1 to June 30).
-   Additional argument `add_in` now available in `OCepi::pos()` and `OCepi::neg()`. Useful for adding additional lab results on the fly when recoding.

# OCepi 0.2.0 (2024-09-27)

### New Features

-   Added suppression option to `OCepi::n_percent(n, percent, reverse = FALSE, n_suppress = NULL)`.
-   Added map orientation for `OCepi::theme_apollo(direction = "map")`.
-   Shapefiles `OCepi::oc_zip_sf` and `OCepi::oc_city_sf` now available for spatial analysis.
-   Building terms/codes for `OCepi::pos()` and `OCepi::neg()` when recoding electronic laboratory results.

### Bug Fixes

-   Fixed bug in `OCepi::add_percent()` where small proportions less than one were not being recoded to "\<1%".
-   Aligned majority `OCepi::highlight_geom()` and `OCepi::desaturate_geom()` to share same core structure but deviate at fading and desaturating.
-   Enhanced `OCepi::wrap_labels()` to wrap text at forward slash. If label contains "or", it is replaced by forward slash then wrapped.

# OCepi 0.1.0.9000 - unreleased development

# OCepi 0.1.0 (2023-09-15)

-   Initial release!
