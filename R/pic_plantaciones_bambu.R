#' Get Registry of Bamboo Plantations
#'
#' @description
#' Downloads and processes the dataset titled "LISTADO DEL REGISTRO DE PLANTACIONES DE BAMBÚ",
#' available under the section *Producción, Industria y Comercio* of the National Forest
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

pic_plantaciones_bambu <- function() {
  # Public Google Drive URL of the dataset
  gdrive_url <- "https://docs.google.com/spreadsheets/d/1-H10CwSvIybNDgzVavxpYyVzhsom_Tl-/edit?gid=1403140445#gid=1403140445"

  # Extract the file ID from the URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Build the direct download URL (works only for downloadable files)
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file to store the downloaded Excel file
  temp_file <- tempfile(fileext = ".xlsx")

  # Attempt to download the file using httr
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Failed to download the file: ", e$message)
  })

  # Check for successful HTTP response
  if (httr::status_code(response) != 200) {
    stop("Download failed. HTTP status code: ", httr::status_code(response))
  }

  # Read and clean the Excel file
  data_raw <- suppressMessages(
    readxl::read_excel(temp_file, skip = 6) |>
      janitor::clean_names() |>
      janitor::remove_empty("cols")
  )

  return(data_raw)
}
