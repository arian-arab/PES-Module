function spectrum_2d_log(data)
for k=1:length(data)
    data{k}.c_data = abs(log(data{k}.c_data));
    data{k}.c_data(data{k}.c_data==Inf) = 0;
end
    spectrum_2d_plot(data)
end