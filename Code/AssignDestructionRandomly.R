setwd("Desktop/Flater_soilColumnAnalysis/Data/")

library(readxl)
library(tidyverse)

soilcolumns <- read_excel("~/Downloads/Timeline-2.xlsx", 
                         sheet = "randomizingsamples")
View(soilcolumns)

soilcolumns <- soilcolumns %>%
  filter(Soil_Compartment == "Bulk") %>%
  select(!Destruction) %>%
  distinct()

assigndestruction <- soilcolumns %>%
  group_by(Block, Treatment, Length) %>% 
  mutate(Destruction = sample.int(n()))
  
write_csv(assigndestruction, "Destruction.csv")
