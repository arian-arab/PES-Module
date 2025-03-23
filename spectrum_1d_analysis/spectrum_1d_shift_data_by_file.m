function spectrum_1d_shift_data_by_file(data)
[file_name,path] = uigetfile('*.txt','Select Shift Values','MultiSelect','off');
if isequal(file_name,0)
    return
else
    try
        values=dlmread(fullfile(path,file_name));
        if length(values)==length(data)
            data_shift = data;
            for k=1:length(data)
                data_shift{k}.x_data = data{k}.x_data-values(k);
            end
            spectrum_1d_plot(data_shift)
        else
            msgbox('number of values and number of files are not consistent')            
        end
    catch
        msgbox('can not read values file')
    end
end
end