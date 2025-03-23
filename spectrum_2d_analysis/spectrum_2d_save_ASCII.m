function spectrum_2d_save_ASCII(data)
path=uigetdir('C:\');
if isequal(path,0)
    return
else    
    for k=1:length(data)
        f = waitbar(0,'Saving data');
        x_data_to_save = data{k}.x_data;
        y_data_to_save = data{k}.y_data;
        c_data_to_save = data{k}.c_data;
        dlmwrite(strcat(fullfile(path,data{k}.name),'_x_data.txt'),x_data_to_save,'precision',12)
        dlmwrite(strcat(fullfile(path,data{k}.name),'_y_data.txt'),y_data_to_save,'precision',12)
        dlmwrite(strcat(fullfile(path,data{k}.name),'_c_data.txt'),c_data_to_save,'precision',12)
        clear x_data_to_save y_data_to_save c_data_to_save
        waitbar(1,f,'Finished')
        close(f)
    end
end
end