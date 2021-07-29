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
        shinycssloaders::withSpinner(plotOutput(ns("plot_deployment"), height = 600))
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

    output$plot_deployment <- renderPlot({
      wsgcolr::plot_deployment(station = station,
                               river = river,
                               deployment = deployment,
                               detection = detection) +
        theme(axis.text = element_text(size = 14),
              axis.title = element_text(size = 14),
              legend.text = element_text(size = 14))
    })
  }
  )
}

