function data_load = load_igor_h5()
[file_name,path] = uigetfile('*.h5','Select .h5 File(s)','MultiSelect','on');
if isequal(file_name,0)
    data_load=[];
else
    file_name=cellstr(file_name);
    f=waitbar(0,'Please wait...');
    for i=1:size(file_name,2)
        url=fullfile(path,file_name{i});
        try
            data_igor=h5read(url,'/Matrix');
        catch
            msgbox(strcat('Either file selected is not h5 data or "Matrix" attribution does not exitst for file named : ',file_name));
            data_load{i}=[];
        end
        
        data_igor=permute(data_igor,ndims(data_igor):-1:1);
        data_igor=double(data_igor);
        note = h5readatt(url,'/Matrix','IGORWaveNote');
        scale = h5readatt(url,'/Matrix','IGORWaveScaling');
        
        if length(size(data_igor))==2
            x_initial = scale(2,3);
            x_step = scale(1,3);
            y_initial = scale(2,2);
            y_step = scale(1,2);
            x_data = (x_initial:x_step:x_initial+(size(data_igor,2)-1)*x_step)';
            y_data = (y_initial:y_step:y_initial+(size(data_igor,1)-1)*y_step)';
            if x_data(2)<x_data(1)
                x_data = flipud(x_data);
                c_data = fliplr(c_data);
            end
            if y_data(2)<y_data(1)
                y_data = flipud(y_data);
                c_data = flipud(c_data);
            end 
            data_load{i}.x_data = x_data;
            data_load{i}.y_data = y_data;
            data_load{i}.c_data = data_igor;
            data_load{i}.info = note;
            data_load{i}.type = 'spectrum_2d';
            data_load{i}.name = file_name{i}(1:end-3);
        end
        
        if length(size(data_igor))==3
            if scale(1,4)==0
                z_initial = scale(2,4);
                z_step = 1;
            else
                z_initial = scale(2,4);
                z_step = scale(1,4);
            end
            x_initial = scale(2,2);
            x_step = scale(1,2);
            y_initial = scale(2,3);
            y_step = scale(1,3);
            x_data = x_initial:x_step:x_initial+(size(data_igor,1)-1)*x_step;
            y_data = y_initial:y_step:y_initial+(size(data_igor,2)-1)*y_step;
            z_data = z_initial:z_step:z_initial+(size(data_igor,3)-1)*z_step;
            data_load{i}.x_data = x_data;
            data_load{i}.y_data = y_data;
            data_load{i}.z_data = z_data;
            data_load{i}.v_data = data_igor;
            data_load{i}.type='spectrum_3d';
            data_load{i}.info=note;
            data_load{i}.name=file_name{i}(1:end-3);
        end
        waitbar(i/size(file_name,2),f,'Please wait...');
    end    
    close(f)    
    data_load = data_load(~cellfun('isempty',data_load));
end
end