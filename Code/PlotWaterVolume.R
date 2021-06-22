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

FourthWater <- read_excel("~/Desktop/Flater_soilColumnAnalysis/Data/LeachateData.xlsx",
                          sheet = "Rainfall 4") %>%
  select(column, rainfall, rain_date, `water_mass(g)`) 
  
waterdf <- bind_rows(SecondWater, ThirdWater, FourthWater) 

test <- waterdf %>%
  group_by(column) %>%
  mutate(lead0 = `water_mass(g)`, 
         lead1 = lead(`water_mass(g)`, n = 1, order_by = rainfall),
         slope = lead0 - lead1)

WaterPlot <- ggplot(test, aes(x = rainfall, y = `water_mass(g)`, group = column)) +
    geom_line(aes(color = slope < 0)) + 
    geom_point()

WaterPlot
# Filter the last values and add onto the line plot
data_ends <- waterdf %>% filter(rainfall == 4)
WaterPlot + 
  geom_label_repel(
    aes(label = column), data = data_ends,
    fontface ="plain", color = "black", size = 3
  ) +
  theme_economist() +
  labs(x = "Rainfall", y = "Mass of water in grams") +
  ggtitle("Monitoring leachate volume in soil columns", subtitle = "1,000 mL applied at each rainfall") 
  
ggsave("../Figures/LeachateVolume.png", plot = last_plot(), device = "png", width = 8, height = 6, units = "in")

