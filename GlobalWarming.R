install.packages("tidyverse")
#install.packages("lubridate")
install.packages("viridis")
#install.packages("countrycode")
install.packages("highcharter")
install.packages("ggplot2")
#install.packages("usethis")
install.packages("sf")
#install.packages("rworldmap")
install.packages("plotly")
install.packages("rnaturalearth") #for Canada
install.packages("devtools") 
#install.packages("gganimate")
devtools::install_github("ropensci/rnaturalearthhires")
library("rnaturalearth")
library("tidyverse")
library(ggplot2)
library(dplyr)
#library(lubridate)
library(tidyr)
library(viridis)
#library(countrycode)
library(highcharter)
library(ggplot2)
library(sf)
#library(rworldmap)
library(plotly)
#library(rnaturalearth)
#library(gganimate)

data_clean<- read.csv("/Users/priyalchotwani/Downloads/Canada20.csv")

data_clean<-rename(data_clean, AverageTemperature=Mean.Temp...C.)

#Month Temperature in every 5 years
data_cans1 = data_clean %>% group_by(Year,Month) %>% filter(Year == 1987 |Year == 1992 |Year == 1997 |Year == 2002 |Year == 2006) 
hchart(data_cans1,type="column",hcaes(x = Month,y = AverageTemperature, group = Year)) %>%
  hc_title(text = "Month Temperatures in Canada every 5 years") %>%
  hc_add_theme(hc_theme_google()) %>%
  hc_legend(enabled = TRUE)

#Geo graph

canada <- ne_states(country = "Canada", returnclass = "sf")

data_clean1<- data_clean%>% select("Province", "Year", "AverageTemperature")
data_clean1<-rename(data_clean1, name=Province)

data_clean1$name<- str_replace_all(data_clean1$name, c("AB"="Alberta", "BC"="British Columbia", "MB"="Manitoba", "NB"="New Brunswick", "NL"="Newfoundland and Labrador", "NS"="Nova Scotia", "NT"="Northwest Territories", "NU"="Nunavut", "ON"="Ontario", "PE"= "Prince Edward Island", "QC"="Québec", "SK"="Saskatchewan", "YT"= "Yukon"))
data_clean1<- data_clean1%>%group_by(Year,name)%>% summarise(MeanTemperature = mean(AverageTemperature))                                                      
canada_clean <- left_join(canada, data_clean1, by="name")
canada_clean <- canada_clean%>%select("name", "MeanTemperature","Year") 

plot_ly(canada_clean, split = ~name, color = ~MeanTemperature, text= ~paste(name, "Mean Temperature is", MeanTemperature), hoveron = "fills", hoverinfo = "text", frame = ~Year) %>%
  layout(title= "Temperature Change in Canada from 1987 to 2006") %>% config(displayModeBar = FALSE)%>%
  colorbar(ticksuffix = "°C")

#Month Temperature in Canada
ggplot(data_clean,aes(x=Month,y=AverageTemperature, color=as.numeric(Year))) + 
  geom_jitter(size=1) +
  scale_color_viridis(option="B")+
  theme(axis.line = element_line(color = "orange",size=.75))+
  theme(panel.background=element_blank())+
  scale_x_discrete()+labs(color="Year") +
  theme(legend.position = "bottom",
        axis.text = element_text(size = 10,face="bold"),
        plot.title = element_text(size=17,face = "bold")) + 
  ggtitle("Month Temperature in Canada") 

#Temperature change in all the province by Month and Year
a1<-ggplot(data_clean,aes(Month,AverageTemperature, color =Province)) + geom_line(alpha= 1) +
  theme(axis.line = element_line(color = "black",size=1))+
  theme(panel.background=element_blank())+
  labs(color="Province") +
  facet_wrap(~Year)+
  theme(legend.position = "bottom",
        axis.text = element_text(size = 10,face="bold"),
        plot.title = element_text(size=16,face = "bold")) + 
  ggtitle("Temperature change in all the province by Month and Year") 
ggplotly(a1)

#Temperature change by year for each Province
g1<-data_clean1 %>% ggplot(aes(x=Year, y=MeanTemperature, color=name)) +
  geom_line(size=1, alpha=0.75) +
  geom_point() +
  theme_light() +
  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  
  labs(title = "Temperature change by year for each Province") 
ggplotly(g1) 

#Change in Temperature for Alberta

data_alberta = data_clean %>% filter(Province == "AB")

ab1<-ggplot(data_alberta,aes(Month,AverageTemperature, group=Year,color =as.numeric(Year))) + geom_line(alpha= 1) +
  theme(axis.line = element_line(color = "black",size=1))+
  theme(panel.background=element_blank())+ scale_color_viridis(option="D")+
  labs(color="Year") +
  facet_wrap(~Province)+
  theme(legend.position = "bottom",
        axis.text = element_text(size = 10,face="bold"),
        plot.title = element_text(size=16,face = "bold")) + 
  ggtitle("Average Temperature change in Alberta by Month and Year") 
ggplotly(ab1)

#Change in Temperature for Nova Scotia

data_nova = data_clean %>% filter(Province == list("NS"))

a= "Nova Scotia"
prodata_nova = prodata1 %>% filter(Province == a)

ns1<-ggplot(data_nova,aes(Month,AverageTemperature, group=Year,color =as.numeric(Year))) + geom_line(alpha= 1) +
  theme(axis.line = element_line(color = "black",size=1))+
  theme(panel.background=element_blank())+ scale_color_viridis(option="D")+
  labs(color="Year") +
  facet_wrap(~Province)+
  theme(legend.position = "bottom",
        axis.text = element_text(size = 10,face="bold"),
        plot.title = element_text(size=16,face = "bold")) + 
  ggtitle("Average Temperature change in Alberta by Month and Year") 
ggplotly(ns1)

#Change in Temperature for Manitoba
data_manitoba = data_clean %>% filter(Province == "MB")

mb1<-ggplot(data_manitoba,aes(Month,AverageTemperature, group=Year,color =as.numeric(Year))) + geom_line(alpha= 1) +
  theme(axis.line = element_line(color = "black",size=1))+
  theme(panel.background=element_blank())+ scale_color_viridis(option="D")+
  labs(color="Year") +
  facet_wrap(~Province)+
  theme(lgiegend.position = "bottom",
        axis.text = element_text(size = 10,face="bold"),
        plot.title = element_text(size=16,face = "bold")) + 
  ggtitle("Average Temperature change in Manitoba by Month and Year") 
ggplotly(mb1)

#Change in Temperature for Yukon
data_yukon = data_clean %>% filter(Province == "YT")

yt1<-ggplot(data_yukon,aes(Month,AverageTemperature, group=Year,color =as.numeric(Year))) + geom_line(alpha= 1) +
  theme(axis.line = element_line(color = "black",size=1))+
  theme(panel.background=element_blank())+ scale_color_viridis(option="D")+
  labs(color="Year") +
  facet_wrap(~Province)+
  theme(legend.position = "bottom",
        axis.text = element_text(size = 10,face="bold"),
        plot.title = element_text(size=16,face = "bold")) + 
  ggtitle("Average Temperature change in Yukon by Month and Year") 
ggplotly(yt1)
