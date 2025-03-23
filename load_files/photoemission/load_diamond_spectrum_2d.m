function data_load = load_diamond_spectrum_2d()
InputValues = inputdlg({'x_data Attribute:','y_data Attribute','c_data Attribute'},'Enter Attributes',1,{'binding_energy','y_scale','image'});
if isempty(InputValues)
    data_load=[];
else
    x_data_att=InputValues{1};
    y_data_att=InputValues{2};
    c_data_att=InputValues{3};
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
            try
                c_data=h5read(fullfile(path,file_name{i}),strcat(field,'/',c_data_att));
            catch
                msgbox('c_data_attribute does not exist in the file')
                data_load{i}=[];
                break
            end
            if x_data(2)<x_data(1)
                x_data = flipud(x_data);
                c_data = flipud(c_data);
            end
            if y_data(2)<y_data(1)
                y_data = flipud(y_data);
                c_data = fliplr(c_data);
            end
            data_load{i}.x_data = y_data;
            data_load{i}.y_data = x_data;
            data_load{i}.c_data=c_data;
            data_load{i}.type='spectrum_2d';
            data_load{i}.name=file_name{i}(1:end-4);
            data_load{i}.info='NaN';
            waitbar(i/size(file_name,2),f,'Please wait...')
            clear filed file_info x_data y_data c_data
        end
        close(f)
        data_load = data_load(~cellfun('isempty',data_load));
    end
end
end