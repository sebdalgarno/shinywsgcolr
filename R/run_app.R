#' Run the Shiny Application
#'
#' @param fish A tibble of fish data containing columns 'transmitter_id', 'sex', 'forklength_cm', 'weight_kg'.
#' @param receiver_group_rkm A string of the column name indicating receiver_group rkm.
#' @param detection_station A tibble of detection station data returned from `wsgcolr::detection_timestep()` with `receiver_group` of `station_id`. Mandatory columns include 'transmitter_id', 'timestep', and 'station_id'.
#' @inheritParams wsgcolr::params
#'
#' @export
#' @importFrom shiny shinyApp
run_app <- function(
  detection_station = readRDS(system.file("extdata/detection_station.rds", package = "shinywsgcolr")),
  detection_event = readRDS(system.file("extdata/detection_event.rds", package = "shinywsgcolr")),
  detection_complete = readRDS(system.file("extdata/detection_complete.rds", package = "shinywsgcolr")),
  deployment = readRDS(system.file("extdata/deployment.rds", package = "shinywsgcolr")),
  fish = readRDS(system.file("extdata/fish.rds", package = "shinywsgcolr")),
  station = readRDS(system.file("extdata/station.rds", package = "shinywsgcolr")),
  reference_rkm = readRDS(system.file("extdata/reference_rkm.rds", package = "shinywsgcolr")),
  river = readRDS(system.file("extdata/river.rds", package = "shinywsgcolr")),
  timestep = "day",
  receiver_group = "array",
  receiver_group_rkm = "array_rkm"
) {
  wsgcolr::chk_deployment(deployment)
  wsgcolr::chk_detection_timestep(detection_station)
  wsgcolr::chk_detection_event(detection_event)
  wsgcolr::chk_detection_complete(detection_complete)
  wsgcolr::chk_river(river)
  wsgcolr::chk_station(station)
  wsgcolr::chk_reference_rkm(reference_rkm)
  chk_is(fish, "tbl")
  check_names(fish, names = c("transmitter_id", "sex", "forklength_cm", "weight_kg"))
  chk_string(receiver_group)
  chk_string(receiver_group_rkm)
  wsgcolr::chk_timestep(timestep)

  shinyOptions(
    detection_station = detection_station,
    detection_event = detection_event,
    detection_complete = detection_complete,
    deployment = deployment,
    station = station,
    river = river,
    reference_rkm = reference_rkm,
    fish = fish,
    receiver_group = receiver_group,
    receiver_group_rkm = receiver_group_rkm
  )

  shinyApp(
    ui = app_ui,
    server = app_server
  )
}
