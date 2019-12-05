

  # ------------Packages``
library(tidyverse)
library(gganimate)
library(tweenr)


# ---------------------------------

x <- seq(1,100, by = .5)
y <- x ^ 2

df <- as_tibble(cbind(x,y))


text <- "Lobster Divide"

kara_sun_gif <- 
  ggplot(data = df, aes(x = x, y = y)) +
  geom_path(aes(colour = y),size = 2.5) +
  geom_vline(xintercept = 65, linetype = 5, size = 1.2) +
  geom_text(aes(x = 65, y = 7500, label = text, angle = 90), vjust = -1, size = 6) +
  scale_color_gradient(low = "dodgerblue4", high = "red") +
  scale_y_continuous(labels = scales::comma) + 
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 18, hjust = .5),
    axis.title = element_text(face = "bold", size = 16),
    axis.text = element_text(face = "bold", size = 14)
    ) + 
  labs(title = "Kara's Sun Exposure",
         y = "Amount of Sunburn",
         x = "Time") + 

  transition_manual(x, cumulative = TRUE) +
  ease_aes('linear') 


kara_sun_gif2 <- gganimate::animate(kara_sun_gif, end_pause = 10, height = 500, width = 800)
gganimate::anim_save(kara_sun_gif2, filename = here::here("plots_gifs","kara_sun_gif.gif"))  
