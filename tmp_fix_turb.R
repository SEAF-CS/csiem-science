library(openxlsx)
wb <- loadWorkbook("tables/water/turbidity_coefficients.xlsx")
df <- read.xlsx(wb, sheet = 1)

cat("Current comments:\n")
for(i in 1:nrow(df)) cat(i, ":", df[i, "Comment"], "\n")

df[1, "Comment"] <- "<b>Chesapeake</b>: Gallegos and Moore (2000); Gallegos (2001) Fig. 2b; <b>Cockburn</b>: Wilson, C., & Wienczugow, K. (2025a) = 0.359 across CSOA"
df[2, "Comment"] <- "<b>Chesapeake</b>: Gallegos (2001) found POC ~ 40%% POM (TVSS), so 0.33 / 0.4 = 0.825 NTU (g POC /m3)-1"

writeData(wb, sheet = 1, x = df, startRow = 1, colNames = TRUE)
saveWorkbook(wb, "tables/water/turbidity_coefficients.xlsx", overwrite = TRUE)
cat("Done\n")
