# data wrangling

 carbon_data <- carbon_data_master %>% 
   mutate(data = rowMeans(carbon_data_master[,6:73])) %>% 
   mutate(data = case_when(data >0 ~ "Y",
                           TRUE ~ "N")) %>%
   mutate(across(c(data), ~as.factor(.x))) %>% 
   filter(data == "Y") %>%
   select(-data)


my_comma <-
  scales::label_comma(accuracy = .1,
                      big.mark = ",",
                      decimal.mark = ".")


### creating summary stats

latest_year <- max(carbon_data$year)
previous_year = latest_year - 1
s_cur_year <- latest_year-2000
s_prev_year <- previous_year - 2000

current_net_co2e <- as.numeric(as.list(
  carbon_data %>%
    filter(lineitem_code == "WHOLE_FARM" & year == latest_year) %>%
    select(year, lineitem_code, net_emissions_from_land_use) %>%
    select(net_emissions_from_land_use)
)[[1]]) / 1000000

co2e <- expression(Kt ~ CO ~ "[2]" ~ e)

tot_co2e_current <-
  as.numeric(
    as.list(
      carbon_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>%
        select(year, total_co2e_emissions_from_farming_kgco2e) %>%
        group_by(year) %>%
        summarise(total_co2e = sum(
          total_co2e_emissions_from_farming_kgco2e
        )) %>%
        filter(year == latest_year) %>%
        select(total_co2e)
    )[[1]]
  ) / 1000000

tot_co2e_prev <-
  as.numeric(
    as.list(
      carbon_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>%
        select(year, total_co2e_emissions_from_farming_kgco2e) %>%
        group_by(year) %>%
        summarise(total_co2e = sum(
          total_co2e_emissions_from_farming_kgco2e
        )) %>%
        filter(year == previous_year) %>%
        select(total_co2e)
    )[[1]]
  ) / 1000000

tot_co2e_20 <-
  as.numeric(
    as.list(
      carbon_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>%
        select(year, total_co2e_emissions_from_farming_kgco2e) %>%
        
        group_by(year) %>%
        summarise(total_co2e = sum(
          total_co2e_emissions_from_farming_kgco2e
        )) %>%
        filter(year == "2020") %>%
        select(total_co2e)
    )[[1]]
  ) / 1000000

carbon_reduction_current_previous <-
  tot_co2e_current - tot_co2e_prev

an_seq_forest_hedge_current <-
  as.numeric(as.list(
    carbon_data %>%
      filter(lineitem_code == "WHOLE_FARM") %>%
      group_by(year) %>%
      summarise(
        tot_forest = sum(sequestration_by_forestry),
        tot_hedge = sum(sequestration_by_hedges),
        tot_seq = tot_forest + tot_hedge
      ) %>%
      filter(year == latest_year) %>%
      select(tot_seq)
  )[[1]]) / 1000000

### net emission per kg output 

latest_net_per_kg <- as.numeric(as.list(carbon_data %>% 
  filter(lineitem_code=="WHOLE_FARM") %>% 
  select(year, emissions_per_unit_of_output_kgco2e_kg_output) %>% 
  filter(year == latest_year) %>%
  select(emissions_per_unit_of_output_kgco2e_kg_output) ))

prev_net_per_kg <- as.numeric(as.list(carbon_data %>% 
                                          filter(lineitem_code=="WHOLE_FARM") %>% 
                                          select(year, emissions_per_unit_of_output_kgco2e_kg_output) %>% 
                                          filter(year == previous_year) %>%
                                          select(emissions_per_unit_of_output_kgco2e_kg_output) ))


latest_net<- as.numeric(as.list(carbon_data %>% 
                                          filter(lineitem_code=="WHOLE_FARM") %>% 
                                          select(year, net_emissions_from_land_use) %>% 
                                          filter(year == latest_year) %>%
                                          select(net_emissions_from_land_use) ))

prev_net <- as.numeric(as.list(carbon_data %>% 
                                        filter(lineitem_code=="WHOLE_FARM") %>% 
                                        select(year, net_emissions_from_land_use) %>% 
                                        filter(year == previous_year) %>%
                                        select(net_emissions_from_land_use) ))

net_per_kg_reduction <- latest_net_per_kg-prev_net_per_kg

### detailed GHG data prep

