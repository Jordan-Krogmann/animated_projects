# ----- Overview -----
# Create an animated plot of napolean's 
# troop movements into russia.
# --------------------

# ----- Data Sources
# - Minard Data Set
# - Google Maps

# ----- Change Log
# - 2019.05.24 created file
# git config user.email "jordanckrogmann@gmail.com"
# git config user.name "Adeptplatypus"

# load packages -----
library(tidyverse)
library(gganimate)



# ----- Data Processing -----
# probably should change local pull to pull from github
# ----- troop counts & positions
troops <- read.table(
  here::here("data/minard/troops.txt"), 
  header = TRUE
) %>% 
  as_tibble()

# ----- City Locations
cities <- read.table(
  here::here("data/minard/cities.txt"), 
  header = TRUE
) %>% 
  as_tibble()

# ----- Tempratures and dates
temps <- read.table(
  here::here("data/minard/temps.txt"), 
  header = TRUE
) %>% 
  as_tibble()



# ----- Map Creation -----

# do this

# ----- Grab Map from google

#  do this

# ----- Add troop movements
troops %>% 
  ggplot(aes(x = long, y = lat, group = group)) + 
  geom_path(aes(size = survivors, color = direction))

# ----- Map Animation 

#  do this

# ----- Save gif -----

#  do this
