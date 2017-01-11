clear all;
close all;

%X=normrnd(0,1,1,100);
[X,t_true,f_true]=GenerateData(500);
n=length(X);
N=100;
gridlength=N;
grid_scaled=(1:N)/N;%grid for data scaled to [0,1]
%%%%%%%%%%%%%%%%%% Information regarding support %%%
%%%%% IS the support known to be [0,1] ?
supportindicator=1;%supportindicator=1 if support known to be [0,1]
[fp,xi]=ksdensity(X,grid_scaled);
fp=fp/(sum(fp)/N);
A=0;B=1;
grid=grid_scaled*(B-A)+A;
%%%%% IF the support is not [0,1] or unknown
% supportindicator=0;
% A=min(X) - std(X)/sqrt(n);
% B=max(X) + std(X)/sqrt(n);
% X_scaled=(X-A)/(B-A);
% grid=grid_scaled*(B-A)+A;
% [fp,xi]=ksdensity(X_scaled,grid_scaled);
% fp=fp/(sum(fp)/N);
%%%%%%%%%%%%% Decision regarding algorithm 1 %%%%%%%%%%%%
Usealgorithm=1;
%%if using algorithm 1%%
Kn=13;%Max_no_of_basis_elements;
K_init=2;%initial_no_of_basis_elements;
K_step=2;%Step_size. Kn-K_init must be divisible by K-step

%%if NOT using algorithm 1%%
% Usealgorithm=0;
% Kn=10;%No_of_basis_elements;
% K_init=Kn;
% K_step=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Set basis elements to use %%%
%% Fourier %%
T = 2*pi*grid_scaled;
if (mod(Kn,2)==0)%if maximum allowed basis elements is even number
     K = Kn/2;
     Phi(1:K,:) = sqrt(2)*sin((1:K)'*T);
     Phi(K+1:2*K,:) = sqrt(2)*cos((1:K)'*T);
     m = size(Phi,1);
else
     K =(1+Kn)/2;
     Phi(1:K,:) = sqrt(2)*sin((1:K)'*T);
     Phi(K+1:2*K,:) = sqrt(2)*cos((1:K)'*T);
     Phi=Phi(1:(end-1),:);
     m = size(Phi,1);
end
%% Meyer %%
% J=2;%number of generations desired by user
% K=7;%horizontal translated desired by user
% Phi=meyerbasisgenerator(J,K,grid_scaled);
%% Write your own basis set here if desired %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=densitygenerator(X,A,B,Usealgorithm,fp,Phi,grid,Kn,K_init,K_step);

plot(grid,fn)