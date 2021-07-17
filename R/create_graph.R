#' Create graphs based correlation calculation
#'
#' @title
#' @param data_clean
create_graph <- function(data_clean) {
  data_clean |>
    group_nest(type, SID, Time) |>
    mutate(
      graph = map(
        data,
        ~ .x |>
          select(-order) |>
          t() |>
          vegan::vegdist("chisq") |>
          broom::tidy() |>
          as_tbl_graph(directed = FALSE)
      ),
      .keep = "unused"
    )
}
