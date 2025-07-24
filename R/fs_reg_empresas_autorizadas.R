#' Get Registry of Authorized Companies for Sports Hunting Education Courses
#'
#' @description
#' This function accesses the Registry of Companies Authorized to Teach Education,
#' Safety and Ethics Courses in Sports Hunting, which is part of the statistical
#' component of the National Forest and Wildlife Information System (SNIFFS).
#'
#' The function downloads and processes official data from SERFOR (National Forest
#' and Wildlife Service) about companies authorized to provide sports hunting
#' education courses in Peru.
#'
#' @return A tibble (data frame) with the following columns:
#' \describe{
#'   \item{undorg}{SERFOR Organic Unit that grants the authorization}
#'   \item{docleg}{Authorization resolution number}
#'   \item{fecleg}{Date of issuance of the resolution approving the authorization}
#'   \item{rasoc}{Company name or business name}
#'   \item{numruc}{Company RUC number}
#'   \item{apepat}{Paternal surname of the company's legal representative}
#'   \item{apemat}{Maternal surname of the company's legal representative}
#'   \item{nombre}{Name of the company's legal representative}
#'   \item{direcc}{Company address}
#'   \item{nomdep}{Department where the company is located}
#'   \item{nompro}{Province where the company is located}
#'   \item{nomdis}{District where the company is located}
#'   \item{email}{Company email address}
#'   \item{numtlf}{Company phone number}
#'   \item{observ}{Observations}
#' }
#'
#' @source
#' Data source: SERFOR (National Forest and Wildlife Service) via Google Drive
#' System: SNIFFS (National Forest and Wildlife Information System)
#'
#' @note
#' This function requires an active internet connection. The data is updated regularly by SERFOR.
#'
#' @examples
#' \dontrun{
#' # Load the registry of authorized companies
#' hunting_companies <- fs_reg_empresas_autorizadas()
#'
#' # View data structure
#' str(hunting_companies)
#'
#' # Display first few rows
#' head(hunting_companies)
#'
#' # Get companies by department
#' table(hunting_companies$nomdep)
#'
#' # Filter companies from a specific department
#' lima_companies <- hunting_companies[hunting_companies$nomdep == "LIMA", ]
#' }
#'
#' @family SNIFFS functions
#' @family forestry data functions
#'
#' @author SNIFFS Development Team
#' @keywords datasets forestry wildlife hunting education
#'
#' @export


fs_reg_empresas_autorizadas <- function() {
  # Internal function parameters
  # Number of rows to skip when reading the Excel file.
  skip_rows <- 5
  # Public Google Drive URL containing the concessions data.
  # URL del archivo de Google Drive (Google Sheet)
  gdrive_url <- "https://docs.google.com/spreadsheets/d/13gmMHy0TYjFqYbWT2zxvt50IUjnbq_Uf/edit?gid=169468#gid=169468"
  #  "https://docs.google.com/spreadsheets/d/18UZQG9IKncCcCRCwPLALIzg6PTTFrYQQ/edit?gid=1955182671#gid=1955182671"

  # Extraer el ID del archivo
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Construir la URL de descarga directa (esto NO funciona para hojas de cálculo directamente en formato Excel)
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file to store the downloaded Excel.
  # `tempfile()` generates a unique file name in a temporary directory.
  temp_file <- tempfile(fileext = ".xlsx")

  # Download the file from the Google Drive URL.
  # `tryCatch` is used to handle potential errors during download,
  # such as connection issues or invalid URLs.
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    # Stop execution and throw an error message if the download fails.
    stop("Error downloading the file: ", e$message)
  })

  # Check the HTTP status code of the response.
  # A 200 code indicates a successful download.
  if (httr::status_code(response) != 200) {
    # If the status code is not 200, stop execution and throw an error.
    stop("Download failed. Status code: ", httr::status_code(response))
  }
  # Read and clean the data from the downloaded Excel file.
  # `readxl::read_excel()` reads the file, skipping the first `skip_rows`.
  # `janitor::clean_names()` standardizes column names to `snake_case`.
  # `janitor::remove_empty("cols")` removes any columns that are completely empty.
  suppressMessages(data_raw <- readxl::read_excel(temp_file,
                                                  skip = skip_rows) |>
                     janitor::clean_names() |>
                     janitor::remove_empty("cols")
  )
  raw_names <- names(data_raw)
  raw_names[2] <- "undorg"
  names(data_raw) <- raw_names
  # Return the cleaned data frame.
  return(dplyr::select(data_raw, -x10))
}
