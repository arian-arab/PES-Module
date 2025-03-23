function spectrum_3d_save_data_as_h5(data)
[file,path] = uiputfile('.h5','Save Volume Data as HDF5 File');
if file==0
    return
else
    f = waitbar(0,'saving file');
    x_step = data.x_data(2)-data.x_data(1);
    y_step=data.y_data(2)-data.y_data(1);
    z_step=data.z_data(2)-data.z_data(1);
    v_data = data.v_data;
    x_initial=data.x_data(1);
    y_initial=data.y_data(1);
    z_initial=data.z_data(1);
    info = data.info;
    scale = [0 y_step x_step z_step ;0 y_initial x_initial z_initial] ;    
    v_data=permute(v_data,ndims(v_data):-1:1);
    h5create(fullfile(path,file),'/Matrix',[size(v_data,1) size(v_data,2) size(v_data,3)])
    h5write(fullfile(path,file),'/Matrix',v_data)
    h5writeatt(fullfile(path,file),'/Matrix','IGORWaveScaling',scale)
    h5writeatt(fullfile(path,file),'/Matrix','IGORWaveNote',info)
    waitbar(1,f,'saving file')
    close(f)
end
end