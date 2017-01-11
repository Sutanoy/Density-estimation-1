function L = FormpenLikeihoodFromC(c,X,N,fp,p,t)
 
%%%%%%%%%%%%%%%Penalized likelihood%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Steps are identical to unpenalized likelihood except last line
gam0 = FormGammaFromC(c,p);
gam = (gam0-gam0(1))/(gam0(end)-gam0(1));
gamDot = gradient(gam,mean(diff(t)));

fn = interp1(t, fp, (t(end)-t(1)).*gam + t(1)).*gamDot ;

tt = (1:5*N)/(5*N); 
fnL = interp1(t, fn, tt);
fnL(1:4) = fn(1); 
dm=ones(1,size(X,2))*5*N;
dm2=1+round(5*X*N);
dummymatrix2=cat(1,dm2,dm);
med=min(dummymatrix2);
yy = fnL(med);
 L = -2*sum(log(yy)) + 2*length(c);%calculating AIC instead of negative log likelihood

 
