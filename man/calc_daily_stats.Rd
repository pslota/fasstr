% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_daily_stats.R
\name{calc_daily_stats}
\alias{calc_daily_stats}
\title{Calculate the daily summary statistics}
\usage{
calc_daily_stats(flowdata = NULL, HYDAT = NULL, percentiles = c(5, 25, 75,
  95), rolling_days = 1, rolling_align = "right", water_year = FALSE,
  water_year_start = 10, start_year = NULL, end_year = NULL,
  exclude_years = NULL, transpose = FALSE, station_name = NA,
  write_table = FALSE, write_digits = 3, write_dir = ".",
  na.rm = list(na.rm.global = FALSE))
}
\arguments{
\item{flowdata}{Data frame. A data frame of daily mean flow data that includes two columns: a 'Date' column with dates formatted 
YYYY-MM-DD, and a numeric 'Value' column with the corresponding daily mean flow values in units of cubic metres per second. 
Not required if \code{HYDAT} argument is used.}

\item{HYDAT}{Character. A seven digit Water Survey of Canada station number (e.g. \code{"08NM116"}) of which to extract daily streamflow 
data from a HYDAT database. \href{https://github.com/ropensci/tidyhydat}{Installation} of the \code{tidyhydat} package and a HYDAT 
database are required. Not required if \code{flowdata} argument is used.}

\item{percentiles}{Numeric. Vector of percentiles to calculate. Set to NA if none required. Default \code{c(5,25,75,95)}}

\item{rolling_days}{Numeric. The number of days to apply a rolling mean. Default \code{1}.}

\item{rolling_align}{Character. Specifies whether the dates of the rolling mean should be specified by the first ('left'), last ('right),
or middle ('center') of the rolling n-day group of observations. Default \code{'right'}.}

\item{water_year}{Logical. Use water years to group flow data instead of calendar years. Water years are designated
by the year in which they end. Default \code{FALSE}.}

\item{water_year_start}{Integer. Month indicating the start of the water year. Used if \code{water_year=TRUE}. Default \code{10}.}

\item{start_year}{Integer. First year to consider for analysis. Leave blank if all years are required.}

\item{end_year}{Integer. Last year to consider for analysis. Leave blank if all years are required.}

\item{exclude_years}{Integer. Single year or vector of years to exclude from analysis. Leave blank if all years are required.}

\item{transpose}{Logical. Switch the rows and columns of the results table. Default \code{FALSE}.}

\item{station_name}{Character. Name of hydrometric station or stream that will be used to create file names. Leave blank if not writing
files or if \code{HYDAT} is used or a column in \code{flowdata} called 'STATION_NUMBER' contains a WSC station number, as the name
will be the \code{HYDAT} value provided in the argument or column. Setting the station name will replace the HYDAT station number.}

\item{write_table}{Logical. Write the table as a .csv file to specified directory. Default \code{FALSE}.}

\item{write_digits}{Numeric. Number of significant digits to round the results in the written table. Default \code{3}.}

\item{write_dir}{Character. Directory folder name of where to write tables and plots. If directory does not exist, it will be created.
Default is the working directory.}
}
\value{
A data frame with the following columns:
  \item{Date}{date (MMM-DD) of daily statistics}
  \item{DayofYear}{day of year of daily statistics}
  \item{Mean}{daily mean of all flows for a given day of the year}
  \item{Median}{daily mean of all flows for a given day of the year}
  \item{Maximum}{daily mean of all flows for a given day of the year}
  \item{Minimum}{daily mean of all flows for a given day of the year}
  \item{P'n'}{each daily n-th percentile selected of all flows for a given day of the year}
  Default percentile columns:
  \item{P5}{daily 5th percentile of all flows for a given day of the year}
  \item{P25}{daily 25th percentile of all flows for a given day of the year}
  \item{P75}{daily 75th percentile of all flows for a given day of the year}
  \item{P95}{daily 95th percentile of all flows for a given day of the year}
  Transposing data creates a column of "Statistics" and subsequent columns for each year selected.
}
\description{
Calculates the daily mean, median, maximum, minimum, and percentiles for each day of the year of daily flow values 
   from a streamflow dataset. Calculate the statistics from all daily discharge values from all years, unless specified. Can determine
   statistics of rolling mean days (e.g. 7-day flows) using the rolling_days argument.
}
\examples{
\dontrun{

calc_daily_stats(flowdata = flowdata, station_name = "MissionCreek", write_table = TRUE)

calc_daily_stats(HYDAT = "08NM116", water_year = TRUE, water_year_start = 8, percentiles = c(1:10))

}
}
