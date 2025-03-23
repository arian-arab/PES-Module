function spectrum_2d_derivative(data)
for k=1:length(data)
    data{k}.c_data = diff(data{k}.c_data);
    data{k}.y_data = data{k}.y_data(1:end-1);
end
    spectrum_2d_plot(data)
end