%% portfolio optimization problem: loss function is mean mnius variance, plus L_1 norm penalty
%% with chance constraint (risk is less than risk on average allocation with high probability)
%% real data
clc; close all; clear all; warning off; rng('default'); 
addpath(genpath(pwd));
%% read real data
A = importdata('data.csv');
a = A.data(:,1);
for j = 1:97
for i = 1:12
   index = find((19260101+(j-1)*10000+(i-1)*100<=a)&(a<=19260131++(j-1)*10000+(i-1)*100));
       b = -A.data(index,2:end);
       c =  1/size(index,1)*sum(b,1);%each mounth return by averaging for each day
       Atemp((j-1)*12+i,:) = c;
end
end
Atemp(1:6,:) = [];
Atemp(end-10:end,:) = [];
%%Note that Atemp is total data, includes 1147 months from 1926.7 to 2022.2 (96 years)
Ap =  Atemp(1147-72+1:end-36,:); %choose data from 2016.2 to 2019.2
%Ap =  Atemp(1147-36+1:end,:); %choose data from 2019.2 to 2022.2
N = size(Ap,1);
A = -Ap(1:end-12,:);
%A = -Ap(ix-ss+1:ix,:);%return changes to risk
[n,m] = size(A);
%%  testing data
A_test = -Ap(end-12+1:end,:);
[n_test,~] = size(A_test);
B = A;

alpha = 0.05*1/n*sum(A*ones(m,1)); %%risk on average allocation
condi = 0.15;
s = floor(n*condi);
%% algorithm
%trade-off parameter between mean and variance
lambda = 0.5;
% penaltized parameter
r = 0.1;
% intial information
sigma = 100; tau = 1.618; tol = 1e-4; maxiter = 2000;
x = zeros(m,1); w = zeros(n,1); z = zeros(m,1);
SA = sigma*(eye(m)+B'*B);
NA = 2*lambda/n*(A'*A);
OA = 2*lambda/n^2*(A'*ones(n,1)*ones(1,n)*A);

for iter = 1:maxiter
%% u subproblem
u = -alpha+B*x-w/sigma;
T = P_heaviside(u,s);
u(T) = 0;

%% y subproblem
xz = x-z/sigma;
y = sign(xz).*max(abs(xz)-r/sigma,0);

%% x subproblem
lx = -1/n*A'*ones(n,1)+B'*w+sigma*B'*(alpha+u)+z+sigma*y;
x = (SA+NA-OA)\lx;
x = pro_unitsimplex(x,m,20,1e-3);

%% lagrangian multiplier
w = w+tau*sigma*(u+alpha-B*x);
z = z+tau*sigma*(y-x);

%% stop condition
lx = -1/n*A'*ones(n,1)+B'*w+sigma*B'*(alpha+u)+z+sigma*y;
xx = (SA+NA-OA)\lx;
xx = pro_unitsimplex(xx,m,20,1e-3);
error1 = norm(x-xx)/(1+norm(x));
error2 = norm(u+alpha-B*x)/(1+norm(x)+norm(u));
error3 = norm(y-x)/(1+norm(x)+norm(y));

if error1 < tol && error2 < tol && error3 < tol 
    fprintf('\n----------------------------------------');
            fprintf('\n  number iter = %2.0d', iter);                     
            fprintf('\n  errorl = %6.2e', error1);  
            fprintf('\n  error2 = %6.2e', error2);
            fprintf('\n  error2 = %6.2e', error3);
            fprintf('\n');
            break; 
 end   
        if mod(iter,10) == 1
         fprintf('iter = %2d,error1 = %6.2e,error2 = %6.2e,error3 = %6.2e\n',... 
         iter,error1,error2,error3);
        end 
        if iter == maxiter
         fprintf('The number of iterations reaches maxiter.');
         fprintf('\n');
        end 
end

%% estimate results
%probability  of statisfying chance constraint 
Ba = B*x-alpha;
index = find(0<Ba & Ba<1e-3); 
Ba(index) = 0;
Prob = 1-length(find(Ba<=0))/n;
Ba_test = A_test*x-alpha;
Prob_test = 1-length(find(Ba_test<=0))/n_test;
%loss values on training and testing data
Ax = A*x;
training_error = 1/n*ones(1,n)*Ax-lambda/n*sum(Ax.*Ax)+lambda/n^2*sum(ones(n,1).*Ax)^2;
Ax_test = A_test*x;
testing_error = 1/n_test*ones(1,n_test)*Ax_test-lambda/n_test*sum(Ax_test.*Ax_test)...
    +lambda/n_test^2*sum(ones(n_test,1).*Ax_test)^2;
%fortfolio allcolation risk
training_risk = A*x;
testing_risk = A_test*x;

disp('--------------------------------------------------------------------------------')
disp('Results of 100 runs')
disp(['sample size of training data: ' num2str(n)])
disp(['sample size of testing data: ' num2str(n_test)])
disp(['dimension of each observation: ' num2str(m)])
fprintf('conditional interval: %4.1f%%\n', (condi)*100)
disp(['average estimate probability: ' num2str(mean(Prob))])
disp(['standard deviation of estimate probability: ' num2str(std(Prob))])
disp(['average estimate probability: ' num2str(mean(Prob_test))])
disp(['standard deviation of estimate probability: ' num2str(std(Prob_test))])
disp(['loss value on training data: ' num2str(mean(training_error))])
disp(['standard deviation of loss value on training data: ' num2str(std(training_error))])
disp(['loss value on testing data: ' num2str(mean(testing_error))])
disp(['standard deviation of loss value on testing data: ' num2str(std(testing_error))])
disp(['risk on training data: ' num2str(mean(training_risk))])
disp(['standard deviation of risk on training data: ' num2str(std(training_risk))])
disp(['risk on testing data: ' num2str(mean(testing_risk))])
disp(['standard deviation of risk on testing data: ' num2str(std(testing_risk))])