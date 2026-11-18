library(here)
library(gtsummary)

here::i_am("scripts/01_make_table1.R")

# Load data
raw_data <- read.csv(
  here::here("data", "raw", "CDC_Wastewater_Data_for_SARS-CoV-2_GA.csv"),
  stringsAsFactors = FALSE
)

# Clean numeric variables
raw_data$pcr_target_avg_conc <- as.numeric(gsub(",", "", raw_data$pcr_target_avg_conc))
raw_data$population_served   <- as.numeric(gsub(",", "", raw_data$population_served))
raw_data$flow_rate           <- as.numeric(raw_data$flow_rate)

# Subset only the columns needed for Table 1
table_data <- raw_data[, c("counties_served", "pcr_target_avg_conc", "flow_rate", "population_served")]

# Create Table 1 stratified by county
table1 <- tbl_summary(
  data = table_data,
  by = counties_served,
  type = list(
    c(pcr_target_avg_conc, flow_rate, population_served) ~ "continuous2"
  ),
  statistic = list(
    all_continuous() ~ c("{mean} ({sd})", "{median} ({p25}, {p75})")
  ),
  label = list(
    pcr_target_avg_conc ~ "SARS-CoV-2 Viral Concentration (copies)",
    flow_rate           ~ "Wastewater Flow Rate",
    population_served   ~ "Population Served"
  ),
  missing_text = "Missing (N/A)"
)

# Add overall column, sample counts/percentages (n, %) in headers, and title
table1 <- add_overall(table1)
table1 <- modify_header(
  table1,
  stat_0 ~ "**Overall**<br>N = {style_number(N)} (100%)",
  all_stat_cols(stat_0 = FALSE) ~ "**{level}**<br>n = {style_number(n)} ({style_percent(p)}%)"
)
table1 <- modify_spanning_header(
  table1,
  all_stat_cols() ~ "**Georgia County (n, % of Total Samples)**"
)
table1 <- modify_caption(
  table1,
  "**Table 1. Descriptive Statistics of Georgia Wastewater Surveillance Sites by County**"
)

# Save output
saveRDS(
  table1,
  file = here::here("output", "table1_summary.rds")
)