function spectrum_2d_shift_x_data_by_value(data)
input_values = inputdlg({'shift to value:'},'',1,{'0'});
if isempty(input_values)==1
    return
else
    value=str2double(input_values{1,1});    
    data_shift = data;
    for k=1:length(data)
        data_shift{k}.x_data = data{k}.x_data-value;
    end    
end
spectrum_2d_plot(data_shift)
end