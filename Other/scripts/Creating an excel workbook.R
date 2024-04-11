# export data dictionary dataframe to csv file to fill out 
library(openxlsx)
library(ggplot2)


# ---  I am not quite a fan of this as I can't get the aesthetics to work properly, but it will do for now

headerStyle1 <- createStyle(fontSize = 12, fontColour = "black",
                            fgFill = "lightcyan2",
                            border = "TopBottomLeftRight", borderColour = "black",
                            textDecoration = "bold", wrapText = TRUE)



wb <- createWorkbook() # create a workbook
modifyBaseFont(wb, fontSize = 11, fontColour = "black", fontName = "Calibri")


addWorksheet(wb, sheetName = "Variables", gridLines = TRUE) # creating first worksheet
addWorksheet(wb, sheetName = "Line_items", gridLines = TRUE) # creating second worksheet



writeDataTable(wb, sheet = "Variables", x = dd_carbon_var, headerStyle = headerStyle1) # adding data to worksheet 1
addStyle(wb, sheet = sheet = "Variables", style = headerStyle1, cols = 1:100, rows = 1:100)

writeDataTable(wb, sheet = "Line_items", x = dd_carbon_items) # adding data to worksheet 2
addStyle(wb, sheet = "Line_items", style = style, cols = 1:100, rows = 1:100)

saveWorkbook(wb, "Carbon_data_dictionary.xlsx", overwrite = TRUE) #saving workbook

  
