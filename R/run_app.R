#' Run the Shiny Application
#'
#' @param fish A tibble of fish data containing columns 'transmitter_id', 'sex', 'forklength_cm', 'weight_kg'.
#' @param receiver_group_rkm A tibble of the receiver group locations with columns 'rkm' and the receiver_group column name.
#' @inheritParams wsgcolr::params
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  detection = readRDS(system.file("extdata/detection.rds", package = "shinywsgcolr")),
  deployment = readRDS(system.file("extdata/deployment.rds", package = "shinywsgcolr")),
  fish = readRDS(system.file("extdata/fish.rds", package = "shinywsgcolr")),
  station = readRDS(system.file("extdata/station.rds", package = "shinywsgcolr")),
  receiver_group_rkm = readRDS(system.file("extdata/receiver_group_rkm.rds", package = "shinywsgcolr")),
  reference_rkm = readRDS(system.file("extdata/reference_rkm.rds", package = "shinywsgcolr")),
  river = readRDS(system.file("extdata/river.rds", package = "shinywsgcolr")),
  timestep = "day",
  receiver_group = "array",
  max_absence = 96
) {
  wsgcolr::chk_deployment(deployment)
  wsgcolr::chk_detection(detection)
  wsgcolr::chk_river(river)
  wsgcolr::chk_station(station)
  wsgcolr::chk_reference_rkm(reference_rkm)
  chk_is(fish, "tbl")
  check_names(fish, names = c("transmitter_id", "sex", "forklength_cm", "weight_kg"))
  chk_string(receiver_group)
  chk_whole_number(max_absence)
  wsgcolr::chk_timestep(timestep)

  message("creating detection timestep data...")
  detection_timestep <- wsgcolr::detection_timestep(detection,
                                                    timestep = timestep,
                                                    receiver_group =  receiver_group)
  message("creating detection summary data...")
  detection_summary <- wsgcolr::detection_timestep(detection, timestep = "day", receiver_group =  "station_id")

  message("creating detection events...")
  detection_event <- wsgcolr::detection_event(detection_timestep) %>%
    dplyr::left_join(receiver_group_rkm, by = receiver_group)

  message("creating complete detection data...")
  detection_complete <- wsgcolr::detection_complete(detection_timestep,
                                                    timestep = timestep,
                                                    receiver_group = receiver_group)

  shinyOptions(
    detection_summary = detection_summary,
    detection_event = detection_event,
    detection_complete = detection_complete,
    deployment = deployment,
    station = station,
    river = river,
    reference_rkm = reference_rkm,
    fish = fish,
    receiver_group = receiver_group
  )

  shinyApp(
    ui = app_ui,
    server = app_server
  )

}
