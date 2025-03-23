function spectrum_2d_normalize(data)
for k=1:length(data)
    data{k}.c_data = data{k}.c_data-min(data{k}.c_data(:));
    data{k}.c_data = data{k}.c_data/max(data{k}.c_data(:));
end
    spectrum_2d_plot(data)
end