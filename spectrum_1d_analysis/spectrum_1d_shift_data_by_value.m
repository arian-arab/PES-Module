function spectrum_1d_shift_data_by_value(data)
input_values = inputdlg({'shift to value:'},'',1,{'0'});
if isempty(input_values)==1
    return
else
    value=str2double(input_values{1,1});    
    for k=1:length(data)
        data{k}.x_data = data{k}.x_data-value;
    end
    spectrum_1d_plot(data)
end