library(tidyverse)
library(lubridate)
library(readxl)
library(ggrepel)
library(ggthemes)

setwd("~/Desktop/Flater_soilColumnAnalysis/Code/")

SecondWater <- read_excel("~/Desktop/Flater_soilColumnAnalysis/Data/LeachateData.xlsx", 
                           sheet = "Rainfall 2") %>%
  select(column, rainfall,  rain_date, `water_mass(g)`)
 
ThirdWater <- read_excel("~/Desktop/Flater_soilColumnAnalysis/Data/LeachateData.xlsx",
                         sheet = "Rainfall 3") %>%
  select(column, rainfall, rain_date, `water_mass(g)`) 

waterdf <- bind_rows(SecondWater, ThirdWater) %>%
  filter(rain_date %in% c(20210609, 20210611, 20210616, 20210618)) 



WaterPlot <- ggplot(waterdf, aes(x = rainfall, y = `water_mass(g)`, color = column)) +
    geom_line() + 
    geom_point()

# Filter the last values and add onto the line plot
data_ends <- waterdf %>% filter(rainfall == 3)
WaterPlot + 
  geom_label_repel(
    aes(label = column), data = data_ends,
    fontface ="plain", color = "black", size = 3
  ) +
  theme_economist() +
  theme(legend.position = "none") + 
  labs(x = "Rainfall", y = "Mass of water in grams") +
  ggtitle("Monitoring leachate volume in soil columns", subtitle = "1,000 mL applied at each rainfall") 
  
ggsave("../Figures/LeachateVolume.png", plot = last_plot(), device = "png", width = 8, height = 6, units = "in")

