function spectrum_2d_reflect(data)
for k=1:length(data)   
    data{k}.c_data = (data{k}.c_data+fliplr(data{k}.c_data))/2;
end
    spectrum_2d_plot(data)
end