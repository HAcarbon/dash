# load data
#source("dash_scripts/data_tidying.R")

carbon_data_master <- read_excel("www/HA_carbon_emission_data.xlsx", sheet = 1) %>%
  mutate(lineitem_code = factor(
    lineitem_code)) #,
 #   levels = c("DAIRY", "BEEF", "PIGS", "SHEEP", "WHOLE_FARM")
#  )) 

source_type_data <- read_excel("www/HA_carbon_emission_data.xlsx", sheet = 2)

data_dict <- read_xlsx("www/HA_carbon_emission_data.xlsx", sheet = 3)

other_dict <- read_xlsx("www/HA_carbon_emission_data.xlsx", sheet = 4) 
