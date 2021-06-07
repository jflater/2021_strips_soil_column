# Mapping coordinates from images
# Load libraries
library(exifr)
library(tidyverse)
library(ggmap)


# Image files, all column location pics are *number*C.jpeg
setwd("../Images/")
files <- list.files(pattern = "*.HEIC")

# Read exif data, select filename, date, and GPS coordinates
dat <- read_exif(files) %>%
  select(
               SourceFile, DateTimeOriginal,
               GPSLongitude, GPSLatitude)

write.csv(dat, 'Exifdata.csv',
          row.names = F)

ggplot(dat, aes(x = GPSLongitude, y = GPSLatitude, label = SourceFile)) +
  geom_point(aes()) +
  geom_text(aes(label = SourceFile),hjust=0, vjust=0)
  ggtitle("Location of columns")


