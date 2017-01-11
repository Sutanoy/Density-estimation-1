function L = FormLikeihoodFromC(c,X,N,fp,p,t)

%%%%%%%%%%%%%%%Unpenalized likelihood%%%%%%%%%%%%%%%%%%%%%%%%%%

gam0 = FormGammaFromC(c,p);
gam = (gam0-gam0(1))/(gam0(end)-gam0(1));
gamDot = gradient(gam,1/N);

fn = interp1(t, fp, (t(end)-t(1)).*gam + t(1)).*gamDot ;

tt = (1:5*N)/(5*N); %form a temporary 5 times deser grid
fnL = interp1(t, fn, tt);%find fn on denser grid
fnL(1:4) = fn(1); %set the first 4 evaluation points same as 1st point, for efficiency. Numerical error is negligible
dm=ones(1,size(X,2))*5*N;
dm2=1+round(5*X*N);%approximating X by the index of the nearest dense grid point
dummymatrix2=cat(1,dm2,dm);%Ensuring the grid index does not exceed the maximum index(occurs when X=1)
med=min(dummymatrix2);
yy = fnL(med);%approximating fnL(X) by evaluating fnL on a very dense grid. 
%Alternately one can use extrapolation in the interval [0,1/N) or simply
%use 0 as a grid point.
 L = -sum(log(yy));%unpenalized log likelihood


