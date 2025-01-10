

library(jsonlite)
library(dplyr)

url <- "https://d.meteostat.net/app/proxy/stations/daily?station=42367&start=2023-01-01&end=2023-12-31"

# Read the data directly from the URL
data <- fromJSON(url)

# Inspect the structure of the data
str(data)

extracted_data <- data$data

# Convert to data frame 
df <- as.data.frame(extracted_data)



# Remove the specified empty columns
clean_data <- df %>%
  select(-snow, -wpgt, -tsun)

# Convert relevant columns to numeric types
clean_data <- clean_data %>%
  mutate(
    tavg = as.numeric(as.character(tavg)),    # Average temperature
    tmin = as.numeric(as.character(tmin)),    # Minimum temperature
    tmax = as.numeric(as.character(tmax)),    # Maximum temperature
    prcp = as.numeric(as.character(prcp)),    # Precipitation
    wdir = as.numeric(as.character(wdir)),    # Wind direction
    wspd = as.numeric(as.character(wspd)),    # Wind speed
    pres = as.numeric(as.character(pres))     # Pressure
  )

# Rename columns
clean_data <- clean_data %>%
  rename(
    Average_Temperature = tavg,  # Average temperature
    Minimum_Temperature = tmin,   # Minimum temperature
    Maximum_Temperature = tmax,   # Maximum temperature
    Precipitation = prcp,         # Precipitation
    Wind_Direction = wdir,        # Wind direction
    Wind_Speed = wspd,            # Wind speed
    Air_Pressure = pres,              # Pressure
    
  )

# View the renamed columns
head(clean_data)
# Save the cleaned data as a CSV file
write.csv(clean_data, "Kanpur_23.csv", row.names = FALSE)
