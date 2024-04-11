#Combining 2020, 2021 and 2022 data
carbon_data <- 
  rbind(carbon_20, carbon_21, carbon_22) #%>% # essentially adding the data from c_22 to the bottom of c_21
view()

glimpse(carbon_data)


is.data.frame(carbon_data) # ensuring that it is a dataframe before wrting to csv

write.csv(carbon_data, 
          "C:/Users/00776360/OneDrive - Harper Adams University/Future Farm/Data/hau_carbon/data/carbon_data.csv",
          row.names = FALSE) # writing to csv file
