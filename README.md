
<!-- README.md is generated from README.Rmd. Please edit that file -->
<a rel="Exploration" href="https://github.com/BCDevExchange/docs/blob/master/discussion/projectstates.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>

fasstr
======

The Flow Analysis Summary Statistics Tool for R (`fasstr`) is a set of [R](http://www.r-project.org) functions to summarize, analyze, trend, and visualize streamflow data. This package summarizes continuous daily mean streamflow data into various daily, monthly, annual, and long-term statistics, completes annual trends and frequency analyses, and provides output tables and plots.

Features
--------

Useful features of this package include the utilization of the [tidyhydat](https://github.com/ropensci/tidyhydat) package to extract Water Survey of Canada historical streamflow data from a locally saved [HYDAT](https://www.canada.ca/en/environment-climate-change/services/water-overview/quantity/monitoring/survey/data-products-services/national-archive-hydat.html) database for analyses, the filtering of years included in analyses (start and end years, excluded years), option to choose water years for analyses instead of calendar years, streamflow data preparation functions (use in a tidy fashion), and customizing how missing dates are handled.

Installation
------------

To install the `fasstr` package, you need to install the `devtools` package then the `fasstr` package

``` r
install.packages("devtools")
devtools::install_github("bcgov/fasstr", ref = "devel")
```

Then to call the `fasstr` functions you can either load the package using the `library()` function or access a specific function using a double-colon (e.g. `fasstr::calc_daily_stats()`). Several other packages will be installed in addition to this package including [zyp](https://cran.r-project.org/web/packages/zyp/index.html) for trending, [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) for creating plots, and [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) and [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html) for various data wrangling and summarizing functions, amongst others.

``` r
library(fasstr)
```

To use the `HYDAT` arguments of the `fasstr` functions, you will need to download the `tidyhydat` package and a HYDAT database. Installation instructions for both can be found [here](https://github.com/ropensci/tidyhydat).

Usage
-----

### Flow Data Input

All functions in `fasstr` require a data frame of daily mean streamflow from a hydrometric station. Long-term and continuous datasets are preferred for most analyses, but seasonal and partial data can be used. A data frame can be provided to the functions through either the `flow_data` or `HYDAT` arguments.

Using the `flow_data` argument, a data frame of flow data containing columns of dates (YYYY-MM-DD in date format), flow values (mean daily discharge in cubic metres per second in numeric format), and, optionally, station identifiers (character string of station name or numbers) is called. By default the functions will look for columns identified as 'Date', 'Value', and 'STATION\_NUMBER', respectively (as matching the HYDAT format), but columns of different names can be identified using the `flow_dates`, `flow_values`, `flow_stations` column arguments (PROVIDE EXAMPLE), respectively. The following is an example of an appropriate flow\_data dataframe:

``` r
str(flow_data)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    16102 obs. of  2 variables:
#>  $ Date : Date, format: "1972-12-01" "1972-12-02" ...
#>  $ Value: num  3 0.94 0.385 0.241 0.207 ...
```

Alternatively, you can directly extract a HYDAT flow data frame from a HYDAT database When using the `HYDAT` argument. This requires Water Survey of Canada station numbers (e.g. `HYDAT="08NM116"`) to be listed and their corresponding historical daily streamflow record will be extracted from HYDAT using `tidyhydat`. [Installation](https://github.com/ropensci/tidyhydat) of both `tidyhydat` and a HYDAT database is required to use this argument.

### Multiple Stations

This package allows for multiple stations to be analyzed in the `calc` functions provided station identifiers are provided using the `flow_stations` column argument (defaults to STATION\_NUMBER). If station identifier column doesn't exist or is improperly named, then all flow values listed in the `flow_values` column (unless filtered out using the filtering arguments) will be summarized (regardless of one or more stations).

Plotting functions only produce one plot.....so all flow values used

### Year Options

To customize your analyses for specific time periods, you can designate the start and end years of your analysis using the `start_year` and `end_year` arguments and remove any unwanted years (for partial datasets for example) by listing them in the `excluded_years` argument (e.g. `excluded_years=c(1990,1992:1994)`). Leaving these arguments blank will result in the summary/analysis of all years of the provided dataset.

To group analyses by water, or hydrologic, years instead of calendar years, if desired, you can use `water_year=TRUE` within most functions (default is `water_year=FALSE`). A water year can be defined as a 12-month period that comprises a complete hydrologic cycle (wet seasons can typically cross calendar year), typically starting with the month with minimum flows (the start of a new water recharge cycle). As water years commonly start in October, the default water year is October for `fasstr`. If another start month is desired, you can choose is using the `water_year_start` argument (numeric month) to designate the water year time period. The water year label is designated by the year it ends in (e.g. water year 2000 goes from Oct 1, 1999 to Sep 30, 2000). Start, end and excluded years will be based on the specified water year.

### Drainage Basin Area

For annual yield runoff statistics calculated in the annual statistics functions, an upstream drainage basin area (in sq. km) is required with the `basin_area` argument. If no area is supplied with `flow_data` all yield results will be `NA`. If using the `HYDAT` argument to supply streamflow data, the function will automatically use the basin area of the station provided in HYDAT, if available, so `basin_area` is not required. To override the basin area from HYDAT, set the `basin_area` to your choosing and it will replace the HYDAT number.

If not using `HYDAT` and your `flow_data` dataframe contains a column called `STATION_NUMBER` (HYDAT originated) the functions will look up the station number listed and grab the corresponding basin area from HYDAT, if it exists, without setting the `basin_area` argument. This allows you to use a `flow_data` dataframe that originated from HYDAT without having to look up a basin area.

### Handling Missing Dates

Coming soon. ignore\_missing argument. different functions have different defaults....

Mention that other vairables (PPT, temp, water levels, etc) can be used in calc and pltting

Examples
--------

### Summary statistics example: long-term statistics

To determine the summary statistics of an entire dataset and by month (mean, median, maximum, minimum, and some percentiles) you can use the `calc_longterm_stats()` function. If the 'Mission Creek near East Kelowna' hydrometric station is of interest you can list the station number in the `HYDAT` argument to obtain the data (if `tidyhydat` and HYDAT are installed).

``` r
calc_longterm_stats(HYDAT = "08NM116")
#> # A tibble: 13 x 8
#>    STATION_NUMBER     Month      Mean Median Maximum Minimum    P10    P90
#>  *          <chr>    <fctr>     <dbl>  <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1        08NM116       Jan  1.085907  0.878    9.50   0.160 0.5200  1.700
#>  2        08NM116       Feb  1.043398  0.879    4.41   0.140 0.4970  1.775
#>  3        08NM116       Mar  1.606463  1.180    9.86   0.380 0.7050  3.246
#>  4        08NM116       Apr  6.702245  4.250   42.40   0.340 1.1700 15.600
#>  5        08NM116       May 23.419247 21.200   87.50   0.821 8.8720 40.200
#>  6        08NM116       Jun 22.436086 20.300   86.20   0.450 6.2000 40.800
#>  7        08NM116       Jul  5.981690  3.720   76.80   0.332 0.9946 13.300
#>  8        08NM116       Aug  2.082254  1.480   22.40   0.311 0.6990  4.022
#>  9        08NM116       Sep  2.415459  1.560   18.30   0.354 0.6908  5.010
#> 10        08NM116       Oct  2.121410  1.650   15.20   0.025 0.7797  4.130
#> 11        08NM116       Nov  1.841419  1.560   11.70   0.260 0.5987  3.291
#> 12        08NM116       Dec  1.248250  1.080    7.30   0.342 0.5288  2.210
#> 13        08NM116 Long-term  6.553322  1.840   87.50   0.025 0.6930 21.000
```

### Plotting example 1: daily summary statistics

To visualize the daily streamflow patterns on an annual basis, the `plot_daily_stats()` function will plot out various summary statistics for each day of the year. Data can also be filtered for certain years of interest (a 1981-2010 normals period for this example) using the `start_year` and `end_year` arguments. Multiple plots are produced with this function, so this example plots just the summary statistics (`[1]`).

``` r
#plot_daily_stats(HYDAT = "08NM116",
#                 start_year = 1981,
#                 end_year = 2010,
#                 log_discharge = TRUE)[1]
```

### Plotting example 2: flow duration curves

Flow duration curves can be produced using the `plot_flow_duration()` function.

``` r
#plot_flow_duration(HYDAT = "08NM116",
#                   start_year = 1981,
#                   end_year = 2010)
```

### Analysis example: low-flow frequency analysis

This package also provides a function, `compute_frequency_analysis()`, to complete frequency analyses (using the same methods as [HEC-SSP](http://www.hec.usace.army.mil/software/hec-ssp/)). The default fitting distribution is 'log-Pearson Type III', but the 'weibull' distribution can also be used. Other default plotting and fitting methods are described in the function documentation. For this example, the 7-day low-flow (low-flow is default) quantiles are calculated for the Mission Creek hydrometric station using the 'log-Pearson Type III' distribution. With this, several low-flow indicators can be determined (i.e. 7Q5, 7Q10).

``` r
#compute_frequency_analysis(HYDAT = "08NM116",
#                           start_year = 1981,
#                           end_year = 2010,
#                           rolling_days=7)[5]
```

Project Status
--------------

This package is under development. This package is maintained by the Water Protection and Sustainability Branch of the [British Columbia Ministry of Environment and Climate Change Strategy](https://www2.gov.bc.ca/gov/content/environment/air-land-water/water).

Getting Help or Reporting an Issue
----------------------------------

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/fasstr/issues/).

How to Contribute
-----------------

If you would like to contribute to the package, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

License
-------

    Copyright 2017 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at 

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
