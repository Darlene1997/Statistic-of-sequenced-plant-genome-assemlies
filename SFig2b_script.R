#################### R script for Figure3B #####################
library (ggplot2)

fig3b_data<-read.table("C:/Users/Darlene1122/Desktop/SFig2b_data.txt", header = FALSE)
##Scafflod	2000-2010-RePS	1
fig3b_data$V2 <- factor(fig3b_data$V2, levels =unique(fig3b_data$V2))
fig3b_data$V3 <- as.numeric(fig3b_data$V3)
#set color scheme
fig3b_data$V1 <- factor(fig3b_data$V1, levels = c("Contig", "Polish", "Scafflod"))
bar_cols=c('#3BA738','#F2AE2C',"#4E84C3")

ggplot() +
  geom_bar(data = fig3b_data, aes(x = V2, y =V3, fill=V1), color="black", stat = "identity", width=0.4, alpha=0.8) +
  geom_text(data = fig3b_data, aes(x = V2, y =V3,label = V3),size=3, vjust = -0.8) +
  scale_y_continuous(trans = "log10")+
  theme_classic()+
  theme(axis.line.x = element_line(linetype = 2, colour = "black", linewidth = 0.5), axis.line.y = element_line(linetype = 1, colour = "black", linewidth = 0.5))+
  facet_wrap(~V1, ncol = 1, scales = "free_x")+
  scale_fill_manual(values=bar_cols)  +
  theme(axis.title.x = element_blank(), axis.text.x = element_text(angle = 45, hjust = 1))+
  theme(strip.background = element_blank())
