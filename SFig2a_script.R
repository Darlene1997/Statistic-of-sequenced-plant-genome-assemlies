library(ggplot2)
library(ggpubr)

size_plot <- read.table("C:/Users/Darlene1122/Desktop/SFig2.txt",header = T)
size_plot$ContigN50 <- as.numeric(size_plot$ContigN50)

ggplot(size_plot,aes(x=Year, y = ContigN50),)+
  geom_boxplot(fill="#3BA738", width = 0.4, alpha = 0.7) +
  stat_boxplot(geom = "errorbar",width = 0.5)+
  geom_jitter(fill= "#7f7f7f", width=0.2,shape=21,size=1,alpha=0.3)+ 
  labs(y="Contig N50 size (Kb)")+
  stat_compare_means(aes(label = ..p.signif..),method = "t.test", comparisons = c('20y','3y'))+
  xlab("")+
  coord_cartesian(ylim = c(0, 50000))+
  facet_wrap(~type)+
  theme_bw()