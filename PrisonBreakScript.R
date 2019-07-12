#set WD
setwd("~/GitHub/PrisonBreak")

#load necessary packages
library(tidyverse)
library(extrafont)
library(magick)
library(scales)

#create custom theme for plot
theme_owen <- function () { 
  theme_minimal(base_size=12, base_family="Gill Sans MT") %+replace% 
    theme(
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = 'floralwhite', color = 'floralwhite')
    )
}

df <- read.csv("RawData.csv")

df$Shawshank <- ifelse(df$Year == 1994, "Shawshank Redemption Released", "")

df %>% 
  ggplot(aes(x = Year, y = Escapes, fill = Shawshank)) + 
  geom_bar(stat = 'identity') + 
  theme_owen() +
  theme(legend.position = 'none') +
  scale_x_continuous(breaks = seq(1978, 2016, 2)) +
  scale_y_continuous(labels = comma, breaks = seq(0, 15000, 3000)) +
  labs(x = "", 
       y = "Total Escapes", 
       title = "Total Escapes From State Prisons") + 
  theme(plot.title = element_text(face = 'bold', size = 20, hjust = .5)) +
  annotate(geom = 'label', x = 1994.5, y = 13750, label = "Shawshank Redemption\nReleased In Theaters", 
           family = 'Gill Sans MT', hjust = 0, fill = 'floralwhite', lineheight = .85) +
  scale_fill_manual(values = c("#969696", "#de2d26")) + 
  theme(plot.margin = unit(c(1, 1, 1, 1), "lines"))

ggsave("PrisonEscapes.png", width = 9, height = 6)

footy <- image_read("Footer.png")

#Recall saved graf
graf <- image_read("PrisonEscapes.png")

#Combine graf with footer 
img <- c(graf, footy)
image_composite(graf, footy, offset = "+0+1740") %>% image_write("PrisonEscapes.png")

  