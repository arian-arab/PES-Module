function spectrum_2d_flip_lr(data)
for k=1:length(data)
    data{k}.x_data = -1*data{k}.x_data;
    if data{k}.x_data(2)<data{k}.x_data(1)
        data{k}.x_data = flipud(data{k}.x_data);
        data{k}.c_data = fliplr(data{k}.c_data);
    end  
end
    spectrum_2d_plot(data)
end