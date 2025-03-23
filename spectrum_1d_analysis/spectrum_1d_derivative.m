function spectrum_1d_derivative(data)
for k=1:length(data)
    data{k}.y_data = diff(data{k}.y_data);
    data{k}.x_data = data{k}.x_data(1:end-1);
end
spectrum_1d_plot(data);
end