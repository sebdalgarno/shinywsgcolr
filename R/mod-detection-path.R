#' @title   Detection path
#' @description  A shiny module for visualizing detection paths.
#' @inheritParams params
#'
#' @rdname mod_detection_path
#' @keywords internal
mod_detection_path_ui <- function(id, sex, weight, forklength) {
  ns <- NS(id)

  div(
    id = ns("card_tab"),
    fluidRow(
      bs4Dash::box(
        width = 4, title = "Which fish do you want to see?",
        checkboxGroupInput(ns("sex"), label = "Select sex",
                           choices = sex, selected = sex, inline = TRUE),
        sliderInput(ns("forklength"), label = "Select fork length (cm) range",
                    min = forklength[1], max = forklength[2], value = c(200, forklength[2])),
        sliderInput(ns("weight"), label = "Select weight (kg) range",
                    min = weight[1], max = weight[2], value = c(70, weight[2])),
        uiOutput(ns("ui_picker"))
      ),
      bs4Dash::box(
        width = 8, title = "Detection Path",
        shiny::helpText("Detection paths are shown as lines. Coloured points mark the beginning and end of a path or movement to a new array.
        A path ends if a fish has not been detected for more than `max_absence` time."),
        br(),
        br(),
        shinycssloaders::withSpinner(uiOutput(ns("ui_plots")))
      )
    )
  )
}

#'
#' @rdname mod_detection_path
mod_detection_path_server <- function(id, detection_event, deployment, fish,
                                      reference_rkm, lims_x, lims_y) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    transmitters <- reactive({
      filter_fish(fish, input$forklength, input$weight, input$sex)$transmitter_id %>% sort()
    })

    detection_data <- reactive({
      req(input$transmitter)
      lapply(input$transmitter, function(x) {
        detection_event %>%
          dplyr::filter(transmitter_id == x) %>%
          dplyr::left_join(fish, "transmitter_id")
      })
    })

    create_ui <- function(data) {
      p <-  wsgcolr::plot_detection_path(detection_event = data,
                                         deployment = deployment,
                                         receiver_group = "array",
                                         receiver_group_rkm = "array_rkm",
                                         reference_rkm = reference_rkm,
                                         lims_x = lims_x, lims_y = lims_y) +
        theme(axis.text = element_text(size = 14),
              axis.title = element_text(size = 14)) +
        theme_bw() +
        ggplot2::labs(title = glue("{data$transmitter_id}"),
                      subtitle = glue("Fork Length (cm): {data$forklength_cm}; Weight (kg): {data$weight_kg}; Sex: {data$sex}"))
      renderPlot(p)
    }

    output$ui_plots <- renderUI({
      pd <- req(detection_data())
      tagList(lapply(
        pd, function(x){
          create_ui(x)
        }
      ))
    })

    output$ui_picker <- renderUI({
      req(transmitters())
      shinyWidgets::pickerInput(ns("transmitter"), label = "Select transmitter(s)",
                  choices = transmitters(),
                  selected = transmitters(),
                  multiple = TRUE)
    })
  }
  )
}

