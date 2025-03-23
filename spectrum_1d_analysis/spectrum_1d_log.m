function spectrum_1d_log(data)
for k=1:length(data)
    data{k}.y_data = real(log10(data{k}.y_data));
end
spectrum_1d_plot(data);
end