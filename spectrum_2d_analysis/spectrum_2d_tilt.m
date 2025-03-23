function spectrum_2d_tilt(data)
InputValues = inputdlg({'slope:','b:'},'',1,{'1','0'});
if isempty(InputValues)==1
    return
else
    slope = str2double(InputValues{1});
    b = str2double(InputValues{2});    
    for k=1:length(data)
        try
            x_data = data{k}.x_data;
            x = slope*x_data+b;
            data{k}.c_data = data{k}.c_data.*x';
            clear x_data x
        catch
            x_data = data{k}.x_data;
            x = slope*x_data+b;
            data{k}.c_data = data{k}.c_data.*x;
            clear x_data x
            
        end
    end
    spectrum_2d_plot(data)
end    
end