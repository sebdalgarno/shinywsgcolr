#' @title   PDF Download Module
#' @description  A shiny module for downloading field data cards. Select and
#' download resources needed for the project like field cards.
#' @inheritParams params
#'
#' @rdname mod_detection_path
#' @export
#' @keywords internal
mod_detection_path_ui <- function(id) {
  ns <- NS(id)

  div(
    id = ns("card_tab"),
    fluidRow(
      bs4Dash::box(
        width = 12, title = "Detection Path",
        plotOutput(ns("plot_detection_path"), inline = TRUE),
        br(),
        shiny::helpText("A detection path is defined as continuous movement in which detections are no more than 4 days apart. ")
      )
    )
  )
}

#'
#' @rdname mod_detection_path
#' @export
mod_detection_path_server <- function(id, detection_path, deployment,
                                      reference_locations, lims_x, lims_y) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    output$plot_detection_path <- renderPlot(width = 1000, height = 600, {
      wsgcolr::plot_detection_path(detection_path = detection_path,
                                      deployment = deployment,
                                   reference_locations = reference_locations,
                                   lims_x = lims_x, lims_y = lims_y,
                                   text_size = 12)
    })
  }
  )
}

