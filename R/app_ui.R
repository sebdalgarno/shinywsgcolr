#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  fish <- getShinyOption("fish", NULL)
  sex <- unique(fish$sex)
  forklength <- range(fish$forklength_cm)
  weight <- range(fish$weight_kg)

  title <- bs4Dash::dashboardBrand(
    title = "",
    color = "primary",
    href = "https://www.ffishlab.ca/",
    image = ""
  )

  bs4Dash::dashboardPage(
    fullscreen = TRUE,
    dark = NULL,
    scrollToTop = TRUE,
    title = "Columbia River White Sturgeon",
    header = bs4Dash::dashboardHeader(
      ... = div(h3("Columbia River White Sturgeon"), style = "vertical-align: baseline;"),
      title = title,
      skin = "light",
      status = "white",
      border = TRUE,
      sidebarIcon = icon("bars"),
      controlbarIcon = icon("th"),
      fixed = FALSE
    ),
    sidebar = bs4Dash::dashboardSidebar(
      skin = "light",
      elevation = 3,
      id = "sidebarmenu",
      status = "primary",
      sidebarMenu(
        sidebarHeader("Acoustic Telemetry"),
        menuItem(
          "Deployments",
          tabName = "deployment",
          icon = icon("id-card")
        ),
        menuItem(
          "Detection Paths",
          tabName = "detection_path",
          icon = icon("map")
        ),
        menuItem(
          "Detection Ratios",
          tabName = "detection_ratio",
          icon = icon("id-card")
        )
      )
    ),
    footer = bs4Dash::dashboardFooter(
      left = a(
        href = "https://www.ffishlab.ca/",
        target = "_blank", "Freshwater Fish Ecology Lab"
      ),
      right = "2021"
    ),
    body = bs4Dash::dashboardBody(
      css_styling(),
      bs4Dash::bs4TabItems(
        bs4Dash::tabItem(
          tabName = "deployment",
          mod_deployment_ui("deployment_ui")
        ),
        bs4Dash::tabItem(
          tabName = "detection_ratio",
          mod_detection_ratio_ui("detection_ratio_ui", sex = sex, weight = weight, forklength = forklength)
        ),
        bs4Dash::tabItem(
          tabName = "detection_path",
          mod_detection_path_ui("detection_path_ui", sex = sex, weight = weight, forklength = forklength)
        ))
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shinywsgcolr'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

