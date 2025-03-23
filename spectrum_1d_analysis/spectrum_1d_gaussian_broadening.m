function spectrum_1d_gaussian_broadening(data)
input_values = inputdlg({'Gaussian FWHM (eV):'},'',1,{'1'});
if isempty(input_values)==1
    return
else
    fwhm = str2double(input_values{1});    
    kB=8.6173303*10^(-5);
    a = (2*sqrt(log(2)))/(pi*fwhm);
    b = -4*log(2)/(fwhm^2);
    f = waitbar(0,'broadening');
    for k=1:length(data)        
        x = data{k}.x_data;
        y = data{k}.y_data; 
        for i=1:length(x) 
            gaussian_profile =  a*exp(b*((x-x(i)).^2));
            y_conv(i) = trapz(x,gaussian_profile.*y);
        end        
        data{k}.y_data = y_conv;
        clear x gaussian_profile y_conv
        waitbar(k/length(data),f,'broadening')
    end
    close(f)
end
spectrum_1d_plot(data)
end