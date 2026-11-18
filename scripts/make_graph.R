here::i_am('scripts/make_scatterplot.R')

library(tidyverse)
library(ggplot2)

dat <- read_csv(
  here::here('data/raw/CDC_Wastewater_Data_for_SARS-CoV-2_GA.csv')
)


liquid <- dat |> 
  filter(counties_served %in% 
           c('Gwinnett', 'Richmond', 'Newton', 'Paulding', 'Cobb' )) |> 
  select(counties_served, sample_collect_date, 
         pcr_target_avg_conc, pcr_target_units, pcr_target_flowpop_lin) |> 
  mutate(sample_collect_date = as.Date(sample_collect_date)) |>
  group_by(counties_served, sample_collect_date) |>
  summarise(flowpop = mean(pcr_target_flowpop_lin), .groups = "drop")

ggplot(liquid,
       aes(x = sample_collect_date, y = flowpop, color = counties_served)) +
  geom_line(linewidth = 0.4, alpha = 0.5) +
  geom_smooth(se = FALSE, span = 0.1, linewidth = 0.9, method = "gam",
              formula = y ~ s(x, k = 30)) +
  scale_y_log10() +
  facet_wrap(~ counties_served, ncol = 1) +
  labs(x = "Sample collection date",
       y = "SARS-CoV-2 gene copies/person/day (log scale)",
       title = "Flow-population-normalized SARS-COV-2 PCR target concentrations 
       among GA counties over time ") +
  theme_minimal() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))

ggsave(here::here('output/figure1.png'), width = 9, height = 10, dpi = 300)


