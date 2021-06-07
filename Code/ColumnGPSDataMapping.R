# Mapping coordinates from images
# Load libraries
library(exifr)
library(tidyverse)
library(ggmap)

# SetWd to where images are
setwd("Images/")
# Image files, all column location pics are *number*C.jpeg
files <- list.files(pattern = "*C.heic")

# Read exif data, select filename, date, and GPS coordinates
dat <- read_exif(files) %>%
  select(
               SourceFile, DateTimeOriginal,
               GPSLongitude, GPSLatitude)

write.csv(dat2, 'Exifdata.csv',
          row.names = F)

ggplot(dat, aes(x = GPSLongitude, y = GPSLatitude)) +
  geom_point(aes(color = SourceFile)) +
  ggtitle("Location of columns")

us_counties <- map_data("county") %>%
  filter(region == "iowa", subregion == "buchanan") 
head(us_counties)

p <- ggplot(data = us_counties,
            mapping = aes(x = long, y = lat,
                          group = group, fill = subregion))
p
