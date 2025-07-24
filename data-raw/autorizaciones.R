## code to prepare `autorizaciones` dataset goes here
th_autorizaciones <- readxl::read_excel("raw_data\\APP_AUTORIZACIONES_VIGENTES.xlsx",
                                        skip = 2) |>
  janitor::clean_names() |>
  janitor::remove_empty("cols")
th_autorizaciones



usethis::use_data(th_autorizaciones,
                  overwrite = TRUE,
                  compress = "xz")
