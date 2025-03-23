function [vf,dvdpar]=fadderiv(v,par0)
v0=par0(1,:);  % peak position,   [v1 v2 ...]
s=par0(2,:);   % intensity,       [s1 s2 ...]
ag=par0(3,:);  % Gaussian width,  [ag1 ag2 ...]
al=par0(4,:);  % Lorentzian width,[al1 al2 ...]
% vectorize parameters
aD=(ones(length(v),1)*ag);
aL=(ones(length(v),1)*al);
S=(ones(length(v),1)*s);
vv0=v*ones(1,length(v0))-ones(length(v),1)*v0;
x=vv0.*(sqrt(log(2)))./aD;
y=ones(length(v),1)*(al./ag)*(sqrt(log(2)));
z=x+1i*y;
w = fadf(z);      
vf=real(w)*s'; 
K=real(w);L=imag(w);
% derivatives
dvds=K;
c1=y.*y;
c2=x.*y;
dVdvj=2*(c2.*K-c1.*L)./aL;
dVdad=2*((x.*x-c1).*K-2*c2.*L+y./sqrt(pi))./aD;
dVdal=2*(c2.*L+c1.*K-y./sqrt(pi))./aL;
vjs=dVdvj.*S;
ags=dVdad.*S;
als=dVdal.*S;
der=[vjs ;dvds;ags ;als];
dvdpar=reshape(der,[length(v) numel(par0)]);
end