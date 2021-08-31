
# packages
library(tidyverse)

# function to calculate required drinks to 
drink_function <- function(
  input_weight,       # body weighet
  required_bac = .08, # level of drunkenness
  gender              # gender
  ){
  
  # ro is a gender constant
  ro <- if_else(gender == "male", .68, .55)
  
  # required drinks for .08 (have to convert weight to grams)
  drinks_required <- ((input_weight * 453.592) * (required_bac / 100) * ro) / 14
  
  # return the final drinks required
  return(drinks_required)
}


# 
humans_df <- tibble(
    first_name = c("Jordan", "Tim", "Brittny", "William", "Julia", "Justin", "Jennilynn", "Tal", "Jason", "Lynn", "Dan", "Sarbina"),
    last_name = c("Krogmann","Cerato", "Cerato", "Donovan", "Not Donovan", "Eastman", "Hagbi", "Hagbi", "Loy", "Chabot", "Debold", "Debold"),
    body_weight = c(170, 210, 122, 250, 130, 180, 120, 445, 190, 140, 160, 130), 
    pregnant_body_weight = c(NA, NA, 157, NA, NA, NA, NA, 470, NA, NA, NA, NA), 
    gender = c("male","male","female","male","female","male","female","male","male","female","male","female")
)

# create bac data frame
bac_df <- tibble(
    bac_level = seq(0 , 1 , by = .01), 
    number_of_drinks = seq(0 , 10 , by = .1), 
    body_weight = seq(0 , 500 , by = 5)
)




