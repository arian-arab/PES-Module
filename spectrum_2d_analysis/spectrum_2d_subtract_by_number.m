function spectrum_2d_subtract_by_number(data)
input_values = inputdlg({'Subtract by:'},'',1,{'10'});
if isempty(input_values)==1
    return
else
    num=str2double(input_values{1,1});
    for k=1:length(data)
        data{k}.c_data = data{k}.c_data-num;
    end
    spectrum_2d_plot(data)
end
end