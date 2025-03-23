function data_load = load_igor_ibw()
[file_name,path] = uigetfile('*.ibw','Select .ibw File(s)','MultiSelect','on');
if isequal(file_name,0)
    data_load=[];
else
    file_name=cellstr(file_name);
    f=waitbar(0,'Please wait...');
    for i=1:size(file_name,2)
        url=fullfile(path,file_name{i});
        try
            data_igor = load_igor_ibw_inside(url);
            
            if isequal(data_igor.type,'3d')
                data_load{i}.x_data = data_igor.x_data;
                data_load{i}.y_data = data_igor.y_data;
                data_load{i}.z_data = data_igor.z_data;
                data_load{i}.v_data = data_igor.v_data;
                data_load{i}.type='spectrum_3d';
                data_load{i}.info= {};
                data_load{i}.name=file_name{i}(1:end-3);
            elseif isequal(data_igor.type,'2d')
                data_load{i}.x_data = data_igor.x_data;
                data_load{i}.y_data = data_igor.y_data;
                data_load{i}.c_data = data_igor.c_data;
                data_load{i}.type='spectrum_2d';
                data_load{i}.info= {};
                data_load{i}.name=file_name{i}(1:end-3);
            end
            waitbar(i/size(file_name,2),f,'Please wait...');
            clear data_igor
        catch
            msgbox(strcat('Either file selected is not h5 data or "Matrix" attribution does not exitst for file named : ',file_name));
            data_load{i}=[];
        end
    end
    close(f)
    data_load = data_load(~cellfun('isempty',data_load));
end
end

function data_igor = load_igor_ibw_inside(file)
data = IBWread(file);
exp_data = data.y;
if length(size(exp_data))==3
    x0 = data.x0;
    dx = data.dx;
    x_data = x0(1):dx(1):(x0(1)+(size(exp_data,1)-1)*dx(1));
    y_data = x0(2):dx(2):(x0(2)+(size(exp_data,2)-1)*dx(2));
    z_data = x0(3):dx(3):(x0(3)+(size(exp_data,3)-1)*dx(3));
    data_igor.x_data = x_data;
    data_igor.y_data = y_data;
    data_igor.z_data = z_data;
    data_igor.v_data = exp_data;
    data_igor.type = '3d';
elseif length(size(exp_data))==2
    x0 = data.x0;
    dx = data.dx;
    x_data = x0(1):dx(1):(x0(1)+(size(exp_data,1)-1)*dx(1));
    y_data = x0(2):dx(2):(x0(2)+(size(exp_data,2)-1)*dx(2));
    data_igor.x_data = y_data;
    data_igor.y_data = x_data;
    data_igor.c_data = exp_data;
    data_igor.type = '2d';
end
end