datasaurus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-13/datasaurus.csv')
library(dplyr)
library(ggplot2)
library(magick)
library(gganimate)

ggplot(datasaurus, aes(x=x, y=y))+
  geom_point()+
  transition_states(
    states = dataset, 
    wrap = FALSE,
    transition_length = 10,
    state_length = 5
    ) + 
  ease_aes('cubic-in-out') + 
  theme_void()+
  theme(legend.position = "none")

a_gif <- animate(a, width = 240, height = 240)

b <- ggplot(datasaurus, aes(x=x))+
  geom_boxplot() + 
  transition_states(
    states = dataset, 
    wrap = FALSE,
    transition_length = 2,
    state_length = 1
  ) + 
  scale_x_continuous(limits=c(0,100))+
  ease_aes('cubic-in-out') + 
  theme_void()+
  ggtitle("Boxplot of x-values") + 
  theme(legend.position = "none")

b_gif <- animate(b, width = 240, height = 240)

c <- ggplot(datasaurus, aes(y=x))+
  geom_boxplot() + 
  transition_states(
    states = dataset, 
    wrap = FALSE,
    transition_length = 2,
    state_length = 1
  ) + 
  scale_y_continuous(limits=c(0,100))+
  ease_aes('cubic-in-out') + 
  theme_void()+
  ggtitle("Boxplot of y-values") + 
  theme(legend.position = "none")

c_gif <- animate(c, width = 240, height = 240)

a_mgif <- image_read(a_gif)
b_mgif <- image_read(b_gif)
c_mgif <- image_read(c_gif)

new_gif <- image_append(c(a_mgif[1], b_mgif[1],c_mgif[1]))
for(i in 2:100){
  combined <- image_append(c(a_mgif[i], b_mgif[i],c_mgif[i]))
  new_gif <- c(new_gif, combined)
}

new_gif

image_write(new_gif, "datasaurus_boxplots.gif")
getwd()
