library(ggplot2)
point_plot <- read.table("C:/Users/Darlene1122/Desktop/SFig1b.txt",header = T)  ## Genomesize	ContigN50	Platform

point_plot$Platform <- factor(point_plot$Platform, levels = c("Sanger", "NGS", "HiFi", "Other_TGS", "ultra-long_ONT", "No_info"))
bar_cols2c=c('#2E8285','#4D7FBC','#C1D6E7','#3BA738','#F2AE2C',"#7F7F7F")
ggplot(point_plot, aes(x=Genomesize, y=ContigN50, fill=Platform))+
  geom_point(shape=21, stroke = 0.001, size=3, alpha=0.8, position = "jitter") +
  scale_fill_manual(values=bar_cols2c)  +
  scale_y_continuous(trans = "log10")+
  scale_x_continuous(trans = "log10")+
  theme_classic()
