function spectrum_2d_integrate_along_y(data)
f = waitbar(0,'integrating');
for k=1:length(data)
    waitbar(k/length(data),f,'integrating');
    int_along=sum(data{k}.c_data,1)';
    x_data = data{k}.x_data;
    if x_data(2)<x_data(1)
        x_data = flipud(x_data);
        int_along = flipud(int_along);
    end
    data_to_send{k}.x_data = x_data;
    data_to_send{k}.y_data = int_along;
    data_to_send{k}.type = 'spectrum_1d';
    data_to_send{k}.info = 'NaN';
    data_to_send{k}.name = [data{k}.name,'_int_along_y'];
end
close(f)
spectrum_1d_plot(data_to_send)
end