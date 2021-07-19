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
  tar_target(graphs, create_graph(data_clean)),
  tar_file(file_child_viz_graph, "archetypes/child_vis_graph.Rmd"),
  tar_render(
    output_analysis_notes,
    "analysis/notes.Rmd",
    output_dir = "output"
  )
)
