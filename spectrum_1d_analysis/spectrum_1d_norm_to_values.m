function spectrum_1d_norm_to_values(data)
[file_name,path] = uigetfile('*.txt','Select Norm Values','MultiSelect','off');
if isequal(file_name,0)
    return
else
    values=dlmread(fullfile(path,file_name));
    if length(values)==length(data)
        for k=1:length(data)
            data{k}.y_data = data{k}.y_data-values(k);        
        end        
        spectrum_1d_plot(data)
    end
end