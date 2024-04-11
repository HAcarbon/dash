# data wrangling

my_comma <-
  scales::label_comma(accuracy = .1,
                      big.mark = ",",
                      decimal.mark = ".")


### creating summary stats

latest_year <- max(carbon_data$Year)
previous_year = latest_year - 1
s_cur_year <- latest_year-2000
s_prev_year <- previous_year - 2000

current_net_co2e <- as.numeric(as.list(
  carbon_data %>%
    filter(lineitem_code == "WHOLE_FARM" & Year == latest_year) %>%
    select(Year, lineitem_code, net_emissions_from_land_use) %>%
    select(net_emissions_from_land_use)
)[[1]]) / 1000000

co2e <- expression(Kt ~ CO ~ "[2]" ~ e)

tot_co2e_current <-
  as.numeric(
    as.list(
      carbon_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>%
        select(Year, total_co2e_emissions_from_farming_kgco2e) %>%
        group_by(Year) %>%
        summarise(total_co2e = sum(
          total_co2e_emissions_from_farming_kgco2e
        )) %>%
        filter(Year == latest_year) %>%
        select(total_co2e)
    )[[1]]
  ) / 1000000

tot_co2e_prev <-
  as.numeric(
    as.list(
      carbon_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>%
        select(Year, total_co2e_emissions_from_farming_kgco2e) %>%
        group_by(Year) %>%
        summarise(total_co2e = sum(
          total_co2e_emissions_from_farming_kgco2e
        )) %>%
        filter(Year == previous_year) %>%
        select(total_co2e)
    )[[1]]
  ) / 1000000

tot_co2e_20 <-
  as.numeric(
    as.list(
      carbon_data %>%
        filter(lineitem_code == "WHOLE_FARM") %>%
        select(Year, total_co2e_emissions_from_farming_kgco2e) %>%
        
        group_by(Year) %>%
        summarise(total_co2e = sum(
          total_co2e_emissions_from_farming_kgco2e
        )) %>%
        filter(Year == "2020") %>%
        select(total_co2e)
    )[[1]]
  ) / 1000000

carbon_reduction_current_previous <-
  tot_co2e_current - tot_co2e_prev

an_seq_forest_hedge_current <-
  as.numeric(as.list(
    carbon_data %>%
      filter(lineitem_code == "WHOLE_FARM") %>%
      group_by(Year) %>%
      summarise(
        tot_forest = sum(sequestration_by_forestry),
        tot_hedge = sum(sequestration_by_hedges),
        tot_seq = tot_forest + tot_hedge
      ) %>%
      filter(Year == latest_year) %>%
      select(tot_seq)
  )[[1]]) / 1000000





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
