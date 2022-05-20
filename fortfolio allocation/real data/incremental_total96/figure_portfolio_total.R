setwd('D:\\Dropbox\\CSO\\code')
library(magrittr)
res = read.csv("result.csv")


dat1= res[1:4,2:7]
dat2= res[6:9,2:7]
dat3= res[11:14,2:7]
dat4= res[16:19,2:7]
rownames(dat1)<- rownames(dat2) <- rownames(dat3)<- rownames(dat4)<- res[1:4,1]
colnames(dat1)<- colnames(dat2) <- colnames(dat3) <- colnames(dat4) <- paste0("windows", 1:6)


library(tidyr)
library(ggplot2)
library(ggpubr)
library(gridExtra)
library(grid)

dat1_long <- gather(dat1, window, myvalues, windows1:windows6, factor_key = T)
dat1_long_long <- data.frame(dat1_long, type = rep(rownames(dat1), 6))

dat2_long <- gather(dat2, window, myvalues, windows1:windows6, factor_key = T)
dat2_long_long <- data.frame(dat2_long, type= rep(rownames(dat1), 6))

dat3_long <- gather(dat3, window, myvalues, windows1:windows6, factor_key = T)
dat3_long_long <- data.frame(dat3_long, type=rep(rownames(dat1), 6))

dat4_long <- gather(dat4, window, myvalues, windows1:windows6, factor_key = T)
dat4_long_long <- data.frame(dat4_long, type= rep(rownames(dat1), 6))


resAll <- data.frame(cbind(
  rbind(dat1_long_long, dat2_long_long, dat3_long_long, dat4_long_long),
  est_type=rep(c("eps5", 'eps15', "eps25", "nochance"), each= nrow(dat1_long_long))
))
levels(resAll$window) <- 1:6

table(resAll$est_type)

resAll$est_type<- as.factor(resAll$est_type)
levels(resAll$est_type)
resAll$est_type = relevel(resAll$est_type, ref="eps5")
###### 
#Plot the in-sample and out-of-sample risk

trop = c("red","green","blue","#999900")
#####train risk############
datplot = resAll[(resAll$type%in% c("trainrisk", "stdtrainrisk")),]
datplot_wide = spread(datplot, type, myvalues)

train_risk = ggplot(data = datplot_wide, 
                    aes(x = window, y = -1*trainrisk, 
                        color=est_type, group = est_type, shape = est_type)) +
  geom_line(size =0.6,position=position_dodge(0.5))+
  geom_point(aes(color=est_type), size = 2,position=position_dodge(0.5))+
  geom_errorbar(aes(ymin=-1*trainrisk-stdtrainrisk, ymax=-1*trainrisk+stdtrainrisk), width=.2,
                position=position_dodge(0.5))+
  labs(y=TeX("$\\frac{1}{N}\\sum_{i=1}^N(\\frac{1}{M_i}\\sum_{j=1}^{M_i}\\eta_{ij}^Tx)$"))+
  theme_bw(base_size = 22)+
  scale_x_discrete(name="96 months (6 sliding windows)")+
  scale_shape_manual(values = c(15, 16, 17, 18))+
  scale_color_manual(values = trop)+
  geom_hline(yintercept=0, linetype='dashed')+
  #theme_minimal()+
  theme(legend.position="none")
train_risk
ggsave( file = "in_sample_risk.pdf", width = 7, height = 6)

######test risk###############
datplot = resAll[(resAll$type%in% c("testrisk", "stdtestrisk")),]
datplot_wide = spread(datplot, type, myvalues)

test_risk = ggplot(data = datplot_wide, 
                   aes(x = window, y = -1*testrisk, 
                       color=est_type, group = est_type, shape = est_type)) +
  geom_line(size =0.6,position=position_dodge(0.5))+
  geom_point(aes(color=est_type), size = 2,position=position_dodge(0.5))+
  geom_errorbar(aes(ymin=-1*testrisk-stdtestrisk, ymax=-1*testrisk+stdtestrisk), width=.2,
                position=position_dodge(0.5))+
  labs(y=TeX("$\\frac{1}{K}\\sum_{i=1}^K(\\frac{1}{M_i}\\sum_{j=1}^{M_i}\\eta_{ij}^Tx)$"))+
  theme_bw(base_size = 22)+
  scale_x_discrete(name="96 months (6 sliding windows)")+
  scale_shape_manual(values = c(15, 16, 17, 18))+
  scale_color_manual(values = trop)+
  geom_hline(yintercept=0, linetype='dashed')+
  theme(legend.position="none")
test_risk

ggsave( file = "out_of_sample_risk.pdf", width = 7, height = 6)


########
#Calculate the cumulative

