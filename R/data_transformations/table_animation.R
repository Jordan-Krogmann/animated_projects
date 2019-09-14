library(tidyverse)
library(gganimate)



sleep_data <- sleep %>%
  mutate(group = as.numeric(as.character(group))) %>%
  rbind(
    sleep %>%
      mutate(group = as.numeric(as.character(group))) %>%
      mutate(group = group + 2)
  ) %>%
  group_by(group) %>%
  slice(1:5) %>%
  ungroup() %>%
  select(id = ID, key = group, value = extra) %>%
  mutate_all(funs(as.character))
glimpse(sleep_data)








sleep_wide <- sleep_data %>%
  spread(key = key, value = value) %>%
  rename_at(vars(`1`:`4`), function(.) paste("group", .))
glimpse(sleep_wide)



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
long_tables <- map(list(sleep_data, sleep_wide), longDat)




long_table <- long_tables[[1]] %>% 
  mutate(tstep = "a")
wide_table <- long_tables[[2]] %>% 
  mutate(tstep = "b")
both_tables <- bind_rows(long_table, wide_table)


both_tables$celltype[both_tables$column == 1] <- c("header", rep("id", 20), "header", rep("id", 5)) 
both_tables$celltype[both_tables$column == 2] <- c("header", rep(1:4, each = 5), 1, rep("data", 5)) 
both_tables$celltype[both_tables$column == 3] <- c("header", rep("data", 20), 2, rep("data", 5)) 
both_tables$celltype[both_tables$column == 4] <- c(3, rep("data", 5)) 
both_tables$celltype[both_tables$column == 5] <- c(4, rep("data", 5))


base_plot <- ggplot(both_tables, aes(column, -row, fill = celltype)) +
  geom_tile(color = "black") + 
  theme_void() +
  scale_fill_manual(values = c("#247ba0","#70c1b3","#b2dbbf","turquoise2", "#ead2ac", "grey60", "mistyrose3"),
                    name = "",
                    labels = c("Group 1", "Group 2", "Group 3", "Group 4", "Data", "Header", "ID"))
base_plot + 
  facet_wrap(~tstep)



p1 <- base_plot +
  transition_states(
    states            = tstep,
    transition_length = 1,
    state_length      = 1
  ) +
  enter_fade() +
  exit_fade() +
  ease_aes('sine-in-out')

p1_animate <- animate(p1, height = 800, width = 600, fps = 20, duration = 10)
anim_save("group_by_animate.gif")

p1_animate












# ########################################################
#                         Part two                       #
# ########################################################


# Creating Data
sleep_data <- sleep %>%
  mutate(group = rep(1:4, each = 5),
         ID = rep(1:4, each = 5)) %>%
  select(id = ID, group, data = extra)


# Data check
sleep_data




# Creating nested data frame
sleep_nested <- sleep_data %>%
  group_by(group) %>%
  summarise(id = id[1], nesteddata = list(data))

# Data check
sleep_nested



# Need to combine two data sets into one for the animation
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


# stuff i should know
long_tables <- map(list(sleep_nested, sleep_data), longDat)

nested_table <- long_tables[[1]] %>% 
  mutate(tstep = "a",
         value = sapply(value, paste, collapse = ", "))

unnested_table <- long_tables[[2]] %>% 
  mutate(tstep = "b")

both_tables <- bind_rows(nested_table, unnested_table)






both_tables$celltype[both_tables$column == 1] <- c("header", rep("id", 4), "header", rep("id", 20))
both_tables$celltype[both_tables$column == 2] <- c("header", rep(1:4, each = 1), "header", rep(1:4, each = 5))
both_tables$celltype[both_tables$column == 3] <- c("header", rep("nesteddata", 4), "header", rep("data", 20))





both_tables





base_plot <- ggplot(both_tables, aes(column, -row, fill = celltype)) +
  geom_tile(color = "black") + 
  theme_void() +
  scale_fill_manual(values = c("#247ba0","#70c1b3","#b2dbbf","turquoise2", "#ead2ac", "grey60", "mistyrose3", "#ffae63"),
                    name = "",
                    labels = c("Group 1", "Group 2", "Group 3", "Group 4", "Data", "Header", "ID", "Nested Data"))

base_plot + 
  facet_wrap(~tstep)







p2 <- base_plot +
  transition_states(
    states            = tstep,
    transition_length = 1,
    state_length      = 1
  ) +
  enter_fade() +
  exit_fade() +
  ease_aes('sine-in-out')

p1_animate <- animate(p2, height = 800, width = 600, fps = 20, duration = 10)
anim_save("unnest_animate.gif")





















