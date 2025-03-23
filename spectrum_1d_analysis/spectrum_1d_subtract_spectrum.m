function spectrum_1d_subtract_spectrum(data)
if length(data)>2
    msgbox('only two spectra can be selected')
elseif length(data) ==1
    msgbox('two spectra should be selected')
else
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
    subtract = data{1}.y_data-data{2}.y_data;
    data_subtract{1}.x_data = data{1}.x_data;
    data_subtract{1}.y_data = subtract;
    data_subtract{1}.name='subtracted spectrum';
    data_subtract{1}.type = 'spectrum_1d';
    data_subtract{1}.info = 'NaN';
    spectrum_1d_plot(data_subtract)
end
end
