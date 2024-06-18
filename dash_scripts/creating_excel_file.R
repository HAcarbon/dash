### ---- Step 5: Creating master file to download ---- ###

source("dash_scripts/data_tidying.R")

# Create header style for excel doc
hs <- createStyle(textDecoration = "BOLD", fontColour = "#000000", fontSize = 12)

#Create list of "worksheet_names" and dataframes for each worksheet
dataset_names <- list('Carbon_GWP100' = carbon_data, 
                      'Thermo_vs_Bio' = therm_bio_data, 
                      'Data_dictionary' = data_dictionary, 
                      'Line_Item_dictionary' = other_dictionary)

# writing to an excel document
write.xlsx(dataset_names, file = './docs/data/HA_carbon_emission_data.xlsx', 
           colNames=TRUE, 
           headerStyle = hs,
           colWidths = c("auto", "auto","auto","auto"));
write.xlsx(dataset_names, file = './www/HA_carbon_emission_data.xlsx', 
           colNames=TRUE, 
           headerStyle = hs,
           colWidths = c("auto", "auto","auto","auto"))

