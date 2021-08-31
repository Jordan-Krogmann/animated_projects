

# library(devtools)
# install_github("basilesimon/noaastorms")
#-----------------Packages---------------
library(noaastorms) # storm data
library(tidyverse)  # data manipulation
library(gganimate)  # animated plots
library(tweenr)     # in-between data
library(mapdata)    # map data
library(maps)       # map data


#--------------------Data----------------
# creates storm data for atlantic ocean
# NA = North Atlantic
# SA = South Atlantic
# NI = North Indian
# SI = South Indian
# EP = East Pacific
# WP = West Pacific
storm_df <- noaastorms::getStorms('NA') 




# eliminating "less"-important columns
# /columns that don't have tracked information
storm_df <- storm_df %>% 
  filter(NAME != "NOT_NAMED")

#----Tweening for smoother animation-----
katrina_df <- storm_df %>% 
  filter(NAME == "KATRINA" & SEASON == 2005)# %>% 
  # select() 

# getting map data to create plot
# world_map <- mapdata::map_data("world")
state_map <- 
  ggplot() +
  borders(
    database =  "state", 
    colour = "grey80", 
    fill = "white"
  ) 

# creating the gif
storm_gif <- state_map +
  geom_point(
    data = filter(storm_df, Name == "KATRINA" & Season == 2005), 
    aes(
      x = Longitude, 
      y = Latitude, 
      group = Serial_Num, 
      size = Wind.WMO., 
      color = Wind.WMO.
    ), 
    alpha = .5
  ) +
  transition_states(
    states = ISO_time,
    transition_length = 2,
    state_length = 1
  ) +
  shadow_trail() +
  labs(title = "Hurricane Katrina"
       ,subtitle = 'Time: {closest_state}') +
  theme(plot.title = element_text(face = "bold"))


storm_gif <- gganimate::animate(storm_gif, width = 800, height = 500) 
storm_gif


#---------------------------------------
tween_events(
  d, 
  'cubic-in-out', 
  50, 
  start = time, 
  end = time + duration,
  enter = from_left, 
  exit = to_right, 
  enter_length = 0.1,
  exit_length = 0.05
)

#---------------------------------------
tween_events(
  katrina_df, 
  ease = 'linear', 
  nframes = 10, 
  start = "2005-08-23 18:00:00", 
  end = "2005-08-31 06:00:00"
)




