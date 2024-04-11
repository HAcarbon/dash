# --- Carbon data wrangling ---
# --- Author: Megan Lewis ---
# --- Date: 2024-02-12 ---
# --- last updated: 2024-02-13 ---

#Goal: Take the output results of the carbon calculations and put them into a tidy format
# one variable equals on column, one row equals one observation. 

library(tidyverse)
library(sjmisc)

# import data 
carbon_20 <- read.csv("carbon_2020.csv")

carbon_21 <- read_csv("carbon_2021.csv")
glimpse(carbon_21)

carbon_22 <- read_csv("carbon_2022.csv")
glimpse(carbon_22)

# Step 1 - transpose data so that variables are along the top ----

## 2020 data 

c_20 <- 
  carbon_20 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
            cn = TRUE) %>% # # taking the information in the first column in carbon_2021 and ensuring they are used as column headers
  mutate(Year = "2020", # adding the year column to the dataset - set manually as 2021
         .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise')) # %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
view(c_20)
glimpse(c_20)
  
## 2021 data
c_21 <- 
  carbon_21 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
            cn = TRUE) %>% # # taking the information in the first column in carbon_2021 and ensuring they are used as column headers
    mutate(Year = "2021", # adding the year column to the dataset - set manually as 2021
           .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise')) # %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
  view()

glimpse(c_21)


# 2022 data
c_22 <- 
carbon_22 %>%
  rotate_df(rn = 'Enterprise', # ensuring the original column names are added as a new column called 'Enterprise' (may not be needed nut helps to keep track)
            cn = TRUE) %>% # taking the information in the first column in carbon_2022 and ensuring they are used as column headers
  mutate(Year = "2022", # adding the year column to the dataset - set manually as 2022 %>%
         .after = "report_id") %>% # making the year column show up after the 'report_id' column
  select(-c('Enterprise')) # %>% # removing column as it is surplus to the data set ( a copy of lineitem_code)
  view()
glimpse(c_22)
 

# Step 2 - combine the data together to create one spreadsheet ----

 carbon_data <- 
  rbind(c_20, c_21, c_22) #%>% # essentially adding the data from c_22 to the bottom of c_21
  view()
  
  glimpse(carbon_data)
  
  
is.data.frame(carbon_data) # ensuring that it is a dataframe before wrting to csv

write.csv(carbon_data, 
          "C:/Users/Megan/OneDrive/Documents/Carbon_data/Carbon_data_comb.csv",
          row.names = FALSE) # writing to csv file





  