# Train
train_dat<-
  data.frame(
    rbind(
      cumsum(as.numeric(dat1["trainrisk",])),
      cumsum(as.numeric(dat2["trainrisk",])),
      cumsum(as.numeric(dat3["trainrisk",])),
      cumsum(as.numeric(dat4["trainrisk",])))
  )
rownames(train_dat) <- levels(resAll$est_type)


dat_long <- gather(train_dat, window, myvalues, X1:X6, factor_key = T)
dat_long_long <- data.frame(dat_long, est_type = rep(rownames(train_dat), 6))
levels(dat_long_long$window) <- 1:6
cumu_in_sample = ggplot(data = dat_long_long, 
                        aes(x = window, y = -1*myvalues, 
                            color=est_type, group = est_type, shape = est_type)) +
  geom_line(size =0.6,position=position_dodge(0.5))+
  geom_point(aes(color=est_type), size = 2,position=position_dodge(0.5))+
  labs(y=TeX("$\\sum_{(1,\\cdots,6)}\\frac{1}{N}\\sum_{i=1}^N(\\frac{1}{M_i}\\sum_{j=1}^{M_i}\\eta_{ij}^Tx)$"))+
  theme_bw(base_size = 22)+
  scale_x_discrete(name="96 months (6 sliding windows)")+
  scale_shape_manual(values = c(15, 16, 17, 18))+
  scale_color_manual(values = trop)+
  geom_hline(yintercept=0, linetype='dashed')+
  theme(legend.position="none")
cumu_in_sample

ggsave( file = "cumu_in_sample_risk.pdf", width = 7, height = 6)

# Test
train_dat<-
  data.frame(
    rbind(
      cumsum(as.numeric(dat1["testrisk",])),
      cumsum(as.numeric(dat2["testrisk",])),
      cumsum(as.numeric(dat3["testrisk",])),
      cumsum(as.numeric(dat4["testrisk",])))
  )
rownames(train_dat) <- levels(resAll$est_type)


dat_long <- gather(train_dat, window, myvalues, X1:X6, factor_key = T)
dat_long_long <- data.frame(dat_long, est_type = rep(rownames(train_dat), 6))
levels(dat_long_long$window) <- 1:6
cumu_out_sample_none = ggplot(data = dat_long_long, 
                              aes(x = window, y = -1*myvalues, 
                                  color=est_type, group = est_type, shape = est_type)) +
  geom_line(size =0.6,position=position_dodge(0.5))+
  geom_point(aes(color=est_type),size = 2,position=position_dodge(0.5))+
  labs(y=TeX("$\\sum_{(1,\\cdots,6)}\\frac{1}{K}\\sum_{i=1}^K(\\frac{1}{M_i}\\sum_{j=1}^{M_i}\\eta_{ij}^Tx)$"))+
  theme_bw(base_size = 22)+
  scale_x_discrete(name="96 months (6 sliding windows)")+
  scale_shape_manual(values = c(15, 16, 17, 18))+
  scale_color_manual(values = trop)+
  geom_hline(yintercept=0, linetype='dashed')+
  theme(legend.position="none")



cumu_out_sample_none

ggsave( file = "cumu_out_of_sample_risk.pdf", width = 7, height = 6)


###########legend#############
cumu_out_sample = ggplot(data = dat_long_long, 
                         aes(x = window, y = -1*myvalues, 
                             color=est_type, group = est_type, shape = est_type)) +
  geom_line(size =0.5,position=position_dodge(0.3))+
  geom_point(aes(color=est_type),size = 2,position=position_dodge(0.3))+
  scale_x_discrete(name="96 months (6 sliding windows)")+
  scale_shape_manual(values = c(15, 16, 17, 18), 
                     labels = c(expression(
                       paste("Chance constraint with ", alpha, " = 0.5, ", epsilon, " = 5%")),
                       expression(
                         paste("Chance constraint with ", alpha, " = 0.5, ", epsilon, " = 15%")),
                       expression(
                         paste("Chance constraint with ", alpha, " = 0.5, ", epsilon, " = 25%")),
                       "Without chance constraint"
                     ), name = "")+
  scale_color_manual(values = trop,   labels = c(expression(
    paste("Chance constraint with ",alpha, " = 0.5, ", epsilon, " = 5%")),
    expression(
      paste("Chance constraint with ", alpha, " = 0.5, ", epsilon, " = 15%")),
    expression(
      paste("Chance constraint with ", alpha, " = 0.5, ", epsilon, " = 25%")),
    "Without chance constraint"
  ), name = "")+
  geom_hline(yintercept=0, linetype='dashed')+
  theme_bw()+
  theme(legend.text.align= 0.5,legend.position="top")


