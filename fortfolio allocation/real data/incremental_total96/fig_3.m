
clear;
load a_train_risk_w1.mat
load a_test_risk_w1.mat
load c_train_risk_w1.mat
load c_test_risk_w1.mat

figure(1)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,-1*a_train_risk_w1,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_train_risk_w1,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2014.2-2016.2','fontsize',20)
title('window 1','fontsize',20)
ylabel('return on training','fontsize',20)


figure(2)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,-1*a_test_risk_w1,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_test_risk_w1,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2016.2-2017.2','fontsize',20)
title('window 1','fontsize',20)
ylabel('return on testing','fontsize',20)

figure(3)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,cumsum(-1*a_train_risk_w1),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_train_risk_w1),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2014.2-2016.2','fontsize',20)
title('window 1','fontsize',20)
ylabel('cumulative return on training','fontsize',20)

figure(4)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,cumsum(-1*a_test_risk_w1),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_test_risk_w1),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2016.2-2017.2','fontsize',20)
title('window 1','fontsize',20)
ylabel('cumulative return on testing ','fontsize',20)

clear;
load a_train_risk_w2.mat
load a_test_risk_w2.mat
load c_train_risk_w2.mat
load c_test_risk_w2.mat
figure(5)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,-1*a_train_risk_w2,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_train_risk_w2,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2015.2-2017.2','fontsize',20)
title('window 2','fontsize',20)
ylabel('return on training ','fontsize',20)

figure(6)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,-1*a_test_risk_w2,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_test_risk_w2,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2017.2-2018.2','fontsize',20)
title('window 2','fontsize',20)
ylabel('return on testing ','fontsize',20)

figure(7)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,cumsum(-1*a_train_risk_w2),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_train_risk_w2),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2015.2-2017.2','fontsize',20)
title('window 2','fontsize',20)
ylabel('cumulative return on training ','fontsize',20)

figure(8)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,cumsum(-1*a_test_risk_w2),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_test_risk_w2),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2017.2-2018.2','fontsize',20)
title('window 2','fontsize',20)
ylabel('cumulative return on testing ','fontsize',20)

clear;
load a_train_risk_w3.mat
load a_test_risk_w3.mat
load c_train_risk_w3.mat
load c_test_risk_w3.mat

figure(9)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,-1*a_train_risk_w3,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_train_risk_w3,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2016.2-2018.2','fontsize',20)
title('window 3','fontsize',20)
ylabel('return on training ','fontsize',20)

figure(10)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,-1*a_test_risk_w3,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_test_risk_w3,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2018.2-2019.2','fontsize',20)
title('window 3','fontsize',20)
ylabel('return on testing','fontsize',20)

figure(11)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,cumsum(-1*a_train_risk_w3),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_train_risk_w3),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2016.2-2018.2','fontsize',20)
title('window 3','fontsize',20)
ylabel('cumulative return on training','fontsize',20)

figure(12)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,cumsum(-1*a_test_risk_w3),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_test_risk_w3),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2018.2-2019.2','fontsize',20)
title('window 3','fontsize',20)
ylabel('cumulative return on testing','fontsize',20)


clear;
load a_train_risk_w4.mat
load a_test_risk_w4.mat
load c_train_risk_w4.mat
load c_test_risk_w4.mat
figure(13)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,-1*a_train_risk_w4,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_train_risk_w4,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2017.2-2019.2','fontsize',20)
title('window 4','fontsize',20)
ylabel('return on training','fontsize',20)

figure(14)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,-1*a_test_risk_w4,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_test_risk_w4,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2019.2-2020.2','fontsize',20)
title('window 4','fontsize',20)
ylabel('return on testing','fontsize',20)

figure(15)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,cumsum(-1*a_train_risk_w4),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_train_risk_w4),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2017.2-2019.2','fontsize',20)
title('window 4','fontsize',20)
ylabel('cumulative return on training ','fontsize',20)

figure(16)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,cumsum(-1*a_test_risk_w4),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_test_risk_w4),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2019.2-2020.2','fontsize',20)
title('window 4','fontsize',20)
ylabel('cumulative return on testing','fontsize',20)


clear;
load a_train_risk_w5.mat
load a_test_risk_w5.mat
load c_train_risk_w5.mat
load c_test_risk_w5.mat
figure(17)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,-1*a_train_risk_w5,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_train_risk_w5,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2018.2-2020.2','fontsize',20)
title('window 5','fontsize',20)
ylabel('return on training','fontsize',20)

figure(18)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,-1*a_test_risk_w5,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_test_risk_w5,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2020.2-2021.2','fontsize',20)
title('window 5','fontsize',20)
ylabel('return on testing','fontsize',20)

figure(19)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,cumsum(-1*a_train_risk_w5),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_train_risk_w5),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2018.2-2020.2','fontsize',20)
title('window 5','fontsize',20)
ylabel('cumulative return on training','fontsize',20)

figure(20)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,cumsum(-1*a_test_risk_w5),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_test_risk_w5),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2020.2-2021.2','fontsize',20)
title('window 5','fontsize',20)
ylabel('cumulative return on testing','fontsize',20)

clear;
load a_train_risk_w6.mat
load a_test_risk_w6.mat
load c_train_risk_w6.mat
load c_test_risk_w6.mat
figure(21)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,-1*a_train_risk_w6,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_train_risk_w6,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2019.2-2021.2','fontsize',20)
title('window 6','fontsize',20)
ylabel('return on training','fontsize',20)

figure(22)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,-1*a_test_risk_w6,'-*r','LineWidth',1)
hold on 
plot(month_size,-1*c_test_risk_w6,'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2021.2-2022.2','fontsize',20)
title('window 6','fontsize',20)
ylabel('return on testing','fontsize',20)

figure(23)
month_size = 1:24;
xy = zeros(24,1);
plot(month_size,cumsum(-1*a_train_risk_w6),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_train_risk_w6),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2019.2-2021.2','fontsize',20)
title('window 6','fontsize',20)
ylabel('cumulative return on training','fontsize',20)

figure(24)
month_size = 1:12;
xy = zeros(12,1);
plot(month_size,cumsum(-1*a_test_risk_w6),'-*r','LineWidth',1)
hold on 
plot(month_size,cumsum(-1*c_test_risk_w6),'-ob','LineWidth',1)
hold on 
plot(month_size,xy,'--k','LineWidth',1)
legend('c=0.5,\epsilon=5%','without chance constraint')
xlabel('2021.2-2022.2','fontsize',20)
title('window 6','fontsize',20)
ylabel('cumulative return on testing','fontsize',20)


