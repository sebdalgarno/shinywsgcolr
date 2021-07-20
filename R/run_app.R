#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts.
#' See `?golem::get_golem_options` for more details.
#' @inheritParams wsgcolr::params
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  detection = NULL,
  detection_path = NULL,
  deployment = NULL,
  station = NULL,
  river = NULL,
  reference_locations = NULL,
  ...
) {
  wsgcolr::chk_deployment(deployment)
  wsgcolr::chk_detection(detection)
  # wsgcolr::chk_detection_path(detection_path)
  # wsgcolr::chk_river(river)
  # wsgcolr::chk_station(station)
  # wsgcolr::chk_reference_locations(reference_locations)

  shinyOptions(
    detection = detection,
    deployment = deployment,
    detection_path = detection_path,
    station = station,
    river = river,
    reference_locations = reference_locations
  )

  shinyApp(
    ui = app_ui,
    server = app_server
    # onStart = onStart,
    # options = options,
    # enableBookmarking = enableBookmarking
  )

  # with_golem_options(
  #   app = shinyApp(
  #     ui = app_ui,
  #     server = app_server,
  #     onStart = onStart,
  #     options = options,
  #     enableBookmarking = enableBookmarking
  #   ),
  #   golem_opts = list(...)
  # )
}
