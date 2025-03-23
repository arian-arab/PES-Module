function spectrum_1d_add_spectrum(data)
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

add = data{1}.y_data-data{1}.y_data;
for k=1:length(data)
    add = add+data{k}.y_data;
end
data_add{1}.x_data = data{1}.x_data;
data_add{1}.y_data = add;
data_add{1}.name='added spectrum';
data_add{1}.type = 'spectrum_1d';
data_add{1}.info = 'NaN';
spectrum_1d_plot(data_add)
end
