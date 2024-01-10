#################### R script that generates plots for Fig1  #####################
library (ggplot2)

#reads input file
df_fig1<-read.table("C:/Users/Darlene1122/Desktop/Fig3a_data.txt", header = TRUE)
df_fig1$Platform <- factor(df_fig1$Platform, levels = c("Sanger", "NGS", "HiFi", "Other_TGS", "Ultra-long_ONT", "No_info"))
df_fig1$Chrlevel <- factor(df_fig1$Chrlevel, levels = c("yes", "no"))
df_fig1$Year <- as.Date(df_fig1$Year)
HiFi_sub <- subset(df_fig1, Platform== "HiFi")
#get log10
#df_fig1$Genome_num <- log10(df_fig1$Genome_num)
#makes plot 
ggplot()+ 
  geom_point(data = df_fig1, aes(x = Year, y = ContigN50, shape=Chrlevel, color=Platform, fill=Platform,size=Genome_num), stroke = 0.1)+
  scale_color_manual(values = c('#262626','#262626','#262626','#262626','#262626','#262626'))+ 
  scale_fill_manual(values = c('#2E8285','#4D7FBC','#C1D6E7','#3BA738','#F2AE2C', "#7F7F7F"))+ 
  scale_y_continuous(trans = "log10")+ 
  scale_discrete_manual(values = c(21,25), aesthetics = 'shape', labels = c("yes", "no"))+ 
  scale_size_area(max_size = 12)+ 
  geom_rug(data = df_fig1, aes(x = Year, y = ContigN50), outside = TRUE, sides = "tr", linewidth = 0.1,alpha = 1/2, color="#006400")+
  geom_rug(data = HiFi_sub, aes(x = Year, y = ContigN50),outside = FALSE, sides = "tr", linewidth = 0.1,color="#C1D6E7")+
  coord_cartesian(clip = "off")+ 
  theme(plot.margin = margin(1,1,1,1,"cm"))+
  theme_bw()+
  theme(panel.grid = element_blank())+
  theme(legend.position = c(0.1, 0.6))+
  theme(legend.background = element_blank()) +
  theme(legend.key = element_blank())


ggplot(data = HiFi_sub, aes(x = Year, y = ContigN50))+ 
  geom_rug(outside = FALSE, sides = "tr", linewidth = 0.1,alpha = 1/2, color="#C1D6E7")+
  