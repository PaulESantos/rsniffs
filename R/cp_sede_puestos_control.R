#' Get Registry of Control Posts and Headquarters
#'
#' @description
#' Retrieves data from the "Sedes y Puestos de Control" (Headquarters and Control Posts)
#' section under the "Control de Productos Forestales" component of the
#' National Forest and Wildlife Information System (SNIFFS), administered by SERFOR.
#'
#' This function downloads and processes official data from the Peruvian National Forest
#' and Wildlife Service (SERFOR) through a shared Google Sheet.
#'
#' @return A tibble containing the registry of control posts and headquarters, with cleaned column names.
#'
#' @details
#' The dataset includes information related to control points for the monitoring and enforcement
#' of forest and wildlife products in Peru.
#'
#' @note
#' Requires an active internet connection. Data is hosted on Google Drive and updated periodically by SERFOR.
#'
#' @author
#' Paul Efren Santos Andrade
#'
#' @source
#' SERFOR – Servicio Nacional Forestal y de Fauna Silvestre.
#' System: SNIFFS – Sistema Nacional de Información Forestal y de Fauna Silvestre.
#'
#' @export
cp_sede_puestos_control <- function() {
  # Define the public Google Sheets URL
  gdrive_url <- "https://docs.google.com/spreadsheets/d/177s3whLxS-qaXrCJBlbEltE5htLeDP1u/edit?gid=628751028#gid=628751028"

  # Extract the file ID from the URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Construct the direct download link
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file path
  temp_file <- tempfile(fileext = ".xlsx")

  # Attempt to download the file
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Error downloading the file: ", e$message)
  })

  # Check download status
  if (httr::status_code(response) != 200) {
    stop("Download failed. Status code: ", httr::status_code(response))
  }

  # Read and clean the Excel file
  data_raw <- suppressMessages(
    suppressWarnings(
      readxl::read_excel(temp_file) |>
        janitor::clean_names() |>
        janitor::remove_empty("cols")
    )
  )

  return(data_raw)
}
