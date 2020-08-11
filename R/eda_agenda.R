library(tidyverse)
library(data.table)
library(lubridate)
library(forecast)

#read the data
dat <- fread("../Data/agenda.csv")

#plot the number of appointments per day and its 30-days moving average
x <- 1
dat %>% group_by(data) %>% summarise(total = n()) %>% ungroup() %>% ggplot(aes(x = data, y = total)) + geom_line() + labs(title = "Numero de compromissos diarios", y = "# de compromissos", x = "Data") + theme_minimal()

x <- 30 
dat %>% group_by(data) %>% summarise(total = n()) %>% ungroup() %>% mutate(total = forecast::ma(total,order=x)) %>% ggplot(aes(x = data, y = total)) + geom_line() + labs(title = "Numero de compromissos diarios", y = "# de compromissos", x = "Data", subtitle = paste0("Media de cada ",x," dias")) + theme_minimal()
