# Create a data dictionary ---

dd_carbon_var <-
  carbon_data %>% 
  rotate_df(rn = "variables") %>% 
  select("variables") %>% 
  add_column(variable_name ='', 
             measurement_unit = '', 
             allowed_values = '', 
             description = '') # %>% 
view()


dd_carbon_items <- 
  carbon_data %>% 
  select(lineitem_code) %>%
  distinct() %>% 
  add_column(variable_name ='', 
             description = '')  #%>% 
view(dd_carbon_items)

write.csv(dd_carbon_items, 
          "C:/Users/Megan/OneDrive/Documents/Carbon_data/dd_items.csv",
          row.names = FALSE) # writing to csv file
