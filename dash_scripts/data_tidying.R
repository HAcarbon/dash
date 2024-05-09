# preparing raw data for anaysis

library(lubridate)
library(tidyverse)
library(readxl)
library(stringr) 
library(glue)
library(sjmisc)

# create list of files in raw_data folder
raw_data_files_list <- list.files(path = "raw_data/agrecalc_output") 
raw_data_file_path <-  "raw_data/agrecalc_output/"

# step 1: Import data 

data_2023 <- read_excel("raw_data/agrecalc_output/2023_results.xlsx", skip = 1, col_names = TRUE)

data_2022 <- read_excel("raw_data/agrecalc_output/2022_results.xlsx", skip = 1, col_names = TRUE)

# step 2: Make data tidy 

  
c_2023 <- data_2023 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
          cn = TRUE) %>% # # taking the information in the first column in carbon_2021 and ensuring they are used as column headers
  mutate(year = "2023", # adding the year column to the dataset - set manually as 2021
         .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise'))  %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
mutate(across(c(farm_area, co2_dir_emissions_diesel_kgco2e:emissions_per_adjusted_hectare_kgco2e_ha_sc), ~ as.numeric(.x))) %>% 
mutate(year = as.integer(year))  
# mutate(lineitem_code = str_to_sentence(lineitem_code)) %>%
  #glimpse()

c_2022 <- data_2022 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
            cn = TRUE) %>% # # taking the information in the first column in carbon_2021 and ensuring they are used as column headers
  mutate(year = "2022", # adding the year column to the dataset - set manually as 2021
         .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise'))  %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
  mutate(across(c(farm_area, co2_dir_emissions_diesel_kgco2e:emissions_per_adjusted_hectare_kgco2e_ha_sc), ~ as.numeric(.x))) %>% 
  mutate(year = as.integer(year)) 
 # mutate(lineitem_code = str_to_sentence(lineitem_code)) %>%


# Step 3: Combine data
carbon_data <- 
  rbind(c_2022, c_2023) 


## write to dataframe

is.data.frame(carbon_data) # ensuring that it is a dataframe before wrting to csv

write.csv(carbon_data, 
          "C:/Users/00776360/OneDrive - Harper Adams University/github_repos/dash/www/Carbon_data_comb.csv",
          row.names = FALSE) # writing to csv file
