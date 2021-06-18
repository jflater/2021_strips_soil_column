library(tidyverse)
library(lubridate)
library(readxl)
library(ggrepel)

setwd("~/Desktop/Flater_soilColumnAnalysis/Code/")

SecondWater <- read_excel("~/Desktop/Flater_soilColumnAnalysis/Data/LeachateData.xlsx", 
                           sheet = "Rainfall 2") %>%
  select(column, rain_date, `water_mass(g)`)
 
ThirdWater <- read_excel("~/Desktop/Flater_soilColumnAnalysis/Data/LeachateData.xlsx",
                         sheet = "Rainfall 3") %>%
  select(column, rain_date, `water_mass(g)`)

WaterPlot <- bind_rows(SecondWater, ThirdWater) %>%
  filter(rain_date %in% c(20210609, 20210616)) %>%
  ggplot(aes(x = rain_date, y = `water_mass(g)`, color = column)) +
    geom_line() + 
    geom_point() +
    geom_label_repel(aes(label = column),
                   nudge_x = .1,
                   na.rm = TRUE)

WaterPlot
