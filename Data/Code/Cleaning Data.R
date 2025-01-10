# Loading Necessary Library
library(dplyr)
library(tidyverse)

# Loading the data set
Bang_22 <- read.csv("Bangalore_22.csv")
Bang_23 <- read.csv("Bangalore_23.csv")
Bang_24 <- read.csv("Bangalore_oct_24.csv")

# Merging the data set
Bangalore <- bind_rows(Bang_22,Bang_23,Bang_24)

# Cleaning the data set
Bangalore <- Bangalore %>% select(-snow, -wpgt, -tsun)
Bangalore <- Bangalore %>%
  mutate(prcp = replace_na(prcp, 0))
Bangalore <- Bangalore %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Bangalore, "Bangalore.csv", row.names = FALSE)


# Loading the data set
Bhopal <- read.csv("Bhopal_data.csv")

# Cleaning the data set
Bhopal <- Bhopal %>% select(-snow, -wpgt, -tsun)
Bhopal <- Bhopal %>%
  mutate(prcp = replace_na(prcp, 0))
Bhopal <- Bhopal %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Bhopal, "Bhopal.csv", row.names = FALSE)

# Loading the data set
Chen_22 <- read.csv("Chennai_22.csv")
Chen_23 <- read.csv("Chennai_23.csv")
Chen_24 <- read.csv("Chennai_oct_24.csv")

# Merging the data set
Chennai <- bind_rows(Chen_22,Chen_23,Chen_24)

# Cleaning the data set
Chennai <- Chennai %>% select(-snow, -wpgt, -tsun)
Chennai <- Chennai %>%
  mutate(prcp = replace_na(prcp, 0))
Chennai <- Chennai %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Chennai, "Chennai.csv", row.names = FALSE)

# Loading the data set
Ddn_22 <- read.csv("Dehradun_22.csv")
Ddn_23 <- read.csv("Dehradun_23.csv")
Ddn_24 <- read.csv("Dehradun_oct_24.csv")

# Merging the data set
Dehradun <- bind_rows(Ddn_22,Ddn_23,Ddn_24)

# Cleaning the data set
Dehradun <- Dehradun %>% select(-snow, -wpgt, -tsun)
Dehradun <- Dehradun %>%
  mutate(prcp = replace_na(prcp, 0))
Dehradun <- Dehradun %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Dehradun, "Dehradun.csv", row.names = FALSE)

# Loading the data set
Delhi <- read.csv("Delhi_data.csv")

# Cleaning the data set
Delhi <- Delhi %>% select(-snow, -wpgt, -tsun)
Delhi <- Delhi %>%
  mutate(prcp = replace_na(prcp, 0))
Delhi <- Delhi %>% rename(Date = date, Average_Temperature = tavg,
                          Minimum_Temperature = tmin,
                          Maximum_Temperature = tmax,
                          Precipitation = prcp,
                          Wind_Direction = wdir,
                          Wind_Speed = wspd,
                          Air_Pressure = pres)

# Saving data frame into csv
write.csv(Delhi, "Delhi.csv", row.names = FALSE)

# Loading the data set
Guw_22 <- read.csv("Guwahati_22.csv")
Guw_23 <- read.csv("Guwahati_23.csv")
Guw_24 <- read.csv("Guwahati_oct_24.csv")

# Merging the data set
Guwahati <- bind_rows(Guw_22,Guw_23,Guw_24)

# Cleaning the data set
Guwahati <- Guwahati %>% select(-snow, -wpgt, -tsun)
Guwahati <- Guwahati %>%
  mutate(prcp = replace_na(prcp, 0))
Guwahati <- Guwahati %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Guwahati, "Guwahati.csv", row.names = FALSE)

# Loading the data set
Hyd_22 <- read.csv("Hyderabad_22.csv")
Hyd_23 <- read.csv("Hyderabad_23.csv")
Hyd_24 <- read.csv("Hyderabad_oct_24.csv")

# Merging the data set
Hyderabad <- bind_rows(Hyd_22,Hyd_23,Hyd_24)

# Cleaning the data set
Hyderabad <- Hyderabad %>% select(-snow, -wpgt, -tsun)
Hyderabad <- Hyderabad %>%
  mutate(prcp = replace_na(prcp, 0))
Hyderabad <- Hyderabad %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Hyderabad, "Hyderabad.csv", row.names = FALSE)

# Loading the data set
Kan_22 <- read.csv("Kanpur_22.csv")
Kan_23 <- read.csv("Kanpur_23.csv")
Kan_24 <- read.csv("Kanpur_oct_24.csv")

# Merging the data set
Kanpur <- bind_rows(Kan_22,Kan_23,Kan_24)

# Cleaning the data set
Kanpur <- Kanpur %>% select(-snow, -wpgt, -tsun)
Kanpur <- Kanpur %>%
  mutate(prcp = replace_na(prcp, 0))
Kanpur <- Kanpur %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Kanpur, "Kanpur.csv", row.names = FALSE)

# Loading the data set
Kol_22 <- read.csv("Kolkata_22.csv")
Kol_23 <- read.csv("Kolkata_23.csv")
Kol_24 <- read.csv("Kolkata_oct_24.csv")

# Merging the data set
Kolkata <- bind_rows(Kol_22,Kol_23,Kol_24)

# Cleaning the data set
Kolkata <- Kolkata %>% select(-snow, -wpgt, -tsun)
Kolkata <- Kolkata %>%
  mutate(prcp = replace_na(prcp, 0))
