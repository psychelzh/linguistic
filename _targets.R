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
  tar_target(distances, calc_distances(data_clean)),
  tar_target(distances_mean, mean_distances(distances)),
  tar_target(graphs, create_graph(distances, type, SID, Time)),
  tar_target(graph_mean, create_graph(distances_mean, type, Time)),
  tar_file(file_child_viz_graph, "archetypes/child_vis_graph.Rmd"),
  tar_render(
    output_analysis_notes,
    "analysis/notes.Rmd",
    output_dir = "output"
  ),
  tar_file(
    file_data_graph_mean, {
      file <- "output/data_graph_mean.xlsx"
      writexl::write_xlsx(distances_mean, file)
      file
    }
  )
)
