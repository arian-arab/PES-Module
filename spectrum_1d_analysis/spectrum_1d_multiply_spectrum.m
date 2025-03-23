function spectrum_1d_multiply_spectrum(data)
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

multiply = (data{1}.y_data-data{1}.y_data)+1;
for k=1:length(data)
    multiply = multiply.*data{k}.y_data;
end
data_multiply{1}.x_data = data{1}.x_data;
data_multiply{1}.y_data = multiply;
data_multiply{1}.name='multiplied spectrum';
data_multiply{1}.type = 'spectrum_1d';
data_multiply{1}.info = 'NaN';
spectrum_1d_plot(data_multiply)
end
