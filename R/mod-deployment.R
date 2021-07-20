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

  instructions <- bs4Dash::box(
    title = helper(div(HTML(
      glue("Download resource &nbsp &nbsp &nbsp")
    )),
    content = "instructions_dl"
    ),
    br(),
    helper(tags$label("1. Select resource"), content = "select_card"),
    uiOutput(ns("ui_file_select")),
    helper(tags$label("2. Download"), content = "fieldcard_dl"),
    dl_button(ns("dl_button"), "PDF")
  )

  div(
    id = ns("card_tab"),
    fluidRow(
      bs4Dash::box(
        width = 12, title = helper(div(HTML(
          glue("Spatial and temporal receiver deployment")
        )),
        content = "instructions_dl"
        ),
        br(),
        plotOutput(ns("plot_deployment"), inline = TRUE)
      )
    )
  )
}

#'
#' @rdname mod_detection_path
#' @export
mod_deployment_server <- function(id, detection, deployment, station, river) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    output$plot_deployment <- renderPlot(width = 1000, height = 600, {
      wsgcolr::plot_receiver_coverage(station = station, river = river,
                                      deployment = deployment, detection = detection)
    })
    }
  )
}

