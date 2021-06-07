library(tidyverse)
library(phyloseq)
library(readxl)

# Set the working directory
setwd("Desktop/Flater_soilColumnAnalysis/")

# Read in Mothur outputs
ASVs <- read.csv("Data/MothurASVs.csv")

taxonomy <- read.csv("Data/MothurTaxa.csv")
  
metadata <- read_excel("Data/MetaData.xlsx")

Fig1 <- ggplot()

ggsave(Fig1, Figures/Figure1.png)