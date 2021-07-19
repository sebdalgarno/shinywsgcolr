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
    width = 12, title = helper(div(HTML(
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
      column(width = 4, ""),
      column(width = 8, "If you are unable to preview the file, try a different
             browser. It may take a few seconds to load.")
    ),
    fluidRow(
      column(width = 4, instructions),
      column(width = 8, uiOutput(ns("ui_select")))
    )
  )
}

#'
#' @rdname mod_detection_path
#' @export
mod_deployment_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns
    shinyhelper::observe_helpers(
      help_dir = system.file("helpfiles", package = "shinyupload2")
    )
    card_location <- paste0(getwd(), "/www/pdfs/")

    output$ui_file_select <- renderUI({
      card_names <- list.files(card_location)

      selectInput(ns("select_card"),
                  label = NULL,
                  choices = card_names
      )
    })

    # this displays the selected file
    output$ui_select <- renderUI({
      req(input$select_card)
      addResourcePath("pdfs", "www/pdfs")
      card_name <- paste0("pdfs/", input$select_card)
      tags$iframe(style = "height:600px; width:100%", src = card_name)
    })

    output$dl_button <- downloadHandler(
      filename = function() paste0(input$select_card),
      content = function(file) {
        file_loc <- paste0(card_location, input$select_card, collapse = NULL)
        file.copy(file_loc, file)
      })
  }
  )
}

