function spectrum_1d_flip_lr(data)
for k=1:length(data)
    x_data_res = -1*data{k}.x_data;
    x_data_res = flipud(x_data_res); 
    y_data_res = flipud(data{k}.y_data);
    data{k}.x_data = x_data_res;
    data{k}.y_data = y_data_res;
end
    spectrum_1d_plot(data)
end