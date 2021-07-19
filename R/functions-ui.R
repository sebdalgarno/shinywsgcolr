dl_button <- function(..., icon = "download", class = "btn-primary") {
  downloadButton(..., icon = icon(icon), class = class)
}

button <- function(..., icon = NULL, class = "btn-primary") {
  bs4Dash::actionButton(..., icon = icon(icon), class = class)
}

table_output <- function(...) {
  wellPanel(DT::DTOutput(...), style = "font-size:85%", class = "wellpanel")
}

gt_table_output <- function(...) {
  wellPanel(gt::gt_output(...), style = "font-size:90%", class = "wellpanel")
}

helper <- function(...) {
  shinyhelper::helper(...)
}

inline = function (x) {
  tags$div(style = "display:inline-block; width:105px; height:75px;", x)
}

inline2 = function (x) {
  tags$div(style = "display:inline-block; width:120px; height:75px;", x)
}
