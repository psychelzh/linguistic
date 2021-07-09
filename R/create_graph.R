#' Create graphs based correlation calculation
#'
#' @title
#' @param data_clean
create_graph <- function(data_clean) {
  data_clean |>
    group_by(type, Time, SID) |>
    group_modify(
      ~ .x |>
        select(-order) |>
        t() |>
        vegan::vegdist("chisq") |>
        broom::tidy()
    ) |>
    ungroup() |>
    group_nest(SID, type) |>
    mutate(
      graph = map(
        data,
        ~ .x |>
          select(starts_with("item"), everything()) |>
          as_tbl_graph(directed = FALSE)
      ),
      .keep = "unused"
    )
}
