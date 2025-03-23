function spectrum_2d_flip_ud(data)
for k=1:length(data)
    data{k}.y_data = -1*data{k}.y_data;
    if data{k}.y_data(2)<data{k}.y_data(1)
        data{k}.y_data = flipud(data{k}.y_data);
        data{k}.c_data = flipud(data{k}.c_data);
    end 
end
    spectrum_2d_plot(data)
end