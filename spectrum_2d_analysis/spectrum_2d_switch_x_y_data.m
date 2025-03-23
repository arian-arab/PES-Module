function spectrum_2d_switch_x_y_data(data)
for k=1:length(data)
    x_ini = data{k}.x_data(1);
    x_step = data{k}.x_data(2)-data{k}.x_data(1);
    y_ini = data{k}.y_data(1);
    y_step = data{k}.y_data(2)-data{k}.y_data(1);  
    data{k}.y_data= (x_ini:x_step:x_ini+(size(data{k}.c_data,1)-1)*x_step)';
    data{k}.x_data= (y_ini:y_step:y_ini+(size(data{k}.c_data,2)-1)*y_step)'; 
end
    spectrum_2d_plot(data)
end