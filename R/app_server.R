#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic

  detection <- getShinyOption("detection", NULL)
  detection_path <- getShinyOption("detection_paths", NULL)
  deployment <- getShinyOption("deployment", NULL)
  station <- getShinyOption("station", NULL)
  river <- getShinyOption("river", NULL)
  reference_locations <- getShinyOption("reference_locations", NULL)


  mod_deployment_server("deployment_ui",
                        detection = detection, deployment = deployment,
                        station = station, river = river)

}
