#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic

  detection <- getShinyOption("detection", NULL)
  detection_path <- getShinyOption("detection_path", NULL)
  deployment <- getShinyOption("deployment", NULL)
  station <- getShinyOption("station", NULL)
  river <- getShinyOption("river", NULL)
  reference_locations <- getShinyOption("reference_locations", NULL)
  lims_x = c(min(deployment$date_deployment), max(deployment$date_last_download))
  lims_y = c(0, 56)

  mod_deployment_server("deployment_ui",
                        detection = detection, deployment = deployment,
                        station = station, river = river)

  mod_detection_path_server("detection_path_ui",
                        detection_path = detection_path,
                        deployment = deployment,
                        reference_locations = reference_locations,
                        lims_x = lims_x, lims_y = lims_y)

}
