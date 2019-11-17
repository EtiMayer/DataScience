library(dplyr)
nasa1 <- as_data_frame(nasa)

nasa2 <- nasa1 %>%
  filter(between(lat,29.56,33.09),between(long,-110.93,-90.55)) %>%
  mutate(TempSurfRatio = temperature/surftemp) %>%
  group_by(year) %>%
  summarise(pressure_mean=mean(pressure,na.rm = TRUE),
            pressure_sd=sd(pressure,na.rm = TRUE),
            ozone_mean=mean(ozone,na.rm = TRUE),
            ozone_sd=sd(ozone,na.rm = TRUE),
            TempSurfRatio_mean=mean(TempSurfRatio,na.rm = TRUE),
            TempSurfRatio_sd=sd(TempSurfRatio,na.rm = TRUE)) %>%
  arrange(desc(ozone_mean))


nasa3 <- nasa1 %>%
  filter(lat>=29.56 & lat <=33.09 & long<=-90.55 & long >=-110.93) %>%
  mutate(TempSurfRatio = temperature/surftemp) %>%
  group_by(year) %>%
  summarise(pressure_mean=mean(pressure,na.rm = TRUE),
            pressure_sd=sd(pressure,na.rm = TRUE),
            ozone_mean=mean(ozone,na.rm = TRUE),
            ozone_sd=sd(ozone,na.rm = TRUE),
            TempSurfRatio_mean=mean(TempSurfRatio,na.rm = TRUE),
            TempSurfRatio_sd=sd(TempSurfRatio,na.rm = TRUE)) %>%
  arrange(desc(ozone_mean))