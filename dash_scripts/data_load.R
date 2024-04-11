# load data

carbon_data <- read.csv("www/carbon_data_clean.csv") %>%
  mutate(lineitem_code = factor(
    lineitem_code,
    levels = c("DAIRY", "BEEF", "PIGS", "SHEEP", "WHOLE_FARM")
  ))

data_dict <- read_xlsx("www/HAcarbon_master_2022.xlsx", sheet = 5)

other_dict <- read_xlsx("www/HAcarbon_master_2022.xlsx", sheet = 6) 