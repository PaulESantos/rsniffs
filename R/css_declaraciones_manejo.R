#' Get Registry of Bamboo Plantations
#'
#' @description
#' Downloads and processes the dataset titled "PLANES DE MANEJO Y DECLARACIONES DE MANEJO VIGENTES CAMÉLIDOS SUDAMERICANOS SILVESTRES",
#' available under the section *CAMÉLIDOS SUDAMERICANOS SILVESTRES* of the National Forest
#' and Wildlife Information System (SNIFFS) of Peru.
#'
#' The data is officially published by SERFOR (National Forest and Wildlife Service)
#' and provides information about registered bamboo plantations across the country.
#'
#' @return A tibble containing the cleaned dataset.
#'
#' @note
#' An active internet connection is required to run this function. The data source is maintained
#' by SERFOR and may be updated periodically.
#'
#' @author Paul Efren Santos Andrade
#'
#' @source
#' SERFOR (National Forest and Wildlife Service) — SNIFFS database
#'
#' @export
css_declaraciones_manejo <- function() {
  gdrive_url <- "https://docs.google.com/spreadsheets/d/1GMVW0Lh10V-B9YfUoMh72h6GfJgliIkT/edit?gid=395125517#gid=395125517"

  # Extract the file ID from the URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Temporary file
  temp_file <- tempfile(fileext = ".xlsx")

  # Attempt download
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Failed to download the file: ", e$message)
  })

  if (httr::status_code(response) != 200) {
    stop("Download failed. HTTP status code: ", httr::status_code(response))
  }

  # Read and clean the data
  data_clean <- readxl::read_excel(temp_file, skip = 4) |>
    janitor::clean_names() |>
    janitor::remove_empty("cols")

  # Delete temp file
  unlink(temp_file)

  return(data_clean)
}
