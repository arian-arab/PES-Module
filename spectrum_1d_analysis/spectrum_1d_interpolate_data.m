function spectrum_1d_interpolate_data(data)
input_values = inputdlg({'Change number of data points to:'},'',1,{num2str(length(data{1}.x_data))});
if isempty(input_values)==1
    return
else
    n=str2double(input_values{1,1});
    for k=1:length(data)
        y_data_interp=(interp1(data{k}.x_data,data{k}.y_data,linspace(data{k}.x_data(1),data{k}.x_data(end),n)))';
        x_data_interp=(linspace(data{k}.x_data(1),data{k}.x_data(end),n))';
        data{k}.x_data = x_data_interp;
        data{k}.y_data = y_data_interp;        
    end
    spectrum_1d_plot(data)
end
end