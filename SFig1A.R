library(ggplot2)
############# contig and scaffold  #############
box_plot <- read.table("C:/Users/Darlene1122/Desktop/SFig1a.txt",header = T)  ## Year	Size	Type
box_plot$Type <- factor(box_plot$Type, levels = c("contig", "scaffold"))
bar_cols2c=c('#2E8285','#3BA738')
ggplot(box_plot, aes(x=Type, y=Size, fill=Year))+
  # geom_point(stroke = 0, size=1, alpha=0.3, position = "jitter") +
  geom_boxplot(alpha = 0.5,size = 0.8,width = 0.6)+
  stat_boxplot(geom = "errorbar",width = 0.6)+ 
  # geom_jitter(width=0.2,shape=21,size=1,alpha=0.3)+   #增加散点
  scale_fill_manual(values=bar_cols2c)  +
  scale_y_continuous(trans = "log10")+
  stat_compare_means(aes(label = ..p.signif..),method = "t.test")+
  xlab("")+  #这两行一起，是添加显著性值的
  theme_classic()

############# assembly #############
box_plot2 <- read.table("C:/Users/Darlene1122/Desktop/SFig1a2.txt",header = T)  ## Year	Size

ggplot(box_plot2, aes(x=Year, y=Size))+
  geom_boxplot(fill=c('#2E8285','#3BA738'), alpha = 0.5,size = 0.8,width = 0.6)+
  stat_boxplot(geom = "errorbar",width = 0.6)+ 
  # geom_jitter(width=0.2,shape=21,size=1,alpha=0.3)+   #增加散点
  scale_y_continuous(trans = "log10")+
  stat_compare_means(aes(label = ..p.signif..),method = "t.test")+
  xlab("")+  #这两行一起，是添加显著性值的
  theme_classic()+
