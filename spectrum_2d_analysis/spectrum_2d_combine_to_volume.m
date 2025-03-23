function spectrum_2d_combine_to_volume(data)
input_values = inputdlg({'z start:','z step:'},'',1,{'1','1'});
if isempty(input_values)==1
    return
else
    z_start = str2double(input_values{1});
    z_step = str2double(input_values{2});
    z_data = z_start:z_step:z_start+(length(data)-1)*z_step;
    for k=1:length(data)
        size_c_1(k) = size(data{k}.c_data,1);
        size_c_2(k) = size(data{k}.c_data,2);
    end
    log_1 = unique(size_c_1)>1;
    log_2 = unique(size_c_2)>1;
    if log_1(1) || log_2(1)
        n_x = max(size_c_1);
        n_y = max(size_c_2);        
        for k=1:length(data)
            xq = linspace(data{k}.x_data(1),data{k}.x_data(end),n_x);
            yq = linspace(data{k}.y_data(1),data{k}.y_data(end),n_y);
            x = data{k}.x_data;
            y = data{k}.y_data;
            c = data{k}.c_data;
            data{k}.c_data = interp2(x,y,c,xq,yq');
            data{k}.x_data = xq;
            data{k}.y_data = yq;            
            clear c_data_interp x y c xq yq
        end
    end
    xq = linspace(data{k}.x_data(1),data{k}.x_data(end),n_x);
    yq = linspace(data{k}.y_data(1),data{k}.y_data(end),n_y);
    for k=1:length(data)
        v_data(:,:,k) = data{k}.c_data;
    end
    data_to_send.x_data = yq;
    data_to_send.y_data = xq;
    data_to_send.z_data = z_data;
    data_to_send.v_data = v_data;
    data_to_send.type = 'spectrum_3d';
    data_to_send.info = 'NaN';
    data_to_send.name = 'VolumeData';
    spectrum_3d_plot(data_to_send)
end
end