function [vf,under]= voigt(v,par0)
v0=par0(1,:);
s=par0(2,:);
ag=par0(3,:);
al=par0(4,:);
aD=(ones(length(v),1)*ag);
vv0=v*ones(1,length(v0))-ones(length(v),1)*v0;
x=vv0.*(sqrt(log(2)))./aD;
y=ones(length(v),1)*(al./ag)*(sqrt(log(2)));
z=x+1i*y;
w = fadf(z); 
for i=1:size(w,2)
    under(:,i)=real(w(:,i))*s(1,i)';
end
vf=real(w)*s';
end