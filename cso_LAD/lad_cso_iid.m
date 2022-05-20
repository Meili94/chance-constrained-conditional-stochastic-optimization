%% condtional stochastic optimization with LAD loss (use CVX package) and independent sampling
clc; close all; clear all; warning off; rng('default'); 
addpath(genpath(pwd));

%% setup
%generate dependent Xi with P2P network
NumStates = 10; %the number of computer
m_each = 20000; %the sample size of each computer
m = 10; %dimension of decision variable
beta_intial = randn(m,1);
sigma_a = 1; %we change 0.1 and 1
for i = 1:NumStates
MU = 0 + 1*randn(m,1); 
SIGMA = sigma_a*eye(m);
XI(:,:,i) =  mvnrnd(MU,SIGMA,m_each,m);
beta(:,i) = beta_intial + 0.1*randn(m,1);
end
temp  =  1;
TempXI = XI;
%% markov chain 
P = 1/(NumStates-1)*ones(NumStates)-1/(NumStates-1)*eye(NumStates); % transf matrix
mc = dtmc(P); %markov chain process 
x0 = zeros(1,NumStates);
x0(1) = 1; %start at point 1

%the number of samples
T = 1e3; %we change T from 1e3 to 1e6
n = floor(T^(1/2)); 
numSteps = n-1; 

for ii = 1:30
Xstates = simulate(mc,numSteps,'X0',x0);
for j = 1:size(Xstates,1)
Xt = TempXI(:,:,Xstates(j));
x  = Xt(temp,:);
X(j,:) = x;
y(j) = x*beta(:,Xstates(j));
Xt(temp,:) = [];
Xt = [Xt;zeros(1,m)];
TempXI(:,:,Xstates(j)) = Xt;
end
%% training dataset
b = y';
A = X;
[n,~] = size(A);

%% genearate data eta given xi(conditional stochastic optimization)
Numeta = floor(sqrt(T)); %the size of eta
sigma_s = 10;
for j = 1:Numeta
eta(j,:)  = normrnd(0,sqrt(sigma_s*1),m,1);
end
AE = sum(eta,1)/Numeta;
A = AE + X;
%%
cvx_precision(1e-3)
cvx_begin
variable x(m)
minimize(1/n*sum(abs(A*x-b)))
cvx_end
%% result
bound_upp = 0.5;
MSE_beta = norm(x-beta_intial)/sqrt(m);
pnumb(ii)  = length(find(MSE_beta<=bound_upp));
MSE_s(ii)  = MSE_beta;
average_training_lossvalues(ii)  = sum(abs(A*x-b))/n;
end
prob = sum(pnumb)/ii;

disp('------------------------------------------')
disp('Results of 30 runs')
disp(['sample size of training data: ' num2str(n)])
disp(['dimension of each observation: ' num2str(m)])
[prob,mean(MSE_s),std(MSE_s), mean(average_training_lossvalues),std(average_training_lossvalues)]