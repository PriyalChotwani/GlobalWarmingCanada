# Global Warming in Canada
This project depicts the Global Warming in Canada through various informative visualizations using RStudio. As change in average temperature is related to Global Warming, in this project change in average temperatures is calculated and analyzed to understand more about the Global Warming in Canada. 

# About the Dataset
The provincial data is taken from the Government of Canada website (Government of Canada, 2022). It includes longitude, latitude, year, month, and average temperature from 1914 to 2007 for provinces of Canada. The monthly average temperature data is recorded by regional stations. As the original dataset contains many irrelevant and missing values, in an ideal scenario, cleaning data, and finding a data set with no missing value is required. A period of 20 years from 1987 to 2006 is selected in which there were fewer missing values comparatively. After preprocessing it is named as Canada20.

The preprocessing dataset included the following steps:
  • Calculating a mean of provincial yearly temperature from 1987 to 2006 by removing months in certain situations
  • Making province name consistent to make geolocation mapping possible
  • Extracting locations, years, and joining different provincial datasets together. The data for all the provinces are combined into a single file to find     the change in temperature over the years for each province
  • A dataset called Canada is obtained from R by using the libraries (sf, rnaturalearth, devtools) which contained the geometry of each province of Canada     which was further used in plotting the geo map. This dataset was combined with Canada20 (preprocessed dataset) by using left join to contain all the      necessary columns along with the geometries of each province to plot the respective graphs

The data set can be improved by having all the values for every month in all the years for each province. Currently, the data set has several missing values which has affected the results majorly. For instance, Prince Edward Island contains only 2 values for the year 2006 is for the month January and February. Similarly, there are many missing values for Manitoba (in 1995 and 2000), Yukon, New Brunswick, Nova Scotia, and many more (in 2006). It was not possible to fill these missing values with some data due to the incomplete and inconsistent data available on the data sources. 

# Methodology and Analysis

### What is the temperature change in all the provinces of Canada in the span of 20 years (1987-2006)?
Geo graph is plotted using plotly function where the Canada20 dataset is combined with the data obtained from the pre-build R packages (devtools, sf, rnaturalearth) by using left join and the records are matched using the column provinces. The pre-built dataset has the information about geometry, which is necessary to plot the Geo map of Canada in RStudio and the preprocessed dataset (Canada20) contains the necessary information about the average temperature of each province by year from 1987 to 2006. It is an interactive geo-map in a form of a GIF, where the colour of provinces changes with the temperature variations. 

Figure represents a screenshot of the geo graph which is originally in the form of GIF. First figure is for the year 1987 and second figure represents it for 2006. There has been a major dip in the average temperature of Newfoundland and Labrador being 4.67°C in 1987 to -3.25°C in 2006. For Yukon, the temperature dropped from -4.12°C in 1987 to -22.95°C in 2006. This might make someone greatly wonder as it is a huge drop that makes Yukon unlivable for a person. Therefore, after deeper analysis of the dataset, it was discovered that there are only 2 entries in 2006 for the months January and February. Also, the same thing happened for Manitoba in the year 1995 and the temperature suddenly dropped to -19.5°C which was due to a similar reason as only 2 entries were recorded in 1995 for January and February. Therefore, it was concluded that proper insights could not be discovered unless all the data points are available. This is generally a great visualization for business processes involving the overall changes in different provinces of a country and it can be utilized to present the information to the stakeholders in a visually appealing manner (Given the dataset is complete and consistent).

### Is there any major change in temperature of Canadian provinces from 1987 to 2006?
To find out the major changes in the average temperature of each province with every passing year, a line graph is plotted using the ggplot2 package in RStudio. Geom_line and geom_point functions are used to track the changes in average temperatures from 1987 to 2006. Each province is visualized using a different colour to better differentiate and understand the variations. 

```
data_clean<- read.csv("..../Canada20.csv")
data_clean<-rename(data_clean, AverageTemperature=Mean.Temp...C.)
```

Figure represents a line chart to analyze the temperature change over the years for each Canadian province/territory. However, due to inconsistency in the dataset, there are major changes in certain provinces for a few years. In the case of the Northwest Territories, there is a dip in 1990 due to missing values but there is a peak in 1998. After careful consideration and research, it was discovered that in 1998, Canadians experienced the warmest and longest summers, there were costliest forest fires recorded, followed by a year-long heatwave (Government of Canada, 1998). Therefore, almost all the provinces experienced a rise in average temperature during that year. In 2000, many provinces experienced a dip in their average temperatures (For Manitoba, it is due to
missing values). After careful observation and research, we found out that Canadians experienced a rare landfalling hurricane and first time in 13 years, a deadly tornado touched down in Canada killing 12 people. (Government of Canada, 2000) To analyze and observe such drastic variations and occurrences, this graph can be very informative. The provinces which have complete and consistent values for all the years experienced relatively stable temperatures over the years. If the dataset was consistent and available till 2021, this would have been a great visualization to observe the trends in average temperature over the years. 

### What is the prediction of the average temperature in Canada in the coming years?
To know how the temperature will vary and how much change will Canada undergo in terms of average temperature, I randomly chose the years 2024, 2035 and 2050. I chose the Linear Regression model to predict the value of the average temperature of the mentioned years (dependent variable) using the value of the average temperature in the previous years that is already present in the dataset (independent variable). This model is chosen because it gives a better understanding of the statistical inference, it is more versatile, and it has wider applicability. I tried to fit the linear model in the preprocessed dataset by using the ggplot2 package in RStudio and geom_point and stat_smooth function by using the “lm” method. This is a pre-built function in R to create a regression model in the form of the formula Y~X+X2. In this case, there are only 2 variables Y being Average Temperature and X being the year. To check the accuracy of the model, the average temperature of the years 1991, 1993, and 2003 is obtained and compared to the values present in the dataset. Later, the average temperature of the years 2024, 2035, and 2050 is predicted using another pre-built function in R called predict. 

```
data_clean123<- data_clean %>% select(AverageTemperature, Year, Province)
data_clean123<- data_clean123 %>% group_by(Year)%>%summarise(AverageTemperature= mean(AverageTemperature))
```
```
ggplot(data = data_clean123, aes(x = Year, y = AverageTemperature, color= AverageTemperature)) +
  geom_point() +
  stat_smooth(method = "lm", col = "dodgerblue3") +
  theme(panel.background = element_rect(fill = "white"),
        axis.line.x=element_line(),
        axis.line.y=element_line()) +
  ggtitle("Linear Model Fitted to Data")
```

Figure represents the linear regression model. In this case, the data points are very scattered so it is difficult to identify which model will best fit this dataset. The linear model can fit. As per the graph, it is evident that there is a positive slope, therefore the temperature in Canada is gradually increasing. In an ideal scenario, the points are very close to the line which helps in determining or predicting the variables more accurately and efficiently. To calculate the error percentage of the model, I randomly selected the year 1991, 1993, and 2003 and predicted the average temperature as per the model. As per the code shown, where fit_1 represents our data frame, the predicted value is 1.02174 whereas the actual value is 1.1496 which gives an 11.12% error rate for the year 1991. Table 1 represents the error percentage calculated by choosing 3 years randomly in the similar manner shown, so the average error percentage is 13.83%.

```
fit_1 <- lm(AverageTemperature ~ Year, data = data_clean123)
predict(fit_1, data.frame(Year=2002))
predict(fit_1, data.frame(Year=1993))
predict(fit_1, data.frame(Year=1991))
summary(fit_1)
```

Therefore, from the model it is visible that the average temperature of Canada is continuously going up, hence some measures need to be taken to monitor this issue closely and take care of our environment more than we have ever so that the next lives to come can survive without any environment difficulties. 

# Additional Visualizations

```
data_cans1 = data_clean %>% group_by(Year,Month) %>% filter(Year == 1987 |Year == 1992 |Year == 1997 |Year == 2002 |Year == 2006) 
hchart(data_cans1,type="column",hcaes(x = Month,y = AverageTemperature, group = Year)) %>%
  hc_title(text = "Month Temperatures in Canada every 5 years") %>%
  hc_add_theme(hc_theme_google()) %>%
  hc_legend(enabled = TRUE)
```

```
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
```
# Limitations
R is a very powerful language to perform data visualization and data prediction. It has been successful in capturing the market to an extent that, it has become a necessity for every data analyst and data scientist to know briefly about this tool. It allows the user to perform statistical analysis and plot
complex visualizations. It has an option to write code in a script, notebook, and markdown coding environment, and can be exported to different types of files which can fulfil a different displaying purpose.

However, even then it has many competitors because not everyone can learn to code. Although, a nonprogrammer with little or no knowledge will be able to learn about it after some practice or online lessons as it has a very simple syntax. The main challenge and limitation faced while plotting graphs was the amount of time R takes in processing (especially the geo maps). It has pre-built packages for all the operations and visualizations which is a boon and a curse as even though in some cases it makes the task easier (if one is successful in finding the right package) but in other cases, it complicates the task. For an instance, while plotting a geo map, I had to find a package that contained the latitude and longitude and other necessary information to plot all the provinces of Canada, even though this information was already mentioned in the dataset. This took a while, unlike Tableau or Power BI where plotting a Geo map is relatively very easy. The beautification of the graphs may require some time in RStudio whereas, other visualizations tools may or may not require a similar amount of time. RStudio may take several hours or even days because of the coding and partially because some graphs may turn out to be inappropriate for answering certain problem statements. 

Even after all the limitations, R remains to be an extremely powerful and useful tool and is a necessity in the data visualization and interpretation world.
