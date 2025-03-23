function spectrum_1d_subtract_shirley(data)
f = waitbar(0,'subtracting shirley');
for k=1:length(data)
    if size(data{k}.y_data,1)>1
        data{k}.y_data = data{k}.y_data';
    end
    I_left=data{k}.y_data(end);
    I_right=data{k}.y_data(1);
    spectrum_B1=data{k}.y_data-I_right;
    for i=1:length(data{k}.y_data)
        B1(i)=trapz(spectrum_B1(1:i));
    end
    k1=I_left/B1(end);
    for j=2:30
        spectrum_second=spectrum_B1-B1*k1;
        for i=1:length(data{k}.y_data)
            B2(i)=trapz(spectrum_second(1:i));
        end
        k2=(I_left-I_right)./trapz(spectrum_second);
        B1=B2;
        k1=k2;
    end
    shirley_data = B2*k2;
    shirley_data = shirley_data-shirley_data(end)+data{k}.y_data(end);
    
    data{k}.y_data=(data{k}.y_data-(B2*k2+data{k}.y_data(1)))';
    data{k}.name = [data{k}.name,'_shirley_subtracted'];
    
    data_shirley{k}.x_data = data{k}.x_data;    
    data_shirley{k}.y_data = shirley_data';
    data_shirley{k}.name = [data{k}.name,'_shirley_data'];
    data_shirley{k}.type = 'spectrum_1d';
    data_shirley{k}.info = 'NaN';
    clear SpectrumB1 B1 k1 B2 k2 I_left I_right shirley_data
    waitbar(k/length(data),f,'subtracting shirley')
end
close(f)
spectrum_1d_plot(data)
spectrum_1d_plot(data_shirley)
end
