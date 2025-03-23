function spectrum_1d_combine_to_image(data)
if length(data)>1
    for k=1:length(data)
        length_data(k) = length(data{k}.x_data);
    end
    n = max(length_data);
    for k=1:length(data)
        y_data_interp=(interp1(data{k}.x_data,data{k}.y_data,linspace(data{k}.x_data(1),data{k}.x_data(end),n)))';
        x_data_interp=(linspace(data{k}.x_data(1),data{k}.x_data(end),n))';
        data{k}.x_data = x_data_interp;
        data{k}.y_data = y_data_interp;
    end
    for k=1:length(data)
        c_data(:,k) = data{k}.y_data;
    end
    data_image{1}.y_data = x_data_interp;
    data_image{1}.x_data = (1:size(c_data,2))';
    data_image{1}.c_data = c_data;
    data_image{1}.type = 'spectrum_2d';
    data_image{1}.info = 'NaN';
    data_image{1}.name = 'Combined into 2D Spectrum';
    spectrum_2d_plot(data_image)
else
    msgbox('more than one spectra should be selected')
end
end