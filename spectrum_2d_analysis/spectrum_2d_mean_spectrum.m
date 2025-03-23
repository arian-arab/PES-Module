function spectrum_2d_mean_spectrum(data)
for k=1:length(data)
    length_x_data(k) = length(data{k}.x_data);
    length_y_data(k) = length(data{k}.y_data);
end
n_x = max(length_x_data);
n_y = max(length_y_data);
for k=1:length(data)
    xq = linspace(data{k}.x_data(1),data{k}.x_data(end),n_x);
    yq = linspace(data{k}.y_data(1),data{k}.y_data(end),n_y);
    x = data{k}.x_data;
    y = data{k}.y_data;
    c = data{k}.c_data;
    c_data_interp = interp2(x,y,c,xq,yq');
    data{k}.x_data = xq;
    data{k}.y_data = yq;
    data{k}.c_data = c_data_interp;
    clear xq yq c_data_interp x y c
end

add = data{1}.c_data-data{1}.c_data;
for k=1:length(data)
    add = add+data{k}.c_data;
end
add = add/length(data);
data_add{1}.x_data = data{1}.x_data;
data_add{1}.y_data = data{1}.y_data;
data_add{1}.c_data = add;
data_add{1}.name='mean spectrum';
data_add{1}.type = 'spectrum_2d';
data_add{1}.info = 'NaN';
spectrum_2d_plot(data_add)
end