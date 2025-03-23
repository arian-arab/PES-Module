function spectrum_2d_normalize_to(data)
for k=1:length(data)
    min_x(k) = min(data{k}.x_data);
end
InputValues = inputdlg({'normalize to:'},'',1,{num2str(min(min_x))});
if isempty(InputValues)==1
    return
else
    to_value = str2double(InputValues{1});
    for k=1:length(data)    
        x_data = data{k}.x_data;
        c_data = data{k}.c_data;        
        [~,I]=min(abs(x_data-to_value));
        norm_value = sum(c_data(:,I))/size(c_data,1);
        data{k}.c_data = data{k}.c_data-norm_value; 
        clear x_data c_data I norm_value
    end
    spectrum_2d_plot(data)
end    
end