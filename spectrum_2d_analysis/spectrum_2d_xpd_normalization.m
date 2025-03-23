function spectrum_2d_xpd_normalization(data)
for k=1:length(data)
    min_y(k) = min(data{k}.y_data);
    max_y(k) = max(data{k}.y_data);
end
y1 = num2str(min(min_y));
y2 = num2str(max(max_y));
InputValues = inputdlg({'y_initial','y_final'},'',1,{y1,y2});
if isempty(InputValues)==1
    return
else
    for k=1:length(data)        
        y_data = data{k}.y_data;
        c_data = data{k}.c_data;
        y1 = str2double(InputValues{1});
        y2 = str2double(InputValues{2});
        [~,YI1]=min(abs(y_data-y1));
        [~,YI2]=min(abs(y_data-y2));
        I1=min(YI1,YI2);
        I2=max(YI1,YI2);
        if I1==I2
            return
        else
            c_data_cropped = c_data(I1:I2,:);
            avg_spectra = sum(c_data_cropped,1)/size(c_data_cropped,1);
            c_data_norm = c_data./avg_spectra;
            data{k}.c_data = c_data_norm;
            clear c_data_cropped avg_spectra c_data_norm  
        end  
        clear y_data c_data y1 y2 YI1 YI2 I1 I2
    end
    spectrum_2d_plot(data)
end    
end