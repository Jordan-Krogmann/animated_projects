


# packages
library(tidyverse)

drink_function <- function(
  input_weight,
  required_bac = .08
  ){
  
  # required drinks for .08
  drinks_required <- input_weight * required_bac
  
  return(drinks_required)
}

drink_function(100)

tibble(
   first_name = c("Jordan", "Tim", "Brittny", "William", "Julia", "Justin", "Jennilynn", "Tal", "Jason", "Lynn", "Dan", "Sarbina")
 , last_name = c("Krogmann","Cerato", "Cerato", "Donovan", "Not Donovan", "Eastman", "Hagbi", "Hagbi", "Loy", "Chabot", "Debold", "Debold")
 , body_weight = c(170, 210, 122, 250, 130, 180, 120, 445, 190, 140, 160, 130)
 , pregnant_body_weight = c(NA, NA, 157, NA, NA, NA, NA, 470, NA, NA, NA, NA)
 # , required_drinks = c(NA, NA, 2, 5, NA, NA, NA, NA, NA, NA, NA, NA)
 # , pregnant_required_drinks = c(NA,NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)
 
)

# create bac data frame
bac_df <- 
  tibble(
    bac_level = seq(0 , 1 , by = .01)
  , number_of_drinks = seq(0 , 10 , by = .1)
  , body_weight = seq(0 , 500 , by = 5)
  )









bac_df %>% 
  ggplot() + 
    geom_point(aes(x = body_weight, y = number_of_drinks)) + 
    expand_limits(y = .4)

