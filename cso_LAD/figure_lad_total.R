setwd('D:\\Dropbox\\CSO\\code')

d = read.csv('CSO result.csv')

d1 = d[1:32,]

d1_t = d1[, c(1,2,3,4,5,6)]; 

names(d1_t)

d1_t1 = d1[, c(1,7, 8, 9, 10, 11)]; colnames(d1_t1) = names(d1_t)

names(d1_t1)

d1_t2 = d1[, c(1,12, 13, 14, 15, 16)]; colnames(d1_t2) = names(d1_t)

names(d1_t2)

d1_t$group = 1

d1_t1$group = 2

d1_t2$group = 3

d1 = rbind(d1_t[1:28,], d1_t1[1:28,], d1_t2[1:28,])

d1$SD = abs(d1$SD)


d1$SD_l = abs(d1$SD_l)
head(d1)

library(ggpubr)

library(latex2exp)
library(ggplot2)
trop = c("darkorange", "dodgerblue","hotpink")
indx = c(1, 20, 22, 24, 26, 28)
###Figure---Probability####
P = ggplot(data = d1, aes(x = T, y = P, color=as.factor(group), group = as.factor(group))) +
  geom_point(aes(color=as.factor(group)))+
  stat_smooth(method="lm", formula= (y ~ log(x)), size = 1,linetype="twodash") + 
  labs(x=TeX("$T/1000$"),y=TeX("$P(\\hat{x}^*_{N,M}\\in B_{\\epsilon}(x^*))$"))+
  theme_bw(base_size = 25)+
  scale_colour_manual(values=trop,
                      labels = c(expression(
                        paste(N==O(T^{over(1,2)}))),
                        expression(
                          paste(N==O(T^{over(1,3)}))),
                        expression(
                          paste(N==O(T^{over(1,4)})))))+
  guides(colour=guide_legend(title=NULL))+
  scale_x_continuous(breaks=d1$T[indx],labels = d1$T[indx]/1000) +
  theme(legend.position = "top")
  P
  ggsave( file = "probability_lad.pdf", width = 7, height = 6)
  
  
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
                          paste(N==O(T^{over(1,3)}))),
                        expression(
                          paste(N==O(T^{over(1,4)})))))+
  guides(colour=guide_legend(title=NULL))+
    scale_x_continuous(breaks=d1$T[indx],labels = d1$T[indx]/1000) + 
  theme(legend.position = "top")
  bias
  ggsave( file = "mse_lad.pdf", width = 7, height = 6)
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
    ggsave( file = "loss_lad.pdf", width = 7, height = 6)
    
    
    ####conditional scheme and splitting scheme######
    simu1 <- read.csv("simulation_result1.csv") # conditional
    simu2 <- read.csv("simulation_result2.csv") # independent
    
    
    simu1 <- simu1[1:32,]
    conRes <- simu1[which(simu1$X<=10^6),c(1,5,6)]
    indRes <- simu2[which(simu2$independent.sampling<=10^6), c(1,5,6)]
    
    
    all.equal(conRes[,1], indRes[,1])
    conRes[,3]<- abs(conRes[,3])
    
    colnames(conRes) <- colnames(indRes) <- c("T", "Error", "StdError")
    
    RES <- 
      data.frame(
        rbind(conRes, indRes),
        type = rep(c("Conditional", "Independent"), each = nrow(conRes))
      )
    
    RES$type <- RES$type%>% as.character() %>% as.factor()
    
    
    trop = c("darkorange", "dodgerblue")
    
    #expression(paste("This is a fraction: ", over(3 * alpha, sum(b[i], i==1, N)))))
    
    cs = ggplot(data = RES, 
           aes(x = T, y = Error, 
               color=type, group = type, shape = type)) +
      geom_line(size =0.7)+
      geom_point(aes(color=type), size = 2)+
      geom_errorbar(aes(ymin=Error-StdError, ymax=Error+StdError), width=.2)+
      labs(x=TeX("$T/1000$"),y=TeX("$\\frac{1}{N}\\sum_{i=1}^N|\\frac{1}{M}\\sum_{j=1}^{M}\\eta_{ij}^Tx-b_i|$"))+
      theme_bw(base_size = 25)+
      scale_x_continuous(breaks=d1$T[indx],labels = d1$T[indx]/1000) +
      scale_shape_manual(values = c(15, 16), name = "")+
      scale_color_manual(values = trop, name = "")+
      theme(legend.position = "top")
    cs
    ggsave( file = "con_id.pdf", width = 7, height = 6)
    
    