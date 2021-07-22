#' @title   PDF Download Module
#' @description  A shiny module for downloading field data cards. Select and
#' download resources needed for the project like field cards.
#' @inheritParams params
#'
#' @rdname mod_deployment
#' @export
#' @keywords internal
mod_deployment_ui <- function(id) {
  ns <- NS(id)

  div(
    id = ns("card_tab"),
    fluidRow(
      bs4Dash::box(
        width = 12, title = "Receiver Coverage",
        plotOutput(ns("plot_deployment"), inline = TRUE),
        br(),
        shiny::helpText("Segments indicate receiver deployments. Color indicates array (i.e., receiver group). Black dots indicate presence of detection data.")
      )
    )
  )
}

#'
#' @rdname mod_deployment
#' @export
mod_deployment_server <- function(id, detection, deployment, station, river) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    output$plot_deployment <- renderPlot(width = 1000, height = 600, {
      wsgcolr::plot_receiver_coverage(station = station, river = river,
                                      deployment = deployment, detection = detection,
                                      text_size = 14)
    })
    }
  )
}

