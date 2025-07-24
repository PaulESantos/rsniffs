#' Get Bamboo Mobilization Report in Peru
#'
#' @description
#' This function downloads and processes the report titled
#' "REPORTE DE MOVILIZACIÓN DE BAMBU A NIVEL NACIONAL", available under the
#' PRODUCCIÓN, INDUSTRIA Y COMERCIO category from the statistical module of
#' the National Forest and Wildlife Information System (SNIFFS) managed by SERFOR.
#'
#' The data contains detailed information about the movement of bamboo across
#' different departments, provinces, and districts in Peru.
#'
#' @return A tibble containing cleaned and standardized data on bamboo mobilization.
#' @author
#' Paul Efren Santos Andrade
#'
#' @source
#' SERFOR (National Forest and Wildlife Service), SNIFFS System
#' Google Drive link: \url{https://docs.google.com/spreadsheets/d/1-VMvpGlXezG0YMjA_U8fMizTYcAC8QKy/edit?gid=446613698#gid=446613698}
#'
#' @note
#' Requires an internet connection. The file is accessed directly from a public Google Drive URL.
#'
#' @keywords datasets forestry bamboo mobilization SNIFFS
#' @export

pic_movilizacion_bambu <- function() {
  skip_rows <- 4

  gdrive_url <- "https://docs.google.com/spreadsheets/d/1-VMvpGlXezG0YMjA_U8fMizTYcAC8QKy/edit?gid=446613698#gid=446613698"
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  temp_file <- tempfile(fileext = ".xlsx")

  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Error downloading the file: ", e$message)
  })

  if (httr::status_code(response) != 200) {
    stop("Download failed. Status code: ", httr::status_code(response))
  }

  data_raw <- tryCatch({
    suppressMessages(
      readxl::read_excel(temp_file, skip = skip_rows) |>
        janitor::clean_names() |>
        janitor::remove_empty("cols")
    )
  }, error = function(e) {
    stop("Error reading Excel file: ", e$message)
  })

  # Rename first six columns to standardized location identifiers
  expected_cols <- c("org_dep", "org_prov", "org_distr",
                     "dest_dep", "dest_prov", "dest_distr")

  if (ncol(data_raw) >= 6) {
    names(data_raw)[1:6] <- expected_cols
  }

  # Clean up temporary file
  unlink(temp_file)

  return(data_raw)
}
