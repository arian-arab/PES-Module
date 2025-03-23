function spectrum_1d_save_ASCII(data)
path=uigetdir('C:\');
if isequal(path,0)
    return
else    
    f = waitbar(0,'Saving data');
    for k=1:length(data)        
        data_to_save(:,1)=data{k}.x_data;
        data_to_save(:,2)=data{k}.y_data;
        dlmwrite(strcat(fullfile(path,data{k}.name),'.txt'),data_to_save,'precision',12)
        clear data_to_save
        waitbar(k/length(data),f,'Finished')
        close(f)
    end
end
end