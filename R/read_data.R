#' Read data from a single sheet
#'
#' @title
#' @param file_data
#' @param sheet_name
read_data <- function(file_data, sheet_name) {
  readxl::read_excel(file_data, sheet = sheet_name) |>
    rename_with(~ "value", last_col()) |>
    add_column(name = sheet_name)
}
