# DATA 550 Midterm Project -  CDC SARS-CoV2 wastewater surveillance

This project aims to analyze temporal and spatial trends in CDC SARS-CoV2 wastewater surveillance in Georgia. We aim to create a reproducible workflow where a user can efficiently generate descriptive statistics and an informative figure from the data.

# Objectives

- Develop a summary table (table1_summary.rds) stratified by Georgia public health district/county (columns) that summarizes key wastewater surveillance variables (rows).

  - Specifically, the table will display total sample counts (n, %) alongside continuous measures (mean, SD, median, and IQR) for SARS-CoV-2 viral concentration levels, flow rates, and population served across the sampling sites.

- Develop a time-series line graph (fig1_trends.png) illustrating longitudinal trends in SARS-CoV-2 wastewater pathogen concentration over time.

  - The x-axis will display the sample collection date, the y-axis will show normalized viral concentration levels, and separate colored trend lines (or facets) will compare trajectories across the top five sampling locations/counties in Georgia.

# Structure

The repository has the following structure:

- `data/raw/`: Stores the original, unmodified dataset.

- `data/processed/`: Stores filtered and cleaned datasets used for analysis.

- `output/`: Stores generated outputs, specifically output/table1_summary.rds and output/fig1_trends.png.

- `scripts/`: Stores specific analysis code as well as miscellaneous code.

- The main repository root folder stores the final report (`report.Rmd` and the compiled `report.html` / `report.pdf`), alongside project management and configuration files:

  1.  `Makefile`: Automates the analysis workflow and report generation.

  2.  `.gitignore`: Specifies files and folders Git should ignore.

  3.  `config.yml`: Stores parameters and settings used to customize the analysis.

  4.  `README.md`: Provides an overview of the project, repository organization, and instructions for running the code.

# How To Use

The user must have:

- R and RStudio

- GNU Make

- The following R packages:

  - `here`

  - `gtsummary`

  - `ggplot2`

  - `tidyverse`

  - `renv`

To build the report, the user may first run `make clean` in the terminal to remove any lingering output files. Then, they may run `make`.

# Config and Report

`config.yml`  allows users to knit the final report as .html or .pdf based on the selected configuration parameter. The configuration file will also allow users to adjust data parameters, such as the sampling locations included or the range of possible dates, which will change the data summarized and presented in the final report.

R Markdown chunk options in `report.Rmd` allow the generation of a “development” version of the report that displays the underlying code with the corresponding tables, figures, and written interpretations and a “final” version that hides the code but keeps the results.
