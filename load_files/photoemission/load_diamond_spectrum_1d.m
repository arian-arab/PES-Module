function data_load = load_diamond_spectrum_1d()
input_values = inputdlg( {'x_data Attribute:','y_data Attribute'},'Enter Attributes',1,{'binding_energy','spectrum'});
if isempty(input_values)==1
    data_load=[];
else
    x_data_att=input_values{1};
    y_data_att=input_values{2};
    [file_name,path] = uigetfile('*.nxs','Select Diamond File(s)','MultiSelect','on');
    if isequal(file_name,0)
        data_load=[];
    else
        file_name=cellstr(file_name);
        f=waitbar(0,'Please wait...');
        for i=1:size(file_name,2)
            try
                file_info = h5info(fullfile(path,file_name{i}));
            catch
                msgbox('selected file is not diamond data file')
                data_load{i}=[];
                break
            end
            try
                field=getfield(file_info.Groups.Groups,'Name');
            catch
                msgbox('selected file is not diamond data file')
                data_load{i}=[];
                break
            end
            try
                x_data=h5read(fullfile(path,file_name{i}),strcat(field,'/',x_data_att));
            catch
                msgbox('x_data_attribute does not exist in the file')
                data_load{i}=[];
                break
            end
            try
                y_data=h5read(fullfile(path,file_name{i}),strcat(field,'/',y_data_att));
            catch
                msgbox('y_data_attribute does not exist in the file')
                data_load{i}=[];
                break
            end
            if x_data(2)<x_data(1)
                x_data = flipud(x_data);
                y_data = flipud(y_data);
            end
            data_load{i}.x_data=x_data;
            data_load{i}.y_data=y_data;
            data_load{i}.type='spectrum_1d';
            data_load{i}.name=file_name{i}(1:end-4);
            data_load{i}.info='NaN';
            waitbar(i/size(file_name,2),f,'Please wait...')
            clear x_data y_data file_info field
        end
        close(f)
        data_load = data_load(~cellfun('isempty',data_load));
    end
end
end