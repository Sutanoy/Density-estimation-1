function gam = FormGammaFromC(c,p)

N = size(p,2);%grid length
v = c*p;%the tangent space element

nc = norm(c,'fro');

if (nc==0)%if it is the origin of tangent space
    q=ones(1,N);%SRSF corresponding to identity warping function
else
q = cos(nc)*ones(1,N)+sin(nc)*v/nc;%the exponential map
end

gam = cumsum(q.*q)/N;%squaring and integrating numerically
gam = (gam-gam(1))/(gam(end)-gam(1));%ensuring gam(0)=0 and gam(1)=1, to remove possible small numerical errors

