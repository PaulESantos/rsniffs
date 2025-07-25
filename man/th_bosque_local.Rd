% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/th_bosque_local.R
\name{th_bosque_local}
\alias{th_bosque_local}
\title{Retrieve Local Forest (Bosque Local) Data from SNIFFS - SERFOR}
\usage{
th_bosque_local()
}
\value{
A \strong{tibble} containing the cleaned Local Forest data.
}
\description{
Downloads and processes the most recent dataset of Local Forests (Bosques Locales)
from the statistical component of the Sistema Nacional de Información Forestal y de Fauna Silvestre (SNIFFS),
administered by SERFOR (Servicio Nacional Forestal y de Fauna Silvestre) in Peru.

A Local Forest (Bosque Local) constitutes a Forest Management Unit, established through
Executive Resolution of SERFOR, intended to enable legal and orderly access for local
populations to sustainable utilization for commercial purposes. According to the site
category, it can be designated for timber harvesting, non-timber forest products,
wildlife, or silvopastoral systems.

The function accesses a resource publicly shared by SNIFFS via Google Sheets.
}
\details{
The dataset is sourced from a Google Sheets document.
}
\examples{
\dontrun{
# Retrieve the forest concessions dataset:
concessions_df <- th_concesiones()

# Preview the first few rows
head(concessions_df)

# Summary statistics
summary(concessions_df)

# View data
View(concessions_df)
}
}
\author{
Paul Efren Santos Andrade
}