c_data <-
  carbon_data %>% 
  select(c(results_id:total_co2e_emissions_from_farming_kgco2e)) %>%
  pivot_longer(-c(results_id:lineitem_code), names_to = "variables", values_to = "values" ) %>%
  select(-farm_area) %>%
  mutate(
    ghg_name_main = case_when(
      str_detect(variables, "co2_dir_e") ~ "CO2",
      str_detect(variables, "co2_direct") ~ "CO2",
      str_detect(variables, "co2_dir_ind") ~ "CO2",
      str_detect(variables, "co2_indirect") ~ "CO2",
      str_detect(variables, "co2_total") ~ "CO2",
      str_detect(variables, "methane_") ~ "Methane",
      str_detect(variables, "nitrous_oxide_") ~ "Nitrous oxide",
      str_detect(variables, "carbon_seq_") ~ "carbon seq",
      str_detect(variables, "co2e_") ~ "co2e"
    ),
    ghg_name_detail = case_when(
      str_detect(variables, "co2_dir_e") ~ "Direct CO2",
      str_detect(variables, "co2_direct") ~ "Direct CO2",
      str_detect(variables, "co2_dir_ind") ~ "Indirect CO2",
      str_detect(variables, "co2_indirect") ~ "Indirect CO2",
      str_detect(variables, "co2_total") ~ "Total CO2",
      str_detect(variables, "methane_") ~ "Methane",
      str_detect(variables, "nitrous_oxide_") ~ "Nitrous oxide",
      str_detect(variables, "carbon_seq_") ~ "Carbon seq",
      str_detect(variables, "co2e_") ~ "CO2e"
    ),
    ghg_summary = case_when(
      str_detect(variables, "total") ~ "total",
      str_detect(variables, "co2_direct") ~ "total",
      str_detect(variables, "co2_indirect") ~ "total",
      TRUE ~ "measure"
    ))


### --- source data

tot_thermo_current <- 
  as.numeric(
    as.list(
      source_type_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>% 
        filter(contribution == "Total") %>% 
        filter(source_type == "Thermogenic") %>% 
        select(year, co2e_kg) %>% 
        group_by(year) %>% 
        summarise(total_co2e_kg = sum(co2e_kg)) %>% 
        filter(year == latest_year) %>%
        select(total_co2e_kg)
    )[[1]]
  ) / 1000000

tot_bio_current <-
  as.numeric(
    as.list(
      source_type_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>% 
        filter(contribution == "Total") %>% 
        filter(source_type == "Biogenic") %>% 
        select(year, co2e_kg) %>% 
        group_by(year) %>% 
        summarise(total_co2e_kg = sum(co2e_kg)) %>% 
        filter(year == latest_year) %>%
        select(total_co2e_kg) 
    )[[1]]
  ) / 1000000
  
tot_other_current <-
  as.numeric(
    as.list(
      source_type_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>% 
        filter(contribution == "Total") %>% 
        filter(source_type == "Combination") %>% 
        select(year, co2e_kg) %>% 
        group_by(year) %>% 
        summarise(total_co2e_kg = sum(co2e_kg)) %>% 
        filter(year == latest_year) %>%
        select(total_co2e_kg) 
    )[[1]]
  ) / 1000000

source_data_wf <- source_type_data %>%
  filter(lineitem_code == 'WHOLE_FARM') %>% 
  filter(contribution == 'Total') %>% 
  mutate(co2e_kT = co2e_kg/1000000) %>%
  group_by(year,source_type) %>%
  summarise(
    co2e_kT_type_tot = sum(co2e_kT)
  ) %>% 
  ungroup() %>%
  group_by(year) %>%
  mutate(co2e_kt_tot = sum(co2e_kT_type_tot)) %>%
  ungroup() %>%
  mutate(prop_contrib = co2e_kT_type_tot/co2e_kt_tot,
         percent_contri = prop_contrib*100) 

source_data_sector <- 
  source_type_data %>%
  filter(lineitem_code != "WHOLE_FARM") %>%
  filter(contribution == 'Total') %>%  
  mutate(co2e_kT = co2e_kg/1000000) %>% 
    group_by(year,  lineitem_code, source_type,) %>%
    summarise(
      co2e_kt_sect = sum(co2e_kT),
      ) %>% 
    ungroup() %>%
    group_by(year, lineitem_code) %>%
    mutate(sect_tot = sum(co2e_kt_sect),
           sect_prop = co2e_kt_sect/sect_tot) %>% 
    ungroup() %>%
    group_by(year, source_type) %>%
    mutate(source_tot = sum(co2e_kt_sect),
           sourc_prop = co2e_kt_sect/source_tot) 
