library(targets)
library(tarchetypes)
future::plan(future::multisession)
purrr::walk(fs::dir_ls("R"), source)
tar_option_set(packages = c("tidyverse", "tidygraph", "ggraph"))
list(
  tar_file(file_data, "data/data.xlsx"),
  tar_target(sheet_names, readxl::excel_sheets(file_data)),
  tar_target(
    data,
    read_data(file_data, sheet_names),
    pattern = map(sheet_names)
  ),
  tar_target(data_clean, wrangle_data(data)),
  tar_target(dist_euc, calc_distances(data_clean, "euclidean")),
  tar_target(mean_dist_euc, mean_distances(dist_euc)),
  tar_target(graphs_euc, create_graph(dist_euc, type, SID, Time)),
  tar_target(mean_graphs_euc, create_graph(mean_dist_euc, type, Time)),
  tar_target(dist_chi, calc_distances(data_clean, "chisq")),
  tar_target(mean_dist_chi, mean_distances(dist_chi)),
  tar_target(graphs_chi, create_graph(dist_chi, type, SID, Time)),
  tar_target(mean_graphs_chi, create_graph(mean_dist_chi, type, Time)),
  tar_file(file_child_viz_graph, "archetypes/child_vis_graph.Rmd"),
  tar_file(file_child_statistics, "archetypes/child_statistics.Rmd"),
  tar_render(
    output_analysis_notes,
    "analysis/notes.Rmd",
    output_dir = "output"
  ),
  tar_file(
    file_dist_mean_euc,
    output_xlsx(mean_dist_euc, "output/data_mean_euc.xlsx")
  ),
  tar_file(
    file_dist_each_euc,
    output_xlsx(dist_euc, "output/data_euc.xlsx", by = "SID")
  ),
  tar_file(
    file_dist_mean_chi,
    output_xlsx(mean_dist_chi, "output/data_mean_chi.xlsx")
  ),
  tar_file(
    file_dist_each_chi,
    output_xlsx(dist_chi, "output/data_chi.xlsx", by = "SID")
  )
)
