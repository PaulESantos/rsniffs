#' Get National Scientific Institutions Depositing Biological Material
#'
#' @description
#' Retrieves and processes the official registry of Peruvian scientific institutions
#' that are authorized as depositaries of biological material. The data is part of
#' the component "Investigación Científica y Recursos Genéticos" from the
#' National Forest and Wildlife Information System (SNIFFS), managed by SERFOR.
#'
#' @details
#' The function downloads a spreadsheet from a public Google Drive link maintained by SERFOR,
#' cleans the data, and returns a tidy tibble. The original table is located within
#' the SNIFFS statistical platform and is periodically updated.
#'
#' @return A tibble containing cleaned data from SERFOR. Typical columns include institution name,
#' location, authorization details, and date of registration. Empty rows and columns are removed.
#'
#' @note
#' Requires an active internet connection. If the Google Drive URL is inaccessible or changed,
#' the function will throw an error.
#'
#' @author
#' Paul Efren Santos Andrade
#'
#' @source
#' Data source: SERFOR (Servicio Nacional Forestal y de Fauna Silvestre)
#'
#' @export
icrg_inst_depositarias <- function() {
  # Public Google Drive URL to the spreadsheet
  gdrive_url <- "https://docs.google.com/spreadsheets/d/166MIyS39ldnJ4k5d4q_iuPQH8S5i8gCm/edit#gid=78262368"

  # Extract file ID from the URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Construct download URL for direct access
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file
  temp_file <- tempfile(fileext = ".xlsx")
  on.exit(unlink(temp_file), add = TRUE)  # Ensure cleanup

  # Attempt file download
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Error downloading the file from Google Drive: ", e$message)
  })

  # Validate HTTP response
  if (httr::status_code(response) != 200) {
    stop("Failed to download file. HTTP status: ", httr::status_code(response))
  }

  # Read and clean data
  data_raw <- suppressMessages(suppressWarnings(
    readxl::read_excel(temp_file, skip = 4) |>
      janitor::clean_names() |>
      janitor::remove_empty("cols")
  ))

  # Drop the first column if it's just row numbers or empty
  data_clean <- if ("n" %in% names(data_raw)) dplyr::select(data_raw, -1) else data_raw

  return(tidyr::drop_na(data_clean))
}
