function spectrum_1d_switch_x_y_data(data)
for k=1:length(data)
    x_data_res = data{k}.x_data;
    y_data_res = data{k}.y_data;
    data{k}.x_data = y_data_res;
    data{k}.y_data = x_data_res;
end
    spectrum_1d_plot(data)
end