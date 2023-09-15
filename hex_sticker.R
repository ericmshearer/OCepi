#library(showtext)
library(hexSticker)

#font_add_google("Roboto", "Roboto")

orange <- "C:\\Users\\eric shearer\\OneDrive - County of Orange\\Pictures\\orange_food_fruit_icon_182571.png"

hexSticker::sticker(orange,
                    package = "epi", #title
                    h_color = "#000000", #border color
                    h_fill = "#113a72", #background color
                    p_family = "Roboto", #font
                    p_size = 28, #font size
                    p_y = 1.5, 
                    s_x = 1,
                    s_y = 0.75,
                    s_width = 0.5,
                    filename = "G:\\Surveillance\\R Scripts\\OCepi\\imgfile.png" #output path
                    )