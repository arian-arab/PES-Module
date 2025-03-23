function spectrum_2d_save_h5(data)
[file,path] = uiputfile('.h5','Save Image Data as HDF5 File');
if file==0
    return
else
    f = waitbar(0,'saving file');
    data = data{1};
    x_step = data.x_data(2)-data.x_data(1);
    y_step=data.y_data(2)-data.y_data(1);
    
    x_initial=data.x_data(1);
    y_initial=data.y_data(1);

    info = data.info;
    scale = [y_step x_step;y_initial x_initial] ;    
    
    c_data = data.c_data;
    h5create(fullfile(path,file),'/Matrix',[size(c_data,1) size(c_data,2)])
    h5write(fullfile(path,file),'/Matrix',c_data)
    h5writeatt(fullfile(path,file),'/Matrix','IGORWaveScaling',scale)
    h5writeatt(fullfile(path,file),'/Matrix','IGORWaveNote',info)
    waitbar(1,f,'saving file')
    close(f)
end
end