function spectrum_2d_normalize_along(data)
for k=1:length(data)   
    c_data = data{k}.c_data;
    for i=1:size(c_data,1)
        c_data(i,:) = c_data(i,:)-min(c_data(i,:));
        c_data(i,:) = c_data(i,:)/max(c_data(i,:));
    end    
    data{k}.c_data = c_data;
    clear c_data
end
spectrum_2d_plot(data)
end
