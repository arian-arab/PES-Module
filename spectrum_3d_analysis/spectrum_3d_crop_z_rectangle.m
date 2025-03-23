function spectrum_3d_crop_z_rectangle(data)
subplot(2,2,1)
rec_coordinates = getrect();
if isempty(rec_coordinates)
    return
else
    x1 = rec_coordinates(1);
    x2 = x1+rec_coordinates(3);
    y1 = rec_coordinates(2);
    y2 = y1+rec_coordinates(4);
    x_data = data.x_data;
    y_data = data.y_data;
    v_data = data.v_data;
    [~,XI1]=min(abs(x_data-x1));
    [~,XI2]=min(abs(x_data-x2));
    [~,YI1]=min(abs(y_data-y1));
    [~,YI2]=min(abs(y_data-y2));
    I1=min(XI1,XI2);
    I2=max(XI1,XI2);
    I3=min(YI1,YI2);
    I4=max(YI1,YI2);
    if I1==I2 || I3==I4
        return
    else
        v_data_rec = v_data(I1:I2,I3:I4,:);
        x_data_rec = x_data(I1:I2);
        y_data_rec = y_data(I3:I4);
    end
    c_data_1 = sum(v_data_rec,1);
    c_data_1 = permute(c_data_1,[2 3 1]);
    c_data_2 = sum(v_data_rec,2);
    c_data_2 = permute(c_data_2,[1 3 2]); 
    
    data_to_send_1{1}.x_data = data.z_data;
    data_to_send_1{1}.y_data = y_data_rec;
    data_to_send_1{1}.c_data = c_data_1;
    data_to_send_1{1}.type = 'spectrum_1d';
    data_to_send_1{1}.info = 'NaN';
    data_to_send_1{1}.name = [data.name,'_rec_crop'];

    spectrum_2d_plot(data_to_send_1)
    
    data_to_send_2{1}.x_data = data.z_data;
    data_to_send_2{1}.y_data = x_data_rec;
    data_to_send_2{1}.c_data = c_data_2;
    data_to_send_2{1}.type = 'spectrum_1d';
    data_to_send_2{1}.info = 'NaN';
    data_to_send_2{1}.name = [data.name,'_rec_crop'];

    spectrum_2d_plot(data_to_send_2)    
    
end
end