#' Cleanse data
#'
#' @title
#' @param data
wrangle_data <- function(data) {
  data |>
    separate(name, c("index", "type"), -1) |>
    pivot_wider(names_from = index, values_from = value)
}
