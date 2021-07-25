#' Create graphs
#'
#' @title
#' @param distances
#' @param ... Variables to be grouped by
create_graph <- function(distances, ...) {
  distances |>
    group_nest(...) |>
    mutate(
      graph = map(data, as_tbl_graph, directed = FALSE),
      .keep = "unused"
    )
}
