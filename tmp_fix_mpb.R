library(openxlsx)
wb <- loadWorkbook("tables/water/phytoplankton_parameters.xlsx")
df <- read.xlsx(wb, sheet = 1)

# Change column name from PFT1 to MPB
names(df)[which(names(df) == "PFT1")] <- "MPB"

# Find the last row (benthic zones) and replace "…" with "see Appendix B"
last_row <- nrow(df)
cat("Last row value:", df[last_row, "MPB"], "\n")
df[last_row, "MPB"] <- "see Appendix B"

# Write back
writeData(wb, sheet = 1, x = df, startRow = 1, colNames = TRUE)
saveWorkbook(wb, "tables/water/phytoplankton_parameters.xlsx", overwrite = TRUE)
cat("Done\n")
