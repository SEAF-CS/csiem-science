library(openxlsx)
wb <- createWorkbook()
addWorksheet(wb, "state_variables")

Abbreviation <- c(
  # Physical variables (4)
  "U, V, W", "T", "S", "EC",
  # Light variables (4)
  "I_{PAR}", "K_d", "E_\\lambda", "\\kappa_\\lambda",
  # Biogeochemical variables (15)
  "DO", "RSi", "FRP", "PIP",
  "NH_4^+", "NO_3^-",
  "DOC", "DON", "DOP",
  "POC", "PON", "POP",
  "TP", "TN",
  # Planktonic variables (6) -- note: updated group names from model truth
  "PHY_{mixed}", "PHY_{pico}", "PHY_{diatom}", "PHY_{dino}",
  "TCHLA",
  # Sediment & Turbidity (2)
  "SS", "Turbidity",
  # Benthic & Habitat variables (5)
  "MPB", "MAC_A", "MAC_B", "MAC_F", "HSI"
)

Unit <- c(
  "m/s", "^{\\circ}C", "psu", "\\mu S\\: cm^{-1}",
  "\\mu E\\: m^{-2}\\: s^{-1}", "m^{-1}", "W\\: m^{-2}", "m^{-1}",
  "mmol\\: O_2\\: m^{-3}", "mmol\\: Si\\: m^{-3}", "mmol\\: P\\: m^{-3}", "mmol\\: P\\: m^{-3}",
  "mmol\\: N\\: m^{-3}", "mmol\\: N\\: m^{-3}",
  "mmol\\: C\\: m^{-3}", "mmol\\: N\\: m^{-3}", "mmol\\: P\\: m^{-3}",
  "mmol\\: C\\: m^{-3}", "mmol\\: N\\: m^{-3}", "mmol\\: P\\: m^{-3}",
  "mmol\\: P\\: m^{-3}", "mmol\\: N\\: m^{-3}",
  "mmol\\: C\\: m^{-3}", "mmol\\: C\\: m^{-3}", "mmol\\: C\\: m^{-3}", "mmol\\: C\\: m^{-3}",
  "\\mu g\\: L^{-1}",
  "g\\: SS\\: m^{-3}", "NTU",
  "mmol\\: C\\: m^{-2}", "mmol\\: C\\: m^{-2}", "mmol\\: C\\: m^{-2}", "mmol\\: C\\: m^{-2}", "-"
)

CommonName <- c(
  "Current velocity", "Temperature", "Salinity", "Electrical conductivity",
  "PAR light intensity", "PAR extinction coefficient", "Spectral light energy", "Bandwidth-specific attenuation",
  "Dissolved oxygen", "Reactive silica", "Filterable reactive phosphorus", "Particulate inorganic phosphorus",
  "Ammonium", "Nitrate",
  "Dissolved organic carbon", "Dissolved organic nitrogen", "Dissolved organic phosphorus",
  "Particulate organic carbon", "Particulate organic nitrogen", "Particulate organic phosphorus",
  "Total phosphorus", "Total nitrogen",
  "Mixed phytoplankton", "Picophytoplankton", "Diatoms", "Dinoflagellates",
  "Total chlorophyll-a",
  "Suspended sediment", "Turbidity",
  "Benthic microalgae (MPB)", "Above-ground seagrass biomass", "Below-ground seagrass biomass", "Seagrass seed biomass",
  "Posidonia seagrass habitat suitability index"
)

ProcessDescription <- c(
  "Velocities simulated by the hydrodynamic model, subject to boundary forcing",
  "Temperature dynamics subject to surface heating and cooling",
  "Salinity dynamics subject to inputs, rainfall dilution and evapo-concentration",
  "Derived from salinity variable",
  "Incident light attenuated as a function of depth",
  "Extinction coefficient based on chl-a, organic matter and suspended solids",
  "Light spectra: incoming surface light and direct/diffuse below-water profiles",
  "Wavelength-specific attenuation through the water column",
  "Impacted by photosynthesis, organic decomposition, nitrification, surface exchange, and sediment oxygen demand",
  "Algal uptake, sediment flux",
  "Algal uptake, organic mineralisation, sediment flux",
  "Adsorption/desorption of/to free FRP",
  "Algal uptake, nitrification, organic mineralisation, sediment flux",
  "Algal uptake, nitrification, denitrification, sediment flux",
  "Mineralisation, algal mortality/excretion, photolysis",
  "Mineralisation, algal mortality/excretion, photolysis",
  "Mineralisation, algal mortality/excretion, photolysis",
  "Breakdown, settling, algal mortality/excretion",
  "Breakdown, settling, algal mortality/excretion",
  "Breakdown, settling, algal mortality/excretion",
  "Sum of all phosphorus state variables",
  "Sum of all nitrogen state variables",
  "Photosynthesis, nutrient uptake, respiration, sedimentation",
  "Photosynthesis, nutrient uptake, respiration, sedimentation",
  "Photosynthesis, nutrient uptake, respiration, sedimentation",
  "Photosynthesis, nutrient uptake, respiration, sedimentation",
  "Sum of planktonic algal groups, converted to chlorophyll-a",
  "Sedimentation, resuspension",
  "Derived from particulate components in suspension",
  "Benthic photosynthesis and respiration",
  "Benthic photosynthesis, nutrient uptake, respiration",
  "Root growth, respiration",
  "Benthic photosynthesis, nutrient uptake, respiration",
  "Composite index based on light, temperature, substrate, wave stress, current stress"
)

Notes <- c(
  "<a href='hydrodynamics.html'>Chapter 7</a>",
  "<a href='hydrodynamics.html'>Chapter 7</a>",
  "<a href='hydrodynamics.html'>Chapter 7</a>",
  "<a href='hydrodynamics.html'>Chapter 7</a>",
  "<a href='light-climate.html'>Chapter 13</a>",
  "<a href='light-climate.html'>Chapter 13</a>",
  "<a href='light-climate.html'>Chapter 13</a>",
  "<a href='light-climate.html'>Chapter 13</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>",
  "<a href='bgc-model.html'>Chapter 11</a>; <a href='benthic.html'>Chapter 14</a>",
  "<a href='benthic.html'>Chapter 14</a>",
  "<a href='benthic.html'>Chapter 14</a>",
  "<a href='benthic.html'>Chapter 14</a>",
  "<a href='habitat.html'>Chapter 15</a>"
)

Group <- c(
  rep("Physical variables", 4),
  rep("Light variables", 4),
  rep("Biogeochemical variables", 14),
  rep("Planktonic variables", 5),
  rep("Sediment & Turbidity", 2),
  rep("Benthic & Habitat variables", 5)
)

df <- data.frame(
  Table = rep("StateVars", length(Abbreviation)),
  Group = Group,
  Abbreviation = Abbreviation,
  Unit = Unit,
  CommonName = CommonName,
  ProcessDescription = ProcessDescription,
  Notes = Notes,
  stringsAsFactors = FALSE
)
names(df) <- c("Table", "Group", "Abbreviation", "Unit", "Common Name", "Process Description", "Notes")

writeData(wb, sheet = 1, x = df)
saveWorkbook(wb, "tables/state_variables.xlsx", overwrite = TRUE)
cat("Created state_variables.xlsx with", nrow(df), "rows\n")
