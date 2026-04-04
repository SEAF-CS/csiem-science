library(openxlsx)
wb <- createWorkbook()
addWorksheet(wb, "turbidity_coefficients")

df <- data.frame(
  Table = rep("Turbidity", 3),
  Group = rep("Turbidity Coefficients", 3),
  Parameter = c(
    "f_{t_{ss}}",
    "f_{t_{pom}}",
    "f_{t_{phy}}"
  ),
  Description = c(
    "Coefficient between turbidity and suspended solids",
    "Coefficient between turbidity and POC",
    "Coefficient between turbidity and algae"
  ),
  Unit = c(
    "NTU\\:(g\\:m^{-3})^{-1}",
    "NTU\\:(mmol\\:C\\:m^{-3})^{-1}",
    "NTU\\:(mmol\\:C\\:m^{-3})^{-1}"
  ),
  Value = c(
    "0.33",
    "0.0099",
    "0.003"
  ),
  Comment = c(
    "Chesapeake: Gallegos and Moore (2000); Gallegos (2001) Fig. 2b; Cockburn: Wilson and Wienczugow (2025) = 0.359 across CSOA",
    "Chesapeake: Gallegos (2001) found POC ~ 40%% POM (TVSS), so 0.33 / 0.4 = 0.825 NTU (g POC /m3)-1",
    "Based on a typical literature range of 0.01-0.05 NTU per ug Chl-a /L (0.0024-0.012 NTU / mmol C /m3)"
  ),
  stringsAsFactors = FALSE,
  check.names = FALSE
)

writeData(wb, sheet = 1, x = df)
saveWorkbook(wb, "tables/water/turbidity_coefficients.xlsx", overwrite = TRUE)
cat("Created turbidity_coefficients.xlsx\n")
