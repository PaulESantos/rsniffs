utils::globalVariables(c("x10"))
# Environment for package-level variables
.pkgenv <- new.env(parent = emptyenv())

#' @keywords internal
.onAttach <- function(libname, pkgname) {
  # Display welcome message
  packageStartupMessage(
    sprintf(
      "Welcome to rsniffs (%s)\n%s\n%s\n%s",
      utils::packageDescription("rsniffs", fields = "Version"),
      "This package provides tools to access and query data from the SNIFFS statistics platform:",
      "  https://sniffs.serfor.gob.pe/estadistica/es",
      "Type ?rsniffs to get started or visit the documentation for examples and guidance."
    )
  )

}

#' @keywords internal
.onLoad <- function(libname, pkgname) {
  # Silent initialization when the package is loaded
  invisible()
}
