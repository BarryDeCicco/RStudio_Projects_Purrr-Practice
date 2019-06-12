# File 1 - AER and Affairs

# This is from https://sebastiansauer.github.io/looping-purrr/

data(Affairs, package = "AER")
library(purrr)  # functional programming
library(dplyr)  # dataframe wrangling
library(ggplot2)  # plotting
library(tidyr)  # reshaping df

Affairs %>% 
  select_if(is.numeric) %>% 
  map(~t.test(. ~ Affairs$gender)$p.value)   %>%
  as.data.frame()

#  You could also set up a function on the fly:
  
  Affairs %>% 
  select_if(is.numeric) %>%
  #map(~t.test(. ~ Affairs$gender)$p.value) %>% 
  map(function(x) t.test(x ~ Affairs$gender)$p.value)
  
  
# getting it into shape for plotting:
  
  Affairs %>% 
    select_if(is.numeric) %>% 
    map(~t.test(. ~ Affairs$gender)$p.value)   %>%
    as.data.frame()     %>% 
  gather %>% 
    mutate(signif = ifelse(value < .05, "significant", "ns")) %>% 
    ggplot(aes(x = reorder(key, value), y = value)) + 
    geom_point(aes(color = signif)) + 
    coord_flip() +
    ylab("p value")
  
  
  