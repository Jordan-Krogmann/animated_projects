# packages ----------------------------------------------------------------
# options(download.file.method = "wininet")
# devtools::install_github("R-CoderDotCom/ggcats@main")
library(gganimate)
library(ggplot2)
library(ggcats)
library(dplyr)



# helper ------------------------------------------------------------------
# A function to generate a data frame with simulated data and cats
data_cat <- function(from = 0, to = 80, by = 1, fun = rnorm, 
                     cat = "", sd = 3, category = "") {
  tibble(
    x = seq(from, to, by),
    y = fun(x) + rnorm(length(x), sd = sd),
    category = rep(category, length(x)),
    cat = rep(cat, length(x))
  )
}

# creat data frame
gud_df <- data_cat(
  fun = function(x) 10 + exp(x / 15) + 4 * sin(x), 
  cat = "nyancat", 
  sd = 1, category = "gud"
)


# create graph ------------------------------------------------------------
ggplot(gud_df, aes(x, y)) +
  geom_line(color = "dodgerblue4", size = 1) +
  geom_cat(aes(cat = cat), size = 4) +
  theme_minimal() +
  labs(
    title = "Gudness by CUddles amounts",
    y = "Gudness",
    x = "CUddles",
    caption = "Graph by JPCH. Generated with `ggplot2`, `ggcats` and `gganimate`",
  ) +
  scale_color_manual(
    values = c("#EE2C2C", "#FF8C00", "#68228B"),
    labels = c("Anxiety", "My focus", "Duties")) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.x = element_text(size = 12, color = "black"),
    axis.title.x = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 14, face = "bold"),
    legend.position = "top",
    legend.title = element_blank()
  ) +
  transition_reveal(x)



anim_save(filename = here::here("images","cat_animation.gif"))
