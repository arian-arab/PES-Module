function [parmin,residual,jacobian]= fit2voigt(dat,par0,Gb,Lb)
%-par0: initial parameters. 4 by g matrix,first row is peak position,intensity,Gaussain width,Lorentzian width
[~,ii]=sort(dat(:,1));      % sort wavenumber in increasing order
dat=dat(ii,:);
maxfeval=150*numel(par0); % maximum number of function evaluation
lb=([dat(1,1).*ones(1,length(par0(1,:))); 0*ones(1,length(par0(1,:)));Gb(1)*ones(1,length(par0(1,:)));Lb(1)*ones(1,length(par0(1,:)));]);
ub=([dat(end,1).*ones(1,length(par0(1,:)));inf* ones(1,length(par0(1,:)));Gb(2)*ones(1,length(par0(1,:)));Lb(2)*ones(1,length(par0(1,:)))]);
options=optimoptions('lsqnonlin','Algorithm','trust-region-reflective','jacobian','on','display','iter-detailed','DerivativeCheck','off','TolFun',1e-8,'TolX',1e-8,'maxfunevals',maxfeval);
[parmin,~,residual,~,~,~,jacobian]=lsqnonlin(@(par) voigtfitmin(dat,par),par0,lb,ub,options);
end

function [res,jac]= voigtfitmin(dat,par)
[vf,dvdpar]= fadderiv(dat(:,1),par);
res=vf-dat(:,2);
% Jacobian
    if nargout>1
      jac=dvdpar;
    end
end