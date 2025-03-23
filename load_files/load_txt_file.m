function data_load = load_txt_file()
[file_name,path] = uigetfile('*.txt','Select .txt File(s)','MultiSelect','on');
if isequal(file_name,0)
    data_load=[];
else
    file_name=cellstr(file_name);
    f=waitbar(0,'Please wait...');
    for i=1:size(file_name,2)                
        try
            data_read=double(dlmread(fullfile(path,file_name{1,i})));
            if data_read(2,1)<data_read(1,1)
                data_read = flipud(data_read);
            end
        catch
            msgbox(strcat('data should be a matrix with two columns, data selected is not a spectrum data : ',file_name{1,i}));
            data_load{i}=[];            
            continue
        end         
        if size(data_read,2)==2
            data_load{i}.x_data=data_read(:,1);
            data_load{i}.y_data=data_read(:,2);
            data_load{i}.name=file_name{1,i}(1:end-4);
            data_load{i}.type = 'spectrum_1d';
            data_load{i}.info = 'NaN';
            waitbar(1,f,'Please wait...');
        elseif size(data_read,2)>2
            data_load{i}.x_data = (1:1:1+(size(data_read,2)-1)*1)';
            data_load{i}.y_data = (1:1:1+(size(data_read,1)-1)*1)';   
            data_load{i}.c_data = data_read;
            data_load{i}.name=file_name{1,i}(1:end-4);
            data_load{i}.type = 'spectrum_2d';
            data_load{i}.info = 'NaN';            
        else
            data_load=[];            
        end
        waitbar(i/size(file_name,2),f,'Please wait...');        
        clear data_read
    end
    close(f)
    data_load = data_load(~cellfun('isempty',data_load));    
end