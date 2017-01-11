
%function [X,a0,b0,t,g0] = GenerateData(n)
function [X,t,f0] = GenerateData(n)
%%%%%% generate from mixture beta 1 %%%%%%%
% u=rand(1,n);
% X=betarnd(1,3,1,n).*(u<1/3)+ betarnd(1,4,1,n).*(u>1/3 & u<2/3) +betarnd(3,47,1,n).*(u>2/3);
% 
% 
% N = 100;
% t = (1:N)/N;
% 
% f0 = (betapdf(t,1,3) + betapdf(t,1,4) + betapdf(t,3,47))/3;
%%%%%% generate from mixture beta 2 %%%%%%%
% u=rand(1,n);
% X=betarnd(1,3,1,n).*(u<1/3)+ betarnd(1,4,1,n).*(u>1/3 & u<2/3) +betarnd(47,3,1,n).*(u>2/3);
% 
% 
% N = 100;
% t = (1:N)/N;
% 
% f0 = (betapdf(t,1,3) + betapdf(t,1,4) + betapdf(t,47,3))/3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Generate from mixture normal %%%%%%%%%%%
% t = -6:0.01:6;
% dt=0.01;
%  x=sqrt(1/10);
% % % %% CLAW DENSITY %%INCLUDE last 3 lines
%  f0 = 0.5*normpdf(t,0,1) + x*normpdf(t,-1,x^2)+ x*normpdf(t,0.5-1,x^2)+ x*normpdf(t,1-1,x^2)+ x*normpdf(t,1.5-1,x^2)+ x*normpdf(t,2-1,x^2);
% % % % %% kurtotic unimodal density %%
% % % % %f0=(2/3)*normpdf(t,0,1) + (1/3)*normpdf(t,0,10);
% % % % %%
%  f0 = f0/(sum(f0)*dt);
% % f0=normpdf(t,-1,0.5)/2 + normpdf(t,1,0.4)/2;
% f = f0;
% 
% F = cumsum(f)*dt; 
% 
% for i = 1:n
%     u = rand;
%     X(i) = t(min(find(F > u)));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%Generate from density in Tokdar paper%%%%
% N = 100;
% t = (1:N)/N;
% 
% x=0.2;
% f0 =0.75*3*exp((-3.*t)) + 0.25*sqrt(32/pi)*exp(-32.*((t-.75).^2)); 
% 
% f0 = f0/sum(f0/N);
% 
% f = f0;
% 
% F = cumsum(f)/N; 
% for i = 1:n
%     u = rand;
%     X(i) = t(min(find(F > u)));
%  end
