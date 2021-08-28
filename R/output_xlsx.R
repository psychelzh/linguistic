#' Output Data as Excel File
#'
#' @param data
#' @param file
#' @param by
output_xlsx <- function(data, file, by = NULL) {
  if (!is.null(by)) {
    data <- split(data, data[[by]])
  }
  writexl::write_xlsx(data, file)
  file
}
