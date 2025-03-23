function spectrum_1d_normalize_area(data)
for k=1:length(data)
    area = trapz(data{k}.x_data,data{k}.y_data);
    data{k}.y_data = data{k}.y_data/area;
end
spectrum_1d_plot(data)
end