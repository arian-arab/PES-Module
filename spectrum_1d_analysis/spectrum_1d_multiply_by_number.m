function spectrum_1d_multiply_by_number(data)
input_values = inputdlg({'Multiply by:'},'',1,{'10'});
if isempty(input_values)==1
    return
else
    num=str2double(input_values{1,1});
    for k=1:length(data)
        data{k}.y_data = data{k}.y_data*num;
    end
    spectrum_1d_plot(data)
end
end