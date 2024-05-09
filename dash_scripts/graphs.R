```{r}
#| title: Direct carbon 
#| fig-cap: The total annual direct (Scope 1) carbon emissions produced from each livestock sector of the Harper Adams Future Farm for the years 2020 to 2022. Colours indicate the individual sources of direct carbon emissions. Equivalent emissions were calculated using the [IPCC AR5](https://ar5-syr.ipcc.ch/ipcc/ipcc/resources/pdf/IPCC_SynthesisReport.pdf) guidelines on Global Warming Potential (GWP) equivalents. 




c_data %>% 
  #filter(lineitem_code == "DAIRY") %>% # 
  filter(lineitem_code != "WHOLE_FARM") %>%
  filter(ghg_summary == "measure") %>% 
  filter(ghg_name_detail == "Direct CO2") %>% 
  ggplot(aes(x = as.factor(year), y = values/1000000, fill = variables)) +
  geom_bar(position = "stack", stat = "identity") +
  scale_fill_manual(
    labels = c("Diesel", "Electricity", "Other fuels", "Renewable \nelectricity", "Renewable \nheat"),
    limits = c("co2_dir_emissions_diesel_kgco2e", "co2_dir_emissions_electricity_kgco2e", "co2_dir_emissions_other_fuels_kgco2e", "co2_dir_emissions_renewable_electricity_kgco2e", "co2_dir_emissions_renewable_heat_kgco2e"),
    values = dir_pal) +
  ylab(bquote(atop(bold(.(GHG~Emissions~(Kt~CO[2]~e)))))) +
  labs( x = "Year", fill = "Emissions source")+
  facet_wrap(~lineitem_code)+ 
  theme_bw()+
  theme_m.rl

```

```{r}
#| title: Indirect carbon
#| fig-cap: The total annual indirect (Scope 2) carbon emissions produced from each livestock sector of the Harper Adams Future Farm for the years 2020 to 2022. Colours indicate the individual sources of indirect carbon emissions. Equivalent emissions were calculated using the [IPCC AR5](https://ar5-syr.ipcc.ch/ipcc/ipcc/resources/pdf/IPCC_SynthesisReport.pdf) guidelines on Global Warming Potential (GWP) equivalents. 


# In theory I could get this to be interactive by replacing the filter bits with whatever is selected



c_data %>% 
  #filter(lineitem_code == "DAIRY") %>% # 
  filter(lineitem_code != "WHOLE_FARM") %>%
  filter(ghg_summary == "measure") %>% 
  filter(ghg_name_detail == "Indirect CO2") %>% 
  ggplot(aes(x = as.factor(year), y = values/1000000, fill = variables)) +
  geom_bar(position = "stack", stat = "identity") +
  scale_fill_manual(
    labels = c("Bedding", "Biochar", "Disposal of \ncarcasses", "Feed", "Fertiliser", "Lime", "Pesticides", "Refrigerant \nlosses", "Transport", "Waste"),
    limits = c("co2_dir_ind_emissions_bedding_kgco2e", "co2_dir_ind_emissions_biochar_kgco2e", "co2_dir_ind_emissions_disposal_of_carcasses_kgco2e", "co2_dir_ind_emissions_feed_kgco2e", "co2_dir_ind_emissions_fertiliser_kgco2e","co2_dir_ind_emissions_lime_kgco2e", "co2_dir_ind_emissions_pesticides_kgco2e", "co2_dir_ind_emissions_refrigerant_losses_kgco2e", "co2_dir_ind_emissions_transport_kgco2e", "co2_dir_ind_emissions_waste_kgco2e"),
    values = indir_pal) +
  ylab(bquote(atop(bold(.(GHG~Emissions~(Kt~CO[2]~e)))))) +
  labs( x = "Year", fill = "Emissions source")+
  facet_wrap(~lineitem_code)+ 
  theme_bw()+
  theme_m.rl

```

```{r}
#| title: Methane
#| fig-cap: The total annual methane emissions (as equivalent carbon dioxide) produced from each livestock sector of the Harper Adams Future Farm for the years 2022 to 2023. Colours indicate the individual sources of methane emissions. Equivalent emissions were calculated using the [IPCC AR5](https://ar5-syr.ipcc.ch/ipcc/ipcc/resources/pdf/IPCC_SynthesisReport.pdf) guidelines on Global Warming Potential (GWP) equivalents. 

# In theory I could get this to be interactive by replacing the filter bits with whatever is selected


c_data %>% 
  #filter(lineitem_code == "DAIRY") %>% # 
  filter(lineitem_code != "WHOLE_FARM") %>%
  filter(ghg_summary == "measure") %>% 
  filter(ghg_name_detail == "Methane") %>% 
  ggplot(aes(x = as.factor(year), y = values/1000000, fill = variables)) +
  geom_bar(position = "stack", stat = "identity") +
  scale_fill_manual(
    labels = c("Fermentation, feed \n & digestion", "Manure management"),
    limits = c("methane_enteric_fermentation_feed_digestion_kgco2e", "methane_enteric_manure_mgmt_kgco2e"),
    values = ch4_pal) +
  ylab(bquote(atop(bold(.(GHG~Emissions~(Kt~CO[2]~e)))))) +
  labs( x = "Year", fill = "Emissions source")+
  facet_wrap(~lineitem_code)+ 
  theme_bw()+
  theme_m.rl



```

```{r}
#| title: Nitrous oxide
#| fig-cap: The total annual nitrous oxide emissions (as equivalent carbon dioxide) produced from each livestock sector of the Harper Adams Future Farm for the years 2022 to 2023. Colours indicate the individual sources of nitrous oxide emissions. Equivalent emissions were calculated using the [IPCC AR5](https://ar5-syr.ipcc.ch/ipcc/ipcc/resources/pdf/IPCC_SynthesisReport.pdf) guidelines on Global Warming Potential (GWP) equivalents. 

c_data %>% 
  #filter(lineitem_code == "DAIRY") %>% # 
  filter(lineitem_code != "WHOLE_FARM") %>%
  filter(ghg_summary == "measure") %>% 
  filter(ghg_name_detail == "Nitrous oxide") %>% 
  ggplot(aes(x = as.factor(year), y = values/1000000, fill = variables)) +
  geom_bar(position = "stack", stat = "identity") +
  scale_fill_manual(
    labels = c("Inorganic and \nimported organic \nmanure", "Grazing manure \nmanagement", "Veg and crop \nN residues"),
    limits = c("nitrous_oxide_vol_inorganic_and_imp_org_man_soil_kgco2e", "nitrous_oxide_vol_grazing_dep_man_mgmt_org_man_soil_kgco2e", "nitrous_oxide_veg_crop_n_residues_kgco2e"),
    values = n2o_pal) +
  ylab(bquote(atop(bold(.(GHG~Emissions~(Kt~CO[2]~e)))))) +
  labs( x = "Year", fill = "Emissions source")+
  facet_wrap(~lineitem_code)+ 
  theme_bw()+
  theme_m.rl



```

