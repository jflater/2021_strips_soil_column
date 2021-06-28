library(tidyverse)
library(lubridate)
library(readxl)
library(ggrepel)
library(ggthemes)

# Read in all sheets 
SimulatedRainfallsList <- excel_sheets("../Data/LeachateData.xlsx")
SimulatedRainfalls <- lapply(SimulatedRainfallsList, function(x) read_excel(path = "../Data/LeachateData.xlsx", sheet = x, na = c("NA")))
SimulatedRainfallsDF <- bind_rows(SimulatedRainfalls)

# Make a data frame with a column indicating if slope is increasing or decreasing
changeinvolume <- SimulatedRainfallsDF %>%
  filter(rainfall != 1) %>% # No volume data for initial rainfall
  group_by(column) %>%
  mutate(lead0 = `water_mass(g)`, # column of interest (change in mass)
         lead1 = lead(`water_mass(g)`, n = 1, order_by = rainfall), # use lead to get the next water mass
         slope = lead0 - lead1, # slope calculation
         rainfall = as.numeric(rainfall), 
         increasing = ifelse(slope < 0, TRUE, FALSE)) # column to color geom line by if slope is increasing or decreasing

# subset to last rainfall for labeling points
data_ends <- changeinvolume %>%
  filter(rainfall == max(rainfall))

# Plot
WaterPlot <- changeinvolume %>%
  ggplot(aes(x = rainfall, y = `water_mass(g)`, group = column)) +
  geom_line(aes(color = increasing), size = 2, alpha = .5) + 
  geom_point(size = 2) + 
  geom_label_repel(aes(label = column), data = data_ends, fontface ="plain", color = "black", size = 3) +
  scale_x_continuous(breaks = seq(from = 2, to = 4, by = 1)) +
  theme_economist() +
  theme(legend.position = "none") +
  labs(x = "Rainfall", 
       y = "Mass of water in grams", 
       caption = "Labels indicate column in which leachate was collected from") +
  ggtitle("Monitoring leachate volume in soil columns", 
          subtitle = "1,000 mL applied at each rainfall") 

WaterPlot

ggsave("../Figures/LeachateVolume.png", plot = last_plot(), device = "png", width = 8, height = 8, units = "in")

