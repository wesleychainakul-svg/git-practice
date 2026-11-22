install.packages("ggplot2") 
install.packages("gganimate") 
install.packages("gifski") 
library(ggplot2) 
library(gganimate) 

#Parameters and variables 
time <- 1:10 
HRV_breathing <- 30 
HRV_normal <- 30 

#Make a table 
data <- data.frame() 

#Model 
for (t in time) { 
  
  #Randomness
  breathing_change <- rnorm(1, 1.5, 1)
  normal_change <- rnorm(1, .2, 1)
  
  #HRV with and without deep breathing 
  HRV_breathing <- HRV_breathing + breathing_change
  HRV_normal <- HRV_normal + normal_change
  
    #Save result of DB 
    new_data <- data.frame( 
    Time = t, 
    HRV = HRV_breathing, 
    Condition = "Deep Breathing" 
  ) 
  
  data <- rbind(data, new_data) 
  
  #Save result of not DB 
  new_data <- data.frame( 
    Time = t, 
    HRV = HRV_normal, 
    Condition = "Without Deep Breathing" 
  ) 
  
  data <- rbind(data, new_data) 
} 

#Print result of model 
print(data) 

#Animated plot
graph <- ggplot(data,  aes(x = Time, y = HRV, color = Condition) 
) + 
  geom_line(linewidth = 1.2) + 
  geom_point(size = 2) + 
  
  labs(title = "HRV With and Without Deep Breathing", subtitle = "Time: {round(frame_along)} minutes", 
       x = "Time in Minutes", 
       y = "HRV (ms)", 
       color = "Condition" 
  ) + 
  scale_color_manual(values = c("Deep Breathing" = "green", "Without Deep Breathing" = "red") 
  ) + 
  theme_minimal() + transition_reveal(Time) 
animation <- animate(graph, nframes = 10,fps = 1) 

#Display
animation

#Save animation (add pound sign to prevent saving)
#anim_save("HRV_deep_breathing_graph.gif", animation) 
#testting
