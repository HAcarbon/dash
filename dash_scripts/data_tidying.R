# preparing raw data for analysis

library(lubridate)
library(tidyverse)
library(readxl)
library(stringr) 
library(glue)
library(sjmisc)
library(openxlsx)


# step 1: Import data 

data_2023 <- read_excel("raw_data/agrecalc_output/2023_results.xlsx", skip = 1, col_names = TRUE)

data_2022 <- read_excel("raw_data/agrecalc_output/2022_results.xlsx", skip = 1, col_names = TRUE)

data_dictionary <- read_xlsx("www/HAcarbon_master_2022.xlsx", sheet = 5)

other_dictionary <- read_xlsx("www/HAcarbon_master_2022.xlsx", sheet = 6) 

# step 2: Make data tidy 

### ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

### --- ADDING NEW YEAR DATA --- ###

# Ensure that the new output data file from Agrecalc is formatted as data_0000 (i.e., data_2022, data_2023, data_2024 etc.)
# Copy the below code and replace '0000' with the year of the data

# -- Input year here for c_0000 and data_0000
# c_0000 <- data_0000 %>%

#   rotate_df(rn = 'Enterprise', #original column names  added as  new column called 'Enterprise' (may not be needed nut helps to keep track)
#             cn = TRUE) %>% #   information in the first column  used as column headers
## --- Input year instead of '0000'
#   mutate(year = "0000", # adding the year column to the dataset - SET MANUALLY
#          .after = "report_id") %>% # making the year column show up after the 'report_id' column
#   select(-c('Enterprise'))  %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
#   mutate(across(c(farm_area, co2_dir_emissions_diesel_kgco2e:emissions_per_adjusted_hectare_kgco2e_ha_sc), ~ as.numeric(.x))) %>% 
#   mutate(year = as.integer(year))  

### ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
c_2023 <- data_2023 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
          cn = TRUE) %>% # # taking the information in the first column in carbon_2021 and ensuring they are used as column headers
  mutate(year = "2023", # adding the year column to the dataset - SET MANUALLY
         .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise'))  %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
mutate(across(c(farm_area, co2_dir_emissions_diesel_kgco2e:emissions_per_adjusted_hectare_kgco2e_ha_sc), ~ as.numeric(.x))) %>% 
mutate(year = as.integer(year))  
# mutate(lineitem_code = str_to_sentence(lineitem_code)) %>%
  #glimpse()

c_2022 <- data_2022 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
            cn = TRUE) %>% # # taking the information in the first column in carbon_2021 and ensuring they are used as column headers
  mutate(year = "2022", # adding the year column to the dataset - SET MANUALLY
         .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise'))  %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
  mutate(across(c(farm_area, co2_dir_emissions_diesel_kgco2e:emissions_per_adjusted_hectare_kgco2e_ha_sc), ~ as.numeric(.x))) %>% 
  mutate(year = as.integer(year)) 
 # mutate(lineitem_code = str_to_sentence(lineitem_code)) %>%


### ---  Step 3: Combine data --- ###
# --- WHEN ADDING NEW YEAR DATA ENSURE THAT YOU HAVE ADDED THE NEW DATAFRAME TO THE FOLLOWING CODE:
# --- (EG., carbon_data <- rbind(c_2022, c_2023, c_2024 ...))

carbon_data <- 
  rbind(c_2022, c_2023) 


### --- Step 4: Create thermogenic vs biogenic sources dataset --- ###

therm_bio_data <- carbon_data %>% 
  select(c(results_id:lineitem_code, starts_with("co2_"), starts_with("methane"), starts_with("nitrous"))) %>% 
  select(-c(ends_with("_sc"))) %>% 
  pivot_longer(cols=("co2_dir_emissions_diesel_kgco2e":"nitrous_oxide_total_kgco2e"), names_to = "variable", values_to = "co2e_kg") %>% 
  mutate(ghg_type = case_when(str_detect(variable, "co2_") ~ "Carbon Dioxide",
                              str_detect(variable, "methane") ~ "Methane",
                              str_detect(variable, "nitrous") ~ "Nitrous Oxide",
                              TRUE ~ "CHECK"
                              ), .after = lineitem_code) %>% 
  mutate(source_type = case_when(str_detect(variable, "co2_") ~ "Thermogenic",
                                 str_detect(variable, "methane") ~ "Biogenic",
                                 str_detect(variable, "nitrous") ~ "Combination", 
                                 TRUE ~ "CHECK"), .after = ghg_type) %>%
  mutate(contribution = case_when(str_detect(variable, "total_k") ~ "Total", 
                                  str_detect(variable, "direct") ~ "Total",
                                  TRUE ~ "Partial"), .after = source_type)

# add a column for total co2e based on gwp100

# add a column for reverse engineering gwp100 to calculate gwp*



### --- *** IMPORTANT *** --- ###
### --- When you add new data - make sure you then rune the 'creating_excel_file.R script' ---# 
#source("dash_scripts/creating_excel_file.R")
