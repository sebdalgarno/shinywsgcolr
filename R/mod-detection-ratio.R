#' @title   Detection ratio
#' @description  A shiny module for visualizing absolute and relative detection ratios.
#' @inheritParams params
#'
#' @rdname mod_detection_ratio
#' @export
#' @keywords internal
mod_detection_ratio_ui <- function(id, sex, weight, forklength) {
  ns <- NS(id)

  div(
    id = ns("card_tab"),
    fluidRow(
      bs4Dash::box(
        width = 4, title = "Which fish do you want to include?",
        checkboxGroupInput(ns("sex"), label = "Select sex",
                           choices = sex, selected = c("female", "male"), inline = TRUE),
        sliderInput(ns("forklength"), label = "Select fork length (cm) range",
                    min = forklength[1], max = forklength[2], value = forklength),
        sliderInput(ns("weight"), label = "Select weight (kg) range",
                    min = weight[1], max = weight[2], value = weight),
        uiOutput(ns("ui_picker"))
      ),
      bs4Dash::box(
        width = 8, title = "Detection Ratios",
        shiny::helpText("Absolute and relative detection ratios are calculated for selected fish by receiver group."),
        br(),
        br(),
        shinycssloaders::withSpinner(uiOutput(ns("ui_plots")))

      )
    )
  )
}

#'
#' @rdname mod_detection_path
#' @export
mod_detection_ratio_server <- function(id, detection_complete, fish, receiver_group) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    transmitters <- reactive({
      filter_fish(fish, input$forklength, input$weight, input$sex)$transmitter_id %>% sort()
    })

    detection_data <- reactive({
      req(input$transmitter)
      detection_complete %>%
        filter(transmitter_id %in% input$transmitter) %>%
        wsgcolr::detection_ratio(receiver_group = receiver_group)
    })

    create_ui <- function(data, receiver_group, relative) {
      if(relative){
        p <- wsgcolr::plot_detection_ratio_relative(detection = data,
                                                    receiver_group = receiver_group)
      } else {
        p <- wsgcolr::plot_detection_ratio_absolute(detection = data,
                                                    receiver_group = receiver_group)
      }
      renderPlot(p)
    }

    output$ui_plots <- renderUI({
      x <- req(detection_data())
      tagList(list(create_ui(x, receiver_group = receiver_group, relative = TRUE),
                   create_ui(x, receiver_group = receiver_group, relative = FALSE)))
    })

    output$ui_picker <- renderUI({
      req(transmitters())
      shinyWidgets::pickerInput(ns("transmitter"), label = "Select transmitter(s)",
                  choices = transmitters(),
                  selected = transmitters(),
                  multiple = TRUE)
    })
  })
}

