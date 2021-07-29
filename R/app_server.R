#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  detection_summary <- getShinyOption("detection_summary", NULL)
  detection_event <- getShinyOption("detection_event", NULL)
  detection_complete <- getShinyOption("detection_complete", NULL)
  deployment <- getShinyOption("deployment", NULL)
  station <- getShinyOption("station", NULL)
  river <- getShinyOption("river", NULL)
  fish <- getShinyOption("fish", NULL)
  reference_rkm <- getShinyOption("reference_rkm", NULL)
  receiver_group <- getShinyOption("receiver_group", NULL)

  lims_x = c(min(deployment$date_deployment), max(deployment$date_last_download))
  lims_y = c(0, 56)

  mod_deployment_server("deployment_ui",
                        detection = detection_summary,
                        deployment = deployment,
                        station = station,
                        river = river)

  mod_detection_path_server("detection_path_ui",
                            detection_event = detection_event,
                            deployment = deployment,
                            fish = fish,
                            reference_rkm = reference_rkm,
                            lims_x = lims_x, lims_y = lims_y)

  mod_detection_ratio_server("detection_ratio_ui",
                             fish = fish,
                             detection_complete = detection_complete,
                             receiver_group = receiver_group)

}
