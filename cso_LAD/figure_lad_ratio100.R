setwd('D:\\Dropbox\\CSO\\code')

d = read.csv('CSO_result2.csv')

d1 = d[1:32,]

d1_t = d1[, c(1,2,3,4,5,6)]; 

names(d1_t)=c("T","P","MSE","SD","loss","SD_loss")

d1_t1 = d1[, c(1,7, 8, 9, 10, 11)]; colnames(d1_t1) = names(d1_t)

names(d1_t1)

#d1_t2 = d1[, c(1,12, 13, 14, 15, 16)]; colnames(d1_t2) = names(d1_t)

#names(d1_t2)

d1_t$group = 1

d1_t1$group = 2

#d1_t2$group = 3

d1 = rbind(d1_t[1:28,], d1_t1[1:28,])

#d1 = rbind(d1_t[1:28,], d1_t1[1:28,], d1_t2[1:28,])

d1$SD = abs(d1$SD)


d1$SD_loss = abs(d1$SD_loss)
head(d1)

library(ggpubr)

library(latex2exp)
library(ggplot2)
trop = c("darkorange", "dodgerblue")
indx = c(1, 20, 22, 24, 26, 28)
###Figure---Probability####
Prob = ggplot(data = d1, aes(x = T, y = P, color=as.factor(group), group = as.factor(group))) +
  geom_point(aes(color=as.factor(group)))+
  stat_smooth(method="lm", formula= (y ~ log(x)), size = 1,linetype="twodash") + 
  labs(x=TeX("$T/1000$"),y=TeX("$P(\\hat{x}^*_{N,M}\\in B_{\\epsilon}(x^*))$"))+
  theme_bw(base_size = 25)+
  scale_colour_manual(values=trop,
                      labels = c(expression(
                        paste(N==O(T^{over(1,2)}))),
                        expression(
                          paste(N==O(T^{over(1,3)})))))+
  guides(colour=guide_legend(title=NULL))+
  scale_x_continuous(breaks=d1$T[indx],labels = d1$T[indx]/1000) +
  theme(legend.position = "top")
Prob
ggsave( file = "probability_lad_100.pdf", width = 7, height = 6)


###Figure---mse of estimated solution####
bias = ggplot(data = d1, aes(x = T, y = MSE, color=as.factor(group), group = as.factor(group))) +
  geom_errorbar(aes(ymin=MSE+SD, ymax=MSE-SD), width=10) +
  geom_point(aes(color=as.factor(group)))+
  stat_smooth(span = 0.5, se=FALSE, size = 1,linetype="twodash") + 
  labs(x=TeX("$T/1000$"),y=TeX("$\\frac{1}{\\sqrt{d}}\\|\\hat{x}^*_{N,M}-x^*\\|_2$"))+
  theme_bw(base_size = 25)+
  scale_colour_manual(values=trop,
                      labels = c(expression(
                        paste(N==O(T^{over(1,2)}))),
                        expression(
                          paste(N==O(T^{over(1,3)})))))+
  guides(colour=guide_legend(title=NULL))+
  scale_x_continuous(breaks=d1$T[indx],labels = d1$T[indx]/1000) + 
  theme(legend.position = "top")
bias
ggsave( file = "mse_lad_100.pdf", width = 7, height = 6)


#### Figure----probability+loss########
d1_t$P[d1_t$P == 0] = 0.0001

p_loss = ggplot(data = d1_t, aes(x = P, y = loss)) +
  xlim(0, 1) +
  geom_point()+
  stat_smooth(method="lm", formula= (y ~ exp(x)), size = 1,linetype="twodash") + 
  labs(x=TeX("$P(\\hat{x}^*_{N,M}\\in B_{\\epsilon}(x^*))$"),y=TeX("$\\frac{1}{N}\\sum_{i=1}^Nf_{\\xi_i}(\\frac{1}{M_i}\\sum_{j=1}^{M_i}g_{\\eta_{ij}}(x,\\xi_i))$"))+
  theme_bw(base_size = 25)+
  labs(title=TeX("$N=O(T^{\\frac{1}{2}})$"))+
  theme(plot.title = element_text(hjust = 0.5)) 
p_loss  
ggsave( file = "loss_lad_100.pdf", width = 7, height = 6)



