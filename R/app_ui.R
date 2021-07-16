#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  waiter::waiter_set_theme(color = "#749dbf")
  title <- dashboardBrand(
    title = "ffish lab",
    color = "primary",
    href = "https://www.ffishlab.ca/",
    image = "https://raw.githubusercontent.com/poissonconsulting/logos/master/logos/poisson_hex.png"
  )

  dashboardPage(
    freshTheme = mytheme,
    dark = NULL,
    scrollToTop = TRUE,
    title = "Columbia River White Sturgeon",
    header = dashboardHeader(
      ... = div(h3("Columbia River White Sturgeon"), style = "vertical-align: baseline;"),
      title = title
    ),
    sidebar = dashboardSidebar(
      skin = "light",
      elevation = 3,
      id = "sidebarmenu",
      sidebarHeader("Acoustic Telemetry"),
      menuItem(
        "Deployment",
        tabName = "deployment"
      ),
      menuItem(
        "Detection Path",
        tabName = "detection_path"
      ),
      menuItem(
        "Detection Ratios",
        tabName = "detection_ratio"
      )
    ),
    controlbar = dashboardControlbar(),
    footer = dashboardFooter(
      left = a(
        href = "https://www.ffishlab.ca/",
        target = "_blank", "Freshwater Fish Ecology Lab"
      ),
      right = "2021"
    ),
    body = dashboardBody()
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

