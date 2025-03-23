function [profile]=gauss(x_data,fwhm)
c=fwhm/sqrt(8*log(2));
profile=0.5885*(exp(-((x_data).^2)./(2*c*c)));
end