function spectrum_2d_transpose(data)
for k=1:length(data)
    data{k}.c_data = data{k}.c_data';
    x_data_res = data{k}.x_data;
    y_data_res = data{k}.y_data;
    data{k}.x_data = y_data_res;
    data{k}.y_data = x_data_res;
    clear x_data_res y_data_res    
end
    spectrum_2d_plot(data)
end