Kolkata <- Kolkata %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Kolkata, "Kolkata.csv", row.names = FALSE)

# Loading the data set
Luck_22 <- read.csv("Lucknow_22.csv")
Luck_23 <- read.csv("Lucknow_23.csv")
Luck_24 <- read.csv("Lucknow_oct_24.csv")

# Merging the data set
Lucknow <- bind_rows(Luck_22,Luck_23,Luck_24)

# Cleaning the data set
Lucknow <- Lucknow %>% select(-snow, -wpgt, -tsun)
Lucknow <- Lucknow %>%
  mutate(prcp = replace_na(prcp, 0))
Lucknow <- Lucknow %>% rename(Date = date, Average_Temperature = tavg,
                                  Minimum_Temperature = tmin,
                                  Maximum_Temperature = tmax,
                                  Precipitation = prcp,
                                  Wind_Direction = wdir,
                                  Wind_Speed = wspd,
                                  Air_Pressure = pres)

# Saving data frame into csv
write.csv(Lucknow, "Lucknow.csv", row.names = FALSE)

# Loading the data set
Mum_22 <- read.csv("Mumbai_22.csv")
Mum_23 <- read.csv("Mumbai_23.csv")
Mum_24 <- read.csv("Mumbai_oct_24.csv")

# Merging the data set
Mumbai <- bind_rows(Mum_22,Mum_23,Mum_24)

# Cleaning the data set
Mumbai <- Mumbai %>% select(-snow, -wpgt, -tsun)
Mumbai <- Mumbai %>%
  mutate(prcp = replace_na(prcp, 0))
Mumbai <- Mumbai %>% rename(Date = date, Average_Temperature = tavg,
                              Minimum_Temperature = tmin,
                              Maximum_Temperature = tmax,
                              Precipitation = prcp,
                              Wind_Direction = wdir,
                              Wind_Speed = wspd,
                              Air_Pressure = pres)

# Saving data frame into csv
write.csv(Mumbai, "Mumbai.csv", row.names = FALSE)

# Loading the data set
Pat_22 <- read.csv("Patna_22.csv")
Pat_23 <- read.csv("Patna_23.csv")
Pat_24 <- read.csv("Patna_oct_24.csv")

# Merging the data set
Patna <- bind_rows(Pat_22,Pat_23,Pat_24)

# Cleaning the data set
Patna <- Patna %>% select(-snow, -wpgt, -tsun)
Patna <- Patna %>%
  mutate(prcp = replace_na(prcp, 0))
Patna <- Patna %>% rename(Date = date, Average_Temperature = tavg,
                            Minimum_Temperature = tmin,
                            Maximum_Temperature = tmax,
                            Precipitation = prcp,
                            Wind_Direction = wdir,
                            Wind_Speed = wspd,
                            Air_Pressure = pres)

# Saving data frame into csv
write.csv(Patna, "Patna.csv", row.names = FALSE)

# Loading the data set
Shim_22 <- read.csv("Shimla_22.csv")
Shim_23 <- read.csv("Shimla_23.csv")
Shim_24 <- read.csv("Shimla_oct_24.csv")

# Merging the data set
Shimla <- bind_rows(Shim_22,Shim_23,Shim_24)

# Cleaning the data set
Shimla <- Shimla %>% select(-snow, -wpgt, -tsun)
Shimla <- Shimla %>%
  mutate(prcp = replace_na(prcp, 0))
Shimla <- Shimla %>% rename(Date = date, Average_Temperature = tavg,
                          Minimum_Temperature = tmin,
                          Maximum_Temperature = tmax,
                          Precipitation = prcp,
                          Wind_Direction = wdir,
                          Wind_Speed = wspd,
                          Air_Pressure = pres)

# Saving data frame into csv
write.csv(Shimla, "Shimla.csv", row.names = FALSE)

# Loading the data set
Var_22 <- read.csv("Varanasi_22.csv")
Var_23 <- read.csv("Varanasi_23.csv")
Var_24 <- read.csv("Varanasi_oct_24.csv")

# Merging the data set
Varanasi <- bind_rows(Var_22,Var_23,Var_24)

# Cleaning the data set
Varanasi <- Varanasi %>% select(-snow, -wpgt, -tsun)
Varanasi <- Varanasi %>%
  mutate(prcp = replace_na(prcp, 0))
Varanasi <- Varanasi %>% rename(Date = date, Average_Temperature = tavg,
                            Minimum_Temperature = tmin,
                            Maximum_Temperature = tmax,
                            Precipitation = prcp,
                            Wind_Direction = wdir,
                            Wind_Speed = wspd,
                            Air_Pressure = pres)
# Saving data frame into csv
write.csv(Varanasi, "Varanasi.csv", row.names = FALSE)

# Loading the data set
Pune <- read.csv("Pune_data.csv")

# Cleaning the data set
Pune <- Pune %>% select(-snow, -wpgt, -tsun)
Pune <- Pune %>%
  mutate(prcp = replace_na(prcp, 0))
Pune <- Pune %>% rename(Date = date, Average_Temperature = tavg,
                            Minimum_Temperature = tmin,
                            Maximum_Temperature = tmax,
                            Precipitation = prcp,
                            Wind_Direction = wdir,
                            Wind_Speed = wspd,
                            Air_Pressure = pres)

# Saving data frame into csv
write.csv(Pune, "Pune.csv", row.names = FALSE)