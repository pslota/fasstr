% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_longterm_stats.R
\name{calc_longterm_stats}
\alias{calc_longterm_stats}
\title{Calculate the long-term and long-term monthly summary statistics}
\usage{
calc_longterm_stats(flowdata = NULL, HYDAT = NULL, percentiles = c(10,
  90), water_year = FALSE, water_year_start = 10, start_year = NULL,
  end_year = NULL, exclude_years = NULL, custom_months = NULL,
  custom_months_label = "Custom-Months", transpose = FALSE,
  station_name = NA, write_table = FALSE, write_digits = 3,
  write_dir = ".", na.rm = list(na.rm.global = FALSE))
}
\arguments{
\item{flowdata}{Data frame. A data frame of daily mean flow data that includes two columns: a 'Date' column with dates formatted 
YYYY-MM-DD, and a numeric 'Value' column with the corresponding daily mean flow values in units of cubic metres per second. 
Not required if \code{HYDAT} argument is used.}

\item{HYDAT}{Character. A seven digit Water Survey of Canada station number (e.g. \code{"08NM116"}) of which to extract daily streamflow 
data from a HYDAT database. \href{https://github.com/ropensci/tidyhydat}{Installation} of the \code{tidyhydat} package and a HYDAT 
database are required. Not required if \code{flowdata} argument is used.}

\item{percentiles}{Numeric. Vector of percentiles to calculate. Set to NA if none required. Default \code{c(10,90)}}

\item{water_year}{Logical. Use water years to group flow data instead of calendar years. Water years are designated
by the year in which they end. Default \code{FALSE}.}

\item{water_year_start}{Integer. Month indicating the start of the water year. Used if \code{water_year=TRUE}. Default \code{10}.}

\item{start_year}{Integer. First year to consider for analysis. Leave blank if all years are required.}

\item{end_year}{Integer. Last year to consider for analysis. Leave blank if all years are required.}

\item{exclude_years}{Integer. Single year or vector of years to exclude from analysis. Leave blank if all years are required.}

\item{custom_months}{Integer. Vector of months to combine to summarize (ex. \code{6:8} for Jun-Aug). Adds results to the end of table.
Leave blank for no custom month summary.}

\item{custom_months_label}{Character. Label of custom months. For example, if choosing months 7:9  you may choose "Summer" or "Jul-Sep".
Default \code{"Custom-Months"}.}

\item{transpose}{Logical. Switch the rows and columns of the results table. Default \code{FALSE}.}

\item{station_name}{Character. Name of hydrometric station or stream that will be used to create file names. Leave blank if not writing
files or if \code{HYDAT} is used or a column in \code{flowdata} called 'STATION_NUMBER' contains a WSC station number, as the name
will be the \code{HYDAT} value provided in the argument or column. Setting the station name will replace the HYDAT station number.}

\item{write_table}{Logical. Write the table as a .csv file to specified directory. Default \code{FALSE}.}

\item{write_digits}{Numeric. Number of significant digits to round the results in the written table. Default \code{3}.}

\item{write_dir}{Character. Directory folder name of where to write tables and plots. If directory does not exist, it will be created.
Default is the working directory.}

\item{na.rm}{TBD}
}
\value{
A data frame with the following columns:
  \item{Month}{month of the year, included Long-term for all months, and Custom-Months if selected}
  \item{Mean}{mean of all daily flows for a given month and longterm over all years}
  \item{Median}{median of all daily flows for a given month and longterm over all years}
  \item{Maximum}{maximum of all daily flows for a given month and longterm over all years}
  \item{Minimum}{minimum of all daily flows for a given month and longterm over all years}
  \item{P'n'}{each  n-th percentile selected for a given month and longterm over all years}
  Default percentile columns:
  \item{P10}{annual 10th percentile selected for a given month and longterm over all years}
  \item{P90}{annual 90th percentile selected for a given month and longterm over all years}
  Transposing data creates a column of "Statistics" and subsequent columns for each year selected.
}
\description{
Calculates the long-term and long-term monthly mean, median, maximum, minimum, and percentiles of daily flow values 
   from a streamflow dataset. Calculates the statistics from all daily discharge values from all years, unless specified.
}
\examples{
\dontrun{

calc_longterm_stats(flowdata = flowdata, station_name = "MissionCreek", write_table = TRUE)

calc_longterm_stats(HYDAT = "08NM116", water_year = TRUE, water_year_start = 8, percentiles = c(1:10))

calc_longterm_stats(HYDAT = "08NM116", custom_months = c(5:9))

}
}
