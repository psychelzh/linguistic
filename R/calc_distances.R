#' Calculate Distances
#'
#' @title
#' @param data_clean
calc_distances <- function(data_clean) {
  data_clean |>
    group_by(type, SID, Time) |>
    group_modify(
      ~ .x |>
        select(-order) |>
        t() |>
        vegan::vegdist("chisq") |>
        broom::tidy()
    ) |>
    ungroup()
}

mean_distances <- function(distances) {
  distances |>
    group_by(type, Time, item1, item2) |>
    summarise(distance = mean(distance), .groups = "drop")
}
