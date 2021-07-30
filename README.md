
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinywsgcolr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

A Shiny app for visualizing Columbia River White Sturgeon acoustic
telemetry and capture-recapture data. The app uses functions in the
`wsgcolr` package.

## Installation

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("sebdalgarno/shinywsgcolr")
```

# Example

You need to use the `wsgcolr` R package to create detection datasets
required by the app and passed into `shinywsgcolr::run_app()`:

``` r
# create detection_station object used in deployment plot
detection_station <- wsgcolr::detection_timestep(detection, "day", "station_id")

# create detection_event used for detection path plots
detection_daily <- wsgcolr::detection_timestep(detection, timestep = "day", receiver_group =  "array")

receiver_group_rkm <- station %>%
  select(array, array_rkm) %>%
  distinct()
  
detection_event <- wsgcolr::detection_event(detection_daily) %>%
  dplyr::left_join(receiver_group_rkm, by = "array")
  
# create detection_complete used to calculate detection ratios
detection_complete <- wsgcolr::detection_complete(detection_daily,
                                                  timestep = "day", "array")
                                                  
```
