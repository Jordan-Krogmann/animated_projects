library(tidyverse)
library(gganimate)

sample_data <- tibble(
  ID = 1:10,
  `TRT1_TRT2_Value` = paste(sample(LETTERS[1:3], 10, replace = TRUE), 
                            sample(LETTERS[1:3], 10, replace = TRUE),
                            round(rnorm(10)), sep = "_")
)

sample_data




sample_data_separated <- sample_data %>%
  separate("TRT1_TRT2_Value", into = c("Treatment 1", "Treatment 2", "Value"), sep = "_")

sample_data_separated



longDat <- function(x) {
  names(x) %>%
    rbind(x) %>%
    setNames(seq_len(ncol(x))) %>%
    mutate(row = row_number()) %>%
    tidyr::gather(column, value, -row) %>%
    mutate(column = as.integer(column)) %>%
    ungroup() %>%
    arrange(column, row)
}

long_tables <- map(list(sample_data, sample_data_separated), longDat)

combined_table <- long_tables[[1]] %>% 
  mutate(tstep = "a")

separated_table <- long_tables[[2]] %>% 
  mutate(tstep = "b")




both_tables <- bind_rows(combined_table, separated_table)

both_tables$celltype[both_tables$column == 1] <- c("header", rep("id", 10), "header2", rep("id", 10))

both_tables$celltype[both_tables$column == 2] <- c("header", rep("value_treatment", 10), "header2", rep("treatment", 10))

both_tables$celltype[both_tables$column == 3] <- c("header2", rep("treatment", 10))

both_tables$celltype[both_tables$column == 4] <- c("header2", rep("value", 10))











base_plot <- ggplot(both_tables, aes(column, -row, fill = celltype)) +
  geom_tile(color = "black") + 
  geom_text(aes(label = value), size = 6, fontface = "bold") +
  theme_void() +
  scale_fill_manual(values = c("grey85", "grey85", "#ffebcc", "#d6e5ff", "#ffd6d7", "#f2d6ff"),
                    name = "",
                    labels = c("Header", "", "ID", "Treatment", "Value", "Value_Treatment"),
                    breaks = c("header", "", "id", "treatment", "value", "value_treatment")) +
  theme(
    plot.margin = unit(c(1, 1, 1, 1), "cm")
  )
p0 <- base_plot + 
  facet_wrap(~tstep)
p0



p1 <- base_plot +
  transition_states(
    states            = tstep,
    transition_length = 1,
    state_length      = 1
  ) +
  enter_fade() +
  exit_fade() +
  ease_aes('sine-in-out')

p1_animate <- animate(p1, height = 800, width = 1200, fps = 20, duration = 10)
anim_save("separate_animate.gif")









