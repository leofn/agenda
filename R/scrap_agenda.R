rm(list=ls())
options(warn=-1)
options(show.error.messages = T)
library(rvest)
urlbase <- "https://www.gov.br/planalto/pt-br/acompanhe-o-planalto/agenda-do-presidente-da-republica/xxxxxxxxxx"
datas <- as.Date(as.Date("2019-01-01"):as.Date("2020-08-11"), origin="1970-01-01")
datas <- as.character.Date(datas)

dados <- data.frame()

for (i in datas){
  url <- gsub("xxxxxxxxxx", i, urlbase)
  print(url)
  data <- i
  agenda <- url %>% read_html() %>% html_nodes(xpath = "//h4") %>% html_text()
  tryCatch({
    inicio <- url %>% read_html() %>% html_nodes(css = ".compromisso-inicio") %>% html_text()  
    fim <- url %>% read_html() %>% html_nodes(css = ".compromisso-fim") %>% html_text()  
    local <- url %>% read_html() %>% html_nodes(css = ".compromisso-local") %>% html_text()
    dados <- rbind(dados, cbind(agenda, data, inicio, fim,local))
    }, error = function(e){
    })
}

#write.csv(dados, "agenda.csv")
#save("dados", file = "agenda.RData")

  