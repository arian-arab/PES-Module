function spectrum_1d_mean_spectrum(data)
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

mean = data{1}.y_data-data{1}.y_data;
for k=1:length(data)
    mean = mean+data{k}.y_data;
end
mean = mean/length(data);
data_mean{1}.x_data = data{1}.x_data;
data_mean{1}.y_data = mean;
data_mean{1}.name='mean spectrum';
data_mean{1}.type = 'spectrum_1d';
data_mean{1}.info = 'NaN';
spectrum_1d_plot(data_mean)
end
