#' Forest Use Authorizations Dataset
#'
#' This dataset contains information on valid forest use authorizations granted by SERFOR (Servicio Nacional Forestal y de Fauna Silvestre) in Peru. Each record represents an authorization granted to a titled individual for a specific forest area.
#'
#' @format A data frame with 431 rows and 8 variables:
#' \describe{
#'   \item{ano}{Numeric. Year in which the authorization was issued.}
#'   \item{contrato}{Character. Contract code of the authorization.}
#'   \item{titular}{Character. Name of the authorized title holder.}
#'   \item{arffs}{Character. Name of the corresponding regional ATFFS office (e.g., "ATFFS ANCASH").}
#'   \item{departamento}{Character. Department where the authorized forest area is located.}
#'   \item{provincia}{Character. Province where the authorized forest area is located.}
#'   \item{distrito}{Character. District where the authorized forest area is located.}
#'   \item{supercie_ha}{Numeric. Surface area authorized for use, in hectares.}
#' }
#'
#' @source Servicio Nacional Forestal y de Fauna Silvestre (SERFOR)
"th_autorizaciones"
