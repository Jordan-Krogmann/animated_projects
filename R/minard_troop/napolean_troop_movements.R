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

# ----- packages -----
suppressMessages(library(tidyverse)) # ----- data manipulation
suppressMessages(library(gganimate)) # ----- animated plots
# suppressMessages(library(readxl))    # ----- grab flat file



# ----- Data Processing -----
# probably should change local pull to pull from github
# ----- troop counts & positions
troops <- read.table(
  "C:/Users/Cabal/Desktop/project_repository/animated_projects/data_source/minard/troops.txt"
  , header = TRUE) %>% as_tibble()

# ----- City Locations
cities <- read.table(
  "C:/Users/Cabal/Desktop/project_repository/animated_projects/data_source/minard/cities.txt"
  , header = TRUE) %>% as_tibble()

# ----- Tempratures and dates
temps <- read.table(
  "C:/Users/Cabal/Desktop/project_repository/animated_projects/data_source/minard/temps.txt"
  , header = TRUE) %>% as_tibble()



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
