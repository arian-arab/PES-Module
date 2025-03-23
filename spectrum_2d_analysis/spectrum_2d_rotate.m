function spectrum_2d_rotate(data)
InputValues = inputdlg({'rotate by:'},'',1, {'1'});
if isempty(InputValues)==1
    return
else
    Value=str2double(InputValues{1});
    for k=1:length(data)
        x_int=data{k}.x_data(1);
        x_ste=data{k}.x_data(2)-data{k}.x_data(1);
        y_int=data{k}.y_data(1);
        y_ste=data{k}.y_data(2)-data{k}.y_data(1);
        data{k}.c_data = imrotate(data{k}.c_data,Value);
        data{k}.x_data = x_int:x_ste:x_int+(size(data{k}.c_data,2)-1)*x_ste;
        data{k}.y_data = y_int:y_ste:y_int+(size(data{k}.c_data,1)-1)*y_ste;
        clear x_int x_ste y_int y_ste
    end
    spectrum_2d_plot(data)
end
end