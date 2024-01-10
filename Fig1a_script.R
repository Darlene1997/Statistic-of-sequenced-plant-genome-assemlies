#################### R script for Figure1 #####################
library (ggplot2)
library(patchwork)
library(DoseFinding)
####reads input file
fig1a_data<-read.table("C:/Users/Darlene1122/Desktop/Fig1a_data.txt", header = TRUE)
fig1a_data$Year <- factor(fig1a_data$Year, levels = c("2000-2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023"))
fig1a_data2<-read.table("C:/Users/Darlene1122/Desktop/Fig1a_data2.txt", header = TRUE)
fig1a_data2$Year <- factor(fig1a_data2$Year, levels = c("2000-2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023"))
fig1a_data2$ContigN50 <- as.numeric(fig1a_data2$ContigN50)
##### plot1
p1<-ggplot(data = fig1a_data2, aes(x = Year, y = ContigN50)) +
  geom_jitter(color="grey", size=0.3) +
  geom_boxplot(fill = "#73A8CD", outlier.shape = NA, alpha = 0.5,size = 0.3,width = 0.3, linetype = 2) +
  stat_boxplot(aes(ymin=..lower.., ymax=..upper..), fill = "#73A8CD", outlier.shape = NA, alpha = 0.5,size = 0.3,width = 0.3)+
  stat_boxplot(geom = "errorbar",aes(ymin=..ymax..),size = 0.3, width = 0.3, color="black")+
  stat_boxplot(geom = "errorbar",aes(ymax=..ymin..),size = 0.3, width = 0.3, color="black")+
  scale_y_continuous(trans = "log10", limits = c(0.1, 1000000))+
  labs(x = "Year")+
  theme_classic() +
  theme(axis.line.x = element_line(linetype = 1, colour = "black", linewidth = 0.8), axis.line.y = element_line(linetype = 1, colour = "black", linewidth = 0.8))


##### plot2
p2<-ggplot() +
  geom_bar(data = fig1a_data, aes(x = Year, y = pangenome), fill="#225C5F", color="black", stat = "identity", width=0.5) +
  geom_bar(data = fig1a_data, aes(x = Year, y = genome), fill="#3BA738", color="black", stat = "identity", width=0.5, position = "stack") +
  scale_y_continuous(limits = c(0, 4000))+
  theme_classic()+
  theme(axis.line.x = element_line(linetype = 1, colour = "black", linewidth = 0.8), axis.line.y = element_line(linetype = 1, colour = "black", linewidth = 0.8))

Fig1a <- ggdraw(p1)+draw_plot(p2)
