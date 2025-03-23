function spectrum_1d_hilbert_transform(data)
for k=1:length(data)
    data{k}.y_data = imag(hilbert(data{k}.y_data));
end
spectrum_1d_plot(data);
end