dl_button <- function(..., icon = "download", class = "btn-primary") {
  downloadButton(..., icon = icon(icon), class = class)
}

button <- function(..., icon = NULL, class = "btn-primary") {
  bs4Dash::actionButton(..., icon = icon(icon), class = class)
}

inline = function (x) {
  tags$div(style = "display:inline-block; width:105px; height:75px;", x)
}

inline2 = function (x) {
  tags$div(style = "display:inline-block; width:120px; height:75px;", x)
}
