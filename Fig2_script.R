#################### R script that generates plots for Figs.2 #####################
library (ggplot2)
library(patchwork)
library(DoseFinding)

##Fig 2a
#reads input file
fig2a_data<-read.table("C:/Users/Darlene1122/Desktop/Fig2a_data.txt", header = TRUE)
#sets sample order
fig2a_data$No <- factor(fig2a_data$No, levels =unique(fig2a_data$No))
#makes plot for Fig. 2a
Fig2a<-ggplot() +
  scale_y_continuous(trans = "sqrt")+
  geom_bar(data = fig2a_data, aes(x = No, y = sum), stat='identity', colour="black", size=0.1, fill="#2F4F4F") +
  geom_bar(data = fig2a_data, aes(x = No, y = No_20y_count), stat='identity', colour="black", size=0.1, fill="grey", position = "stack") +
  geom_text(data = fig2a_data, aes(x = No, y = sum, label = sum),hjust = -0.4,vjust = 0.36, size=3) +
  coord_flip() +
  scale_x_discrete(limits = as.character(1:88))+
  theme_classic()+
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank())+




##Fig2b
#reads input file
fig2b_data<-read.table("C:/Users/Darlene1122/Desktop/Fig2b_data.txt", header = TRUE)
#set color scheme
fig2b_data$Ploidy <- factor(fig2b_data$Ploidy, levels = c("Diploid","no", "Tetraploid", "Hexaploid", "Octoploid", "Triploid", "Decaploid"))
bar_cols3=c("#5B86A8","#7F7F7F", "#F2AE2C", "#F2C778", "#D0AF62", "#F2AE2C", "#D67C1B")
#sets the order of species in plot to match order in input file
fig2b_data$No <- factor(fig2b_data$No, levels =unique(fig2b_data$No))
fig2b_data$haplotype <- factor(fig2b_data$haplotype, levels = c("haplotype", "no"))
fig2b_data$Year <- as.Date(fig2b_data$Year)


#makes plot for Fig 2b
p2<-ggplot(data = fig2b_data , aes(x = No, y = Year, fill = Ploidy, shape=haplotype)) +
  #geom_boxplot(aes(x = No, y = length))+
  geom_point(stroke = 0.001, size=2.5, alpha=0.8, position = "jitter") +
  coord_flip() +
  scale_discrete_manual(values = c(25,21), aesthetics = 'shape', labels = c("haplotype", "no"))+
  scale_x_discrete(limits = as.character(1:88))+
  scale_color_manual(values = bar_cols3)+ scale_fill_manual(values=bar_cols3)  +
  #scale_y_continuous(trans = "log10")+
  theme_classic()+
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank(), legend.position = "none")+

#p3<-ggplot(data = fig2b_data , aes(x = No, y = length)) +
  ##geom_boxplot(aes(x = No, y = length))+
  #geom_boxplot(color="black", outlier.shape = NA, alpha=0, lwd= 0.3) +
  #coord_flip() +
  #scale_x_discrete(limits = as.character(1:88))+
  #scale_y_continuous(trans = "log10")+
  #theme_classic()+
  #theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank(), legend.position = "none")
  

Fig2b <- ggdraw(p2)+draw_plot(p3)



#Fig 2c
#reads input file
fig2c_data<-read.table("C:/Users/Darlene1122/Desktop/Fig2c_data.txt", header = TRUE)
#set color scheme
fig2c_data$Platform <- factor(fig2c_data$Platform, levels = c("Sanger", "NGS", "HiFi", "Other_TGS", "Ultra-long_ONT", "No_info"))
bar_cols2c=c('#2E8285','#4D7FBC','#C1D6E7','#3BA738','#F2AE2C',"#7F7F7F")
#sets the order of species in plot to match order in input file
fig2c_data$No <- factor(fig2c_data$No, levels =unique(fig2c_data$No))
fig2c_data$ContigN50 <- as.numeric(fig2c_data$ContigN50)
fig2c_data$Pan <- factor(fig2c_data$Pan, levels = c("pan-genome", "no"))
#makes plot for Fig 2b
p4<-ggplot(data = fig2c_data) +
  geom_point(aes(x = No, y = ContigN50, fill = Platform, shape=Pan),stroke = 0.001, size=2.5, alpha=0.8, position = "jitter") +
  geom_boxplot(aes(x = No, y = ContigN50), outlier.shape = NA,alpha=0,lwd= 0.3) +
  coord_flip() +
  scale_discrete_manual(values = c(25,21), aesthetics = 'shape', labels = c("pan-genome", "no"))+
  scale_x_discrete(limits = as.character(1:88)) +
  scale_fill_manual(values=bar_cols2c)  +
  scale_y_continuous(trans = "log10")+
  theme_classic()+
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank(), legend.position = "none")+

#p5<-ggplot(data = fig2c_data , aes(x = No, y = ContigN50)) +
  #geom_boxplot(color="black", outlier.shape = NA, alpha=0, lwd= 0.3) +
  #coord_flip() +
  #scale_x_discrete(limits = as.character(1:88))+
  #scale_y_continuous(trans = "log10")+
  #theme_classic()+
  #theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank(), legend.position = "none")

#Fig2c <- ggdraw(p4)+draw_plot(p5)



#Fig 2d
#reads input file
fig2d_data<-read.table("C:/Users/Darlene1122/Desktop/Fig2d_data.txt", header = TRUE)
#set color scheme
fig2d_data$HiC <- factor(fig2d_data$HiC, levels = c("yes", "no", "No_info"))
bar_cols2d=c('#3BA738','#F2AE2C',"#7F7F7F")
#sets the order of species in plot to match order in input file
fig2d_data$No <- factor(fig2d_data$No, levels =unique(fig2d_data$No))
fig2d_data$ScaffoldN50 <- as.numeric(fig2d_data$ScaffoldN50)
fig2d_data$T2T <- factor(fig2d_data$T2T, levels = c("no", "T2T", "yes"))
#makes plot for Fig 2b
p6<-ggplot(data = fig2d_data) +
  geom_point(aes(x = No, y = ScaffoldN50, fill = HiC, shape=T2T), color="black", stroke = 0.001, size=2.5, alpha=0.8, position = "jitter") +
  geom_boxplot( aes(x = No, y = ScaffoldN50), outlier.shape = NA,alpha=0,lwd= 0.3) +
  coord_flip() +
  scale_discrete_manual(values = c(21,23,25), aesthetics = 'shape', labels = c("no", "T2T", "yes"))+
  scale_x_discrete(limits = as.character(1:88))+
  scale_color_manual(values = bar_cols2d)+ scale_fill_manual(values=bar_cols2d)  +
  scale_y_continuous(trans = "log10")+
  theme_classic()+
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank(), legend.position = "none")

#p7<-ggplot(data = fig2d_data , aes(x = No, y = ScaffoldN50)) +
  #geom_boxplot(color="black", outlier.shape = NA, alpha=0, lwd= 0.3) +
  #coord_flip() +
  #scale_x_discrete(limits = as.character(1:88))+
  #scale_y_continuous(trans = "log10")+
  #theme_classic()+
  #theme(axis.title.y = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank(), legend.position = "none")


Fig2d <- ggdraw(p6)+draw_plot(p7)


############ combinaton of 4 plots  ##########

#wrap_plots(Fig2a, Fig2b,Fig2c,Fig2d, ncol = 4) 
wrap_plots(Fig2a, p2,p4,p6, ncol = 4) 
