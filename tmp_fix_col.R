library(openxlsx)
wb <- loadWorkbook("tables/water/phytoplankton_parameters.xlsx")
df <- read.xlsx(wb, sheet = 1)

# Revert column name back to PFT1
names(df)[which(names(df) == "MPB")] <- "PFT1"

writeData(wb, sheet = 1, x = df, startRow = 1, colNames = TRUE)
saveWorkbook(wb, "tables/water/phytoplankton_parameters.xlsx", overwrite = TRUE)
cat("Reverted to PFT1\n")
