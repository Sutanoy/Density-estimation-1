function fn=densitygenerator(X,A,B,Algo,fp,Phi,grid,Kn,K_init,K_step)

X=(X-A)/(B-A);%scaling the data
t=(grid-A)/(B-A);%retrieving scaled grid
N=length(t);%grid length
options = optimset('MaxFunEvals',120000,'MaxIter',120000);
m=size(Phi,1);% (maximum) No. of basis elements
if Algo==0 %Not using algorithm 1
    d=fminsearch(@(c)FormLikeihoodFromC(c,X,N,fp,Phi,t),zeros(1,m),options);%optimal coefficients obtained
    gamEst = FormGammaFromC(d,Phi);%H^(-1)(d) as defined in manuscript, to represent warping function
    gamDot = gradient(gamEst,mean(diff(t)));
    fn = interp1(t, fp, (t(end)-t(1)).*gamEst + t(1)).*gamDot;%Warping transformation
    fn=fn/(sum(fn)/N);%normalized
    fn=fn/(B-A); %un-scaled for original data
else
    
    KK=K_init:K_step:Kn;%No. of basis elements at each step
    KK=[KK (Kn+2)];
    KK1=ceil(KK/2);%no. of sine components
    KK2=KK-KK1;%no. of cosine components
    start=zeros(1,K_init);start1=start;%two starting points
    iter=1;
    ll(1)=0;ll(2)=0;ll1=ll;%initializations
    while (iter <length(KK) )
        p1=Phi(1:KK1(iter),:);%sine
        p2=Phi((ceil(Kn/2)+1):(ceil(Kn/2)+KK2(iter)),:);%cosine
        p=[p1;p2];
        dcell{iter}=fminsearch(@(c)FormpenLikeihoodFromC(c,X,N,fp,p,t),start,options);%using value of previous step as starting point
        dcell1{iter}=fminsearch(@(c)FormpenLikeihoodFromC(c,X,N,fp,p,t),start1,options);%using 0 as starting point
        ll(iter)=FormpenLikeihoodFromC(dcell{iter},X,N,fp,p,t);
        ll1(iter)=FormpenLikeihoodFromC(dcell1{iter},X,N,fp,p,t);
        ll0(iter)=min(ll(iter),ll1(iter));
        d=dcell{iter}*(ll(iter)<=ll1(iter)) + dcell1{iter}*(ll(iter)>ll1(iter));%setting optimal value as better of the two solutions
        d_chosen{iter}=d;
        d1=d(1:KK1(iter));
        d2=d((KK1(iter)+1):end);
        iter=iter+1;
        Z1=zeros(1,KK1(iter)-length(d1));
        Z2=zeros(1,KK2(iter)-length(d2));
        start=[d1,Z1,d2,Z2];%using the optimal value as the subsequent starting point 
        start1=[zeros(1,length(d1)),Z1,zeros(1,length(d2)),Z2];%Using 0 throughout
    end
    [~,i]=min(ll0);%choosing the best solution 
    p1=Phi(1:KK1(i),:);%Number of basis elements corresponding to the best solution
    p2=Phi((ceil(Kn/2)+1):(ceil(Kn/2)+KK2(i)),:);
    Phiopt=[p1;p2];
    gamEst = FormGammaFromC(d_chosen{i},Phiopt);%warping function corresponding to the solution producing best objective function
    gamDot = gradient(gamEst,mean(diff(t)));
    fn = interp1(t, fp, (t(end)-t(1)).*gamEst + t(1)).*gamDot;%creating the corresponding density estimate
    fn=fn/(B-A);
end