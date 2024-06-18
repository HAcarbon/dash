# colour pallettes


sector_pal <- c("#E69F00", 
                "#56B4E9", 
                "#009E73", 
                "#F0E442",
                "#0072B2",
                "#D55E00",
                "#CC79A7") # can add more if needed later))

ghgpal <- c("#FE6100", 
            "#FFB000", 
            "#785EF0", 
            "#DC267F")

dir_pal <- c("darkorange", 
             "orangered", 
             "indianred4", 
             "firebrick", 
             "tan3" ) # dark orange

indir_pal <- c("lightsalmon",
               "orange",
               "coral",  
               "chocolate1", 
               "sienna3", 
               "tomato3" ,
               "lightsalmon3", 
               "orange3", 
               "tomato",  
               "tan") # light orange

ch4_pal <-c("mediumorchid4",
            "mediumorchid1") # purpleblue

n2o_pal <- c("maroon3",
             "hotpink",
             "lightpink") #pink purple

### --- Detail co2e emission --- ###

detail_ghg_pal <- c("darkorange", 
                    "orangered",
                    "indianred4", 
                    "firebrick", 
                    "tan3",# direct carbon
                    "lightsalmon",
                    "orange",
                    "coral",
                    "chocolate1", 
                    "sienna3",
                    "tomato3" ,
                    "lightsalmon3",
                    "orange3",
                    "tomato", 
                    "tan", # indirect carbon light orange
                    "mediumorchid4",
                    "mediumorchid1", # methane purpleblue
                    "maroon3",
                    "hotpink",
                    "lightpink") # n2o pink purple



detail_labels <- list("Diesel", 
                      "Electricity", 
                      "Other fuels",
                      "Renewable electricity",
                      "Renewable heat",
                      "Bedding", 
                      "Biochar", 
                      "Disposal of carcasses", 
                      "Feed", 
                      "Fertiliser", 
                      "Lime", 
                      "Pesticides", 
                      "Refrigerant losses", 
                      "Transport", "Waste",
                      "Fermentation, feed & digestion",
                      "Manure management",
                      "Inorganic & imported organic manure",
                      "Grazing manure management", 
                      "Veg & crop N residues")

detail_limits <- list("co2_dir_emissions_diesel_kgco2e", 
                      "co2_dir_emissions_electricity_kgco2e",
                      "co2_dir_emissions_other_fuels_kgco2e", 
                      "co2_dir_emissions_renewable_electricity_kgco2e",
                      "co2_dir_emissions_renewable_heat_kgco2e",
                      "co2_dir_ind_emissions_bedding_kgco2e",
                      "co2_dir_ind_emissions_biochar_kgco2e",
                      "co2_dir_ind_emissions_disposal_of_carcasses_kgco2e",
                      "co2_dir_ind_emissions_feed_kgco2e",
                      "co2_dir_ind_emissions_fertiliser_kgco2e",
                      "co2_dir_ind_emissions_lime_kgco2e",
                      "co2_dir_ind_emissions_pesticides_kgco2e",
                      "co2_dir_ind_emissions_refrigerant_losses_kgco2e",
                      "co2_dir_ind_emissions_transport_kgco2e",
                      "co2_dir_ind_emissions_waste_kgco2e",
                      "methane_enteric_fermentation_feed_digestion_kgco2e",
                      "methane_enteric_manure_mgmt_kgco2e",
                      "nitrous_oxide_vol_inorganic_and_imp_org_man_soil_kgco2e",
                      "nitrous_oxide_vol_grazing_dep_man_mgmt_org_man_soil_kgco2e",
                      "nitrous_oxide_veg_crop_n_residues_kgco2e")

### --- Thermo vs Bio sources --- ###

emission_source_pal <- c("#a7bf16", "#628e20", "#407076")

emission_source_labels <- list("Biogenic", "Thermogenic", "Combination")
emission_source_limits <- list("Biogenic", "Thermogenic", "Combination")